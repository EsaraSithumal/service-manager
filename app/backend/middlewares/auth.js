// middleware for validate the authtoken

const jwt = require('jsonwebtoken');



const verified = (req, res , next) =>{
    try{
        const token = req.header('x-auth-token');
        jwt.verify(token,process.env.SECRET )
        next();
    }catch(error){
        res.status(401).json({message: "No token cannot authorize"})
    }
}

module.exports = verified