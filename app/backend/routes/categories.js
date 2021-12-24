const express = require('express')
const router = express.Router()
const Category = require('../models/category')

// to get all categories
router.get('/', async (req, res) => {
    try {
        const category = await Category.find()
        res.json(category)
    } catch (err) {
        res.status(500).json({ message: err.message })
    }
})

// to get a single category
router.get('/:id', getCategory, (req, res) => {
    res.json(res.category)
})

// to create a new service
router.post('/', async (req, res) => {
    const category = new Category({
        name: req.body.name
    })
    try {
        const newCategory = await category.save()
        res.status(201).json(newCategory)
    } catch (err) {
        res.status(400).json({ message: err.message })
    }
})

// to delete a service
router.delete('/:id', getCategory, async (req, res) => {
    try {
        await res.category.remove()
        res.json({ message: 'category deleted successfully!' })
    } catch (err) {
        res.status(500).json({ message: err.message })
    }
})

// a middleware to retrieve a category from the database
// this should be called when the user is connecting to a specific category
// i.e. GET (one category), DELETE, PUT, PATCH, etc.
async function getCategory(req, res, next) {
    let category
    try {
        category = await Category.findById(req.params.id)
        if (category == null) {
            // returning the statement because the middleware has to be stopped immediately
            return res.status(404).json({ message: 'cannot find a category for the given ID!' })
        }
    } catch (err) {
        res.status(500).json({ message: err.message })
    }
    // the category is attached to the 'res' object, as a variable
    res.category = category
    next()
}

module.exports = router