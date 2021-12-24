// models of the user

const mongoose = require('mongoose');
const uniqueValidator = require('mongoose-unique-validator')

const userSchema = new mongoose.Schema({
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
        required: true
    },
    password:{
        type : String , 
        required: true
    }
   
})

// validate the email 
userSchema.plugin(uniqueValidator , {message: 'Email already in use !'});
module.exports = mongoose.model('User' , userSchema );

