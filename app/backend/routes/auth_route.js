const express = require('express');
const jwt = require('jsonwebtoken')
const bcrypt = require('bcryptjs')
const router = express.Router()
const userSchema = require('../models/user')
//const authorize = require('../middlewares/auth')
const {check , validationResult} = require('express-validator')


router.get('/' , (req, res) =>{
    console.log('Request from a client');
    res.send('Hello from auth')
})

router.post('./signin' , (req, res, next)=>{
    let getUser ;
    userSchema.findOne({email:req.body.email})
    .then((user) =>{
        if(!user){
            return res.status(401).json({message: 'Authentication failed'});
        }
        getUser = user;
        return bcrypt.compare(req.body.password , user.password);
    })
    .then((response)=>{
        if(!response){
            return res.status(401).json({message:'Authentication failed'})
        }
        let jwtToken = jwt.sign({emai: getUser.email , userId: getUser._id} , process.env.SECRET , {expiresIn: '1h'})
        res.status(200).json({token:jwtToken,expiresIN : 3600,msg: getUser});
    })
    .catch((err) =>{
        return res.status(401).json({message:'Authentication failed'})
    })
    
});


router.post(
    '/signup' , 
    [
        check('first_name').not().isEmpty().isLength({min:3}).withMessage('Name must be at least 3 characters long') , 
        check('last_name').not().isEmpty().isLength({min:3}).withMessage('Name must be at leaat 3 characters long'),
        check('email' , 'Email is not valid').not().isEmpty().isEmail(),
        check('password' , 'Password should be between 5 to 8 characters long').not().isEmpty().isLength({min:5 , max:8})
    ],
    (res , req , next)=>{
        const error = validationResult(req);
        if(!errors.isEmpty()){
            return res.status(422).json(errors.array())
        }else{
            bcrypt.hash(req.body.password,10)
            .then((hash)=>{
                const user = new userSchema({
                    first_name: req.body.first_name,
                    last_name:req.body.last_name,
                    email: req.body.email,
                    password:hash
                });

                user.save()
                .then((response) =>{
                    res.status(201).json({
                        message: 'User successfully created!',
                        result: response
                    })
                })
                .catch((error) =>{
                    res.status(500).json({
                        error:error
                    })
                });
            });
        }
    }
    
)

module.exports = router