// models of the user

const mongoose = require('mongoose');
const uniqueValidator = require('mongoose-unique-validator')

const userScema = new mongoose.Schema({
    first_name:{
        type : String,
        required: true
    },
    last_name:{
        type : String,
        required: true
    },
    email:{
        type: String , 
        unique: true , 
        require: true
    },
    password:{
        type : String , 
        required: true
    }
   
})

// validate the email 
userScema.plugin(uniqueValidator , {message: 'Email already in use !'});
module.exports = mongoose.model('User' , userScema );

