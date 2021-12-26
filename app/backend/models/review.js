const mongoose = require('mongoose')

const reviewSchema = mongoose.Schema({
    userId: {
        type: mongoose.Types.ObjectId,  // userSchema ObjectId
        required: true
    },
    serviceId: {
        type: mongoose.Types.ObjectId,  // serviceSchema ObjectId
        required: true
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