// Database configurations

const mongoos = require('mongoose');
require('dotenv').config()

const uri=process.env.DB_URI 

const connectDB = async () =>{

    try{
        const connect = await mongoos.createConnection(uri).asPromise();
        console.log(`Connected to  the DB ,(${connect.connection})`)
    }catch(err){
        console.log(`DB Error: ${err.message}`)
        process.exit(1)
    }
}

module.exports = connectDB