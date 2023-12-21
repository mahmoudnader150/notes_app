/* eslint-disable prefer-const */
/* eslint-disable no-const-assign */
/* eslint-disable node/no-unsupported-features/es-syntax */
const Note = require('../models/noteModel');
 

exports.createNote = async (req, res) => {
    try{

        const newNote = await Note.create(req.body);

        res.status(201).json({
            status: 'success',
            data:{
                note:newNote
            }
        })

    }catch(err){
        res.status(400).json({
            status:'fail',
            message:err
        })
    }  
    
 }

 
 

exports.getAllNotes = async (req,res)=>
{ 
    try{
        console.log(req.query)
        // 1A) filtering
        const queryObj = { ...req.query };
        const excludedFields = ['page', 'sort', 'limit', 'fields']; // Corrected variable name
        excludedFields.forEach(field => delete queryObj[field]);
        console.log(queryObj);
       
        // 1B) Advance filtering
    
        let queryStr = JSON.stringify(queryObj); // Change from const to let
        queryStr = queryStr.replace(/\b(gte|gt|lte|lt)\b/g, match => `$${match}`);
        console.log(JSON.parse(queryStr));
      
        let query = Note.find(JSON.parse(queryStr));
        
        // 2) Sorting
        if(req.query.sort){ 
            const sortBy = req.query.sort.split(',').join(' '); 
            query = query.sort(sortBy);
        }else{
            query = query.sort('-createdAt');
        }

        // 3) field limiting
        if(req.query.fields){
            const fields = req.query.fields.split(',').join(' ');
            query = query.select(fields);
        }else{
            query = query.select('-__v')
        }
        

        // 4) pagination
        const page = req.query.page * 1 || 1;
        const limit = req.query.limit * 1 || 100;
        const skip = (page-1) *limit;

        query = query.skip(skip).limit(limit);
   
        if(req.query.page){
            const numNotes = await Note.countDocuments();
            if(skip>=numNotes) throw new Error('This page does not exist');
        }


        // EXECUTE QUERY
        const notes = await query;

        


        res.status(200).json({
            status:'success',
            results: notes.length,
            data:{
                notes
            }
        });   
    }catch(err){
        res.status(404).json({
            status:'fail',
            message:err
        })
    }
 }

exports.getNote =  async(req,res)=>{ 
 
        const Note = await Note.findById(req.params.id);

        console.log(Note);
        res.status(200).json({
            status:'success',
            data:{
              Note
            }
        });
     } 
 

 

exports.updateNote = async (req, res)=>{
     
     try{
        const note = await Note.findByIdAndUpdate(req.params.id, req.body, {
            new : true,
            runValidators : true
        })

        res.status(200).json({
            status:'success',
            data:{
                note
            }
        });   

     }catch(err){
        res.status(500).json({
                        status:'fail',
                        message:err
        })
     }
  
 }

exports.deleteNote = async (req,res)=>{ 
   
    try{
        const note = await Note.findByIdAndDelete(req.params.id);

        res.status(204).json({
            status:'success',
            data:null
        });
    }
    catch(err){
        res.status(404).json({
            status:'fail',
            message:err
})
    }   
 }
