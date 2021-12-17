// router for signup
//TODO
const router = require('express').Router();
let User = require('../models/user');

router.route('/signup').post((req, res)=>{
    const first_name = req.body.first_name;
    const last_name = req.body.last_name;
    
    const newUser = new User({
        first_name,
        last_name
    })
    newUser.save()
    .then(() =>{
        res.json('User Added');
    })
    .catch((err)=>{
        console.log(err)
    })
})

module.exports = router;