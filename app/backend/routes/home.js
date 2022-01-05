const express = require('express')
const router = express.Router()

const User = require('../models/user')
const Service = require('../models/service')
const authenticateToken = require('../middlewares/auth')

// to get the user details
router.get('/profile', authenticateToken, async (req, res) => {
    try {
        const user = await User.findById(req.userId, 'first_name last_name email')
        res.json(user)
    } catch (error) {
        res.status(500).json({ message: err.message })
    }
})

// to update the user details
router.put('/profile', authenticateToken, async (req, res) => {
    try {
        await User.findByIdAndUpdate(req.userId, {
            first_name: req.body.first_name,
            last_name: req.body.last_name
        })
        res.status(201).json({ message: 'updated successfully!' })
    } catch (err) {
        res.status(400).json({ message: err.message })
    }
})

// to get trending services
router.get('/feed', authenticateToken, async (req, res) => {
    try {
        const feed = await Service.find({}, 'name description categoryId rating').populate('categoryId')
        res.json(feed)
    } catch (err) {
        res.status(500).json({ message: err.message })
    }
})

module.exports = router