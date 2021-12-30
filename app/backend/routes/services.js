const express = require('express')
const router = express.Router()

const Service = require('../models/service')
const authenticateToken = require('../middlewares/auth')

// to get the service details (Admin)
router.get('/profile_admin', authenticateToken, async (req, res) => {
    try {
        const profile = await Service.findById(req.body.serviceId, 'name description categoryId rating reviewIds')
            .populate('adminId', 'first_name last_name email')
            .populate('categoryId')
            .populate({
                path: 'reviewIds',
                select: 'userId description rating date',
                populate: {
                    path: 'userId',
                    select: 'first_name last_name'
                }
            })
        res.json(profile)
    } catch (error) {
        res.status(500).json({ message: err.message })
    }
})

// to get the service details
router.get('/profile', authenticateToken, async (req, res) => {
    try {
        const profile = await Service.findById(req.body.serviceId, 'name description categoryId rating reviewIds')
            .populate('adminId', 'first_name last_name email')
            .populate('categoryId')
            .populate({
                path: 'reviewIds',
                select: 'userId description rating date',
                populate: {
                    path: 'userId',
                    select: 'first_name last_name'
                }
            })
        res.json(profile)
    } catch (error) {
        res.status(500).json({ message: err.message })
    }
})

// to get all services
router.get('/', async (req, res) => {
    try {
        const services = await Service.find()
        res.json(services)
    } catch (err) {
        res.status(500).json({ message: err.message })
    }
})

// to get a single service
router.get('/:id', getService, (req, res) => {
    res.json(res.service)
})

// to create a new service
router.post('/', async (req, res) => {
    // TODO: validate 'adminId' and 'categoryId'
    const service = new Service({
        name: req.body.name,
        description: req.body.description,
        adminId: req.body.adminId,
        categoryId: req.body.categoryId,
        rating: 0,
        noOfReviews: 0
        // 'reviewIds' is left empty
    })
    try {
        const newService = await service.save()
        res.status(201).json(newService)
    } catch (err) {
        res.status(400).json({ message: err.message })
    }
})

// to delete a service
router.delete('/:id', getService, async (req, res) => {
    try {
        await res.service.remove()
        res.json({ message: 'service deleted successfully!' })
    } catch (err) {
        res.status(500).json({ message: err.message })
    }
})

// a middleware to retrieve a service from the database
// this should be called when the user is connecting to a specific service
// i.e. GET (one service), DELETE, PUT, PATCH, etc.
async function getService(req, res, next) {
    let service
    try {
        service = await Service.findById(req.params.id)
        if (service == null) {
            // returning the statement because the middleware has to be stopped immediately
            return res.status(404).json({ message: 'cannot find a service for the given ID!' })
        }
    } catch (err) {
        res.status(500).json({ message: err.message })
    }
    // the service is attached to the 'res' object, as a variable
    res.service = service
    next()
}

module.exports = router