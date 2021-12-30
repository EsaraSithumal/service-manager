const express = require('express');
const jwt = require('jsonwebtoken')
const bcrypt = require('bcryptjs')
const router = express.Router()
const userSchema = require('../models/user')
const authenticateToken = require('../middlewares/auth')
const {check , oneOf,  validationResult} = require('express-validator');
const { application } = require('express');

let refreshTokens = [];

router.post('/protect'  , authenticateToken,(req, res)=>{
    console.log(req.userId);
    res.send('Hello from protected area')
} )

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
        bcrypt.compare(req.body.password , user.password)
        .then((response)=>{

            if(!response){ // if the password missmacth return unauthorized message
                return res.status(401).json({message:'Authentication failed'})
            }
    
            // if the password is match with the given password, create a jwtToken and send it to the user
            // with 200 status code
            let accessToken = jwt.sign({emai: getUser.email , userId: getUser._id} , process.env.ACCESS_SECRET , {expiresIn: '30s'})
            let refreshToken = jwt.sign({emai: getUser.email , userId: getUser._id} , process.env.REFRESH_SECRET ) 
            refreshTokens.push(refreshToken);
            res.status(200).json({refreshToken,accessToken,expiresIN : 3600,msg: getUser});
        })
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
                        message: 'User successfully created!'
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

/**
 * genrate a new access token
 */
router.post('/token' , (req, res)=>{
    refreshToken = req.header('token');

    if(refreshToken ==null) return res.sendStatus(401)
    if(!refreshTokens.includes(refreshToken)){
        return res.sendStatus(403)
    }

    jwt.verify(refreshToken, process.env.REFRESH_SECRET ,(err , result)=>{
        if(err) return res.sendStatus(403)
        
        const accessToken = jwt.sign({email:result.email ,userId: result.userId },process.env.ACCESS_SECRET ,{expiresIn:'1h'});
        return res.json({success: true , accessToken});
    })

})

/**
 * invalidate the refresh token
 * delete the refresh token from array
 */

router.post('/logout' , (req, res) =>{
    refreshTokens = refreshTokens.filter( token => token !== req.header('token'))
    req.sendStatus(204)
})

/**
 * check password as a input and 
 * return 'password_matched' true or false
 */
router.post('/check_password' , (req, res) =>{
    const email = req.body.email

    // find the relavent user 
    userSchema.findOne({email})
    .then((user)=>{
        if(!user){
            return res.status(401).json({message:"Authentication failed"});
        }
        // compaire a the password with stored one
        bcrypt.compare(req.body.password , user.password , password)
        .then((response)=>{
            if(!response){
                return res.status(401).json({password_matched:false})
            }

            return res.status(200).json({password_matched:true})
        })
    })
})

// have to compleate
router.post('/update_password' ,
    oneOf(
    [check('new_password' ,'Passwrod should be between 5 to 8 characters long').not().isEmpty().isLength({min:5 , max:8}),
    check('new_comfirm_password' ,'Passwrod should be between 5 to 8 characters long').not().isEmpty().isLength({min:5 , max:8})
    ]),
    (req, res) =>{
        const error = validationResult(req)
        if(!error.isEmpty()){
            return res.status(422).json(errors.array())
        }else{
            bcrypt.hashSync(req.body.new_password,10)
            .then((hash) =>{
                userSchema.findOneAndUpdate({email:req.body.email} , {password :hash})


                return res.status(200).json({message:'Successfuly Updated'})
            })
        }
    }

)

module.exports = router
