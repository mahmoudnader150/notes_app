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
        console.log(err)
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
      
        console.log(queryObj);
       
        // 1B) Advance filtering
    
        let queryStr = JSON.stringify(queryObj); // Change from const to let
       
      
      
        
        // 2) Sorting
       

       

        
        

        // EXECUTE QUERY
        const notes = await Note.find(JSON.parse(queryStr))

        


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
