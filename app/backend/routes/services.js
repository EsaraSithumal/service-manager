const express = require('express')
const router = express.Router()

const Service = require('../models/service')
const Category = require('../models/category')
const Booking = require('../models/booking')
const authenticateToken = require('../middlewares/auth')

// to get the service details (Admin)
router.get('/profile_admin', authenticateToken, async (req, res) => {
    try {
        const profile = await Service.findById(req.body.serviceId, 'name description categoryId rating reviewIds location')
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
        const profile = await Service.findById(req.body.serviceId, 'name description categoryId rating reviewIds location')
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

// to get all my the services
router.get('/my', authenticateToken, async (req, res) => {
    try {
        const services = await Service.find()
            .where('adminId').equals(req.userId)
            .select('name description rating')
        res.json(services)
    } catch (error) {
        res.status(500).json({ message: err.message })
    }
})

// to get all categories for the new service form
router.get('/new', authenticateToken, async (req, res) => {
    try {
        const categories = await Category.find()
        res.json(categories)
    } catch (error) {
        res.status(500).json({ message: err.message })
    }
})

// to create a new service
router.post('/new', authenticateToken, async (req, res) => {
    // TODO: validate 'adminId' and 'categoryId'
    const service = new Service({
        name: req.userId,
        description: req.body.description,
        adminId: req.body.adminId,
        categoryId: req.body.categoryId,
        rating: 0,
        noOfReviews: 0,
        location: req.body.location
        // 'reviewIds' and 'bookedUserIds' are left empty
    })
    try {
        const newService = await service.save()
        res.status(201).json(newService)
    } catch (err) {
        res.status(400).json({ message: err.message })
    }
})

// to update a service
router.put('/new', authenticateToken, async (req, res) => {
    try {
        await Service.findByIdAndUpdate(req.body.serviceId, {
            name: req.body.name,
            description: req.body.description,
            categoryId: req.body.categoryId,
            location: req.body.location
        })
        res.status(201).json({ message: 'updated successfully!' })
    } catch (err) {
        res.status(400).json({ message: err.message })
    }
})

// to book a service
router.post('/book', authenticateToken, async (req, res) => {
    const booking = new Booking({
        userId: req.userId,
        serviceId: req.body.serviceId,
        description: req.body.description
    })
    try {
        const newBooking = await booking.save()
        
        // appending the 'bookingIds' of the service
        const service = await Service.findById(req.body.serviceId)
        service.bookingIds.push(newBooking._id)

        res.status(201).json(newBooking)
    } catch (err) {
        res.status(400).json({ message: err.message })
    }
})

// to response to a booking
router.put('/book', authenticateToken, async (req, res) => {
    try {
        await Booking.findByIdAndUpdate(req.body.bookingId, {
            isReviewed: true,
            isAccepted: req.body.isAccepted
        })
        res.status(201).json({ message: 'updated successfully!' })
    } catch (err) {
        res.status(400).json({ message: err.message })
    }
})

/////////////////////// for testing purposes ///////////////////////

// to get a single service
router.get('/:id', getService, (req, res) => {
    res.json(res.service)
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