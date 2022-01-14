const express = require('express')
const router = express.Router()

const Service = require('../models/service')
const authenticateToken = require('../middlewares/auth')

// to get search results by categoryId
router.get('/', authenticateToken, async (req, res) => {
    try {
        const result = Service.find()
            .where('categoryId').equals(req.body.categoryId)
        res.json(result)
    } catch (error) {
        res.status(500).json({ message: err.message })
    }
})

module.exports = router