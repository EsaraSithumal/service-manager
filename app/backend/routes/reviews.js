const express = require('express')
const router = express.Router()
const mongoose = require('mongoose')

const Review = require('../models/review')
const Service = require('../models/service')

// to get all reviews
router.get('/', async (req, res) => {
    try {
        const review = await Review.find()
        res.json(review)
    } catch (err) {
        res.status(500).json({ message: err.message })
    }
})

// to get a single review
router.get('/:id', getReview, (req, res) => {
    res.json(res.review)
})

// to create a new service
router.post('/', async (req, res) => {
    const review = new Review({
        userId: req.body.userId,
        serviceId: req.body.serviceId,
        description: req.body.description,
        rating: req.body.rating
        // 'date' is left empty
    })
    try {
        const newReview = await review.save()

        // appending the 'reviewIds' of the service
        const service = await getService(mongoose.Types.ObjectId(req.body.serviceId))
        service.reviewIds.push(newReview._id)
        await service.save()

        res.status(201).json(newReview)
    } catch (err) {
        res.status(400).json({ message: err.message })
    }
    // TODO
    // update service.rating
})

// to delete a service
router.delete('/:id', getReview, async (req, res) => {
    try {
        await res.review.remove()
        res.json({ message: 'review deleted successfully!' })
    } catch (err) {
        res.status(500).json({ message: err.message })
    }
})

// a middleware to retrieve a review from the database
// this should be called when the user is connecting to a specific review
// i.e. GET (one review), DELETE, PUT, PATCH, etc.
async function getReview(req, res, next) {
    let review
    try {
        review = await Review.findById(req.params.id)
        if (review == null) {
            // returning the statement because the middleware has to be stopped immediately
            return res.status(404).json({ message: 'cannot find a review for the given ID!' })
        }
    } catch (err) {
        res.status(500).json({ message: err.message })
    }
    // the review is attached to the 'res' object, as a variable
    res.review = review
    next()
}

// a middleware to retrieve a service from the database,
// given the objectId
async function getService(id) {
    // TODO: validate
    try {
        service = await Service.findById(id)
        return service
    } catch (err) {
        console.log('can\'t find the service!');
    }
}

module.exports = router