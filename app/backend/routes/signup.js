// router for signup
//TODO
const router = require('express').Router();
let User = require('../models/user');

router.post('/' , (req, res)=>{
    const newUser = new User({
        first_name: req.body.first_name,
        last_name:req.body.last_name
    })
    
    newUser.save()
    .then(() =>{
        res.send('User Added');
    })
    .catch((err)=>{
        console.log(err)
    })
})

module.exports = router;