// middleware for validate the authtoken

const jwt = require('jsonwebtoken');
require('dotenv').config()


const authenticateToken = (req, res , next) =>{
    try{
        const token = req.header('x-auth-token');
        // console.log("token : " ,token)
        decodeRes= jwt.verify(token,process.env.ACCESS_SECRET )
        req.userId = decodeRes.userId
        req.email = decodeRes.email
        next();
    }catch(error){
        res.status(401).json({message: error.message})
    }
}

module.exports = authenticateToken