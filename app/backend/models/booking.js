const mongoose = require('mongoose')

const bookingSchema = mongoose.Schema({
    userId: {
        type: mongoose.Types.ObjectId,
        required: true,
        ref: 'User'
    },
    serviceId: {
        type: mongoose.Types.ObjectId,
        required: true,
        ref: 'Service'
    },
    description: {
        type: String,
        required: true
    },
    date: {
        type: Date,
        required: true,
        default: Date.now
    },
    isReviewed: {
        type: Boolean,
        required: true,
        default: false
    },
    isAccepted: {
        type: Boolean,
        required: true,
        default: false
    }
})

module.exports = mongoose.model('Booking', bookingSchema)