const mongoose = require('mongoose')

const reviewSchema = mongoose.Schema({
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
    rating: {
        type: Number,
        required: true
    },
    date: {
        type: Date,
        required: true,
        default: Date.now
    }
})

module.exports = mongoose.model('Review', reviewSchema)