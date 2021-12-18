// models of the user

const mongoose = require('mongoose');

const userScema = new mongoose.Schema({
    first_name:{
        type : String,
        required: true
    },
    last_name:{
        type : String,
        required: true
    }
    // TODO
})

const User = mongoose.model('User' , userScema )
module.exports=User;
