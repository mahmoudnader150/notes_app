/* eslint-disable import/newline-after-import */
const mongoose = require('mongoose');

const noteSchema = mongoose.Schema({
    name:{
         type:String, 
         required:[true,'A note must have a name'],
    },
    color:{
         type:String, 
         default: "grey",
    },
    content:{
     type:String,
     trim:true,
    },
    createdAt:{
     type:Date,
     default:Date.now(),
     select: false
    },
    archived:{
        type:Boolean,
        default:false,
    }
 

})

const Note = mongoose.model('Note', noteSchema)

module.exports = Note;
