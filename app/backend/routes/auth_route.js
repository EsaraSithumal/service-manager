const express = require('express');
const jwt = require('jsonwebtoken')
const bcrypt = require('bcryptjs')
const router = express.Router()
const userSchema = require('../models/user')
//const authorize = require('../middlewares/auth')
const {check , oneOf,  validationResult} = require('express-validator');
const { application } = require('express');

/**
 * Auth2 authentication
 * issue a web token to correct password and email
 * /auth/signin
 */
 

router.post('/signin' , (req, res, next)=>{
    let getUser ;
    userSchema.findOne({email:req.body.email}) // find the user with given email
    .then((user) =>{
        if(!user){ // if the user doesn't exist send the unauthorized masseage
            return res.status(401).json({message: 'Authentication failed'}); 
        }
        getUser = user;
        // if the user exist in the system, compare the hashed password with stored one
        bcrypt.compare(req.body.password , user.password); 
    })
    .then((response)=>{

        if(!response){ // if the password missmacth return unauthorized message
            return res.status(401).json({message:'Authentication failed'})
        }

        // if the password is match with the given password, create a jwtToken and send it to the user
        // with 200 status code
        let jwtToken = jwt.sign({emai: getUser.email , userId: getUser._id} , process.env.SECRET , {expiresIn: '1h'}) 
        res.status(200).json({token:jwtToken,expiresIN : 3600,msg: getUser});
    })
    .catch((err) =>{
        return res.status(401).json({message:'Authentication failed'})
    })
    
});


/**
 * create a new user (if already not exist) and store in the database with relavant password hash
 * /auth/signin
 */
router.post('/signup' , 
    oneOf([ // sanitizaion the body parameters
        check('first_name').not().isEmpty().isLength({min:3}).withMessage('Name must be at least 3 characters long') , 
        check('last_name').not().isEmpty().isLength({min:3}).withMessage('Name must be at leaat 3 characters long'),
        check('email' , 'Email is not valid').not().isEmpty().isEmail(),
        check('password' , 'Password should be between 5 to 8 characters long').not().isEmpty().isLength({min:5  ,max:8})
    ]),
    (req , res )=>{ 
        const errors =  validationResult(req);
        if(!errors.isEmpty()){ // if there is a error in the parameer retun the 422 status code
            return res.status(422).json(errors.array())
        }else{
            bcrypt.hash(req.body.password,10) // else generate a hash and create user schema
            .then((hash)=>{ 
                const user = new userSchema({
                    first_name: req.body.first_name,
                    last_name:req.body.last_name,
                    email: req.body.email,
                    password:hash
                });

                user.save() // save the schema in the database
                .then((response) =>{
                    res.status(201).json({ // return the success message
                        message: 'User successfully created!',
                        result: response
                    })
                })
                .catch((error) =>{ // if there is a error return a server error
                    res.status(500).json({
                        error:error
                    })
                });
            });
        }
    }
    
)

module.exports = router