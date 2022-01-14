const mongoose = require('mongoose')

const serviceSchema = mongoose.Schema({
    name: {
        type: String,
        required: true
    },
    description: {
        type: String,
        required: true
    },
    adminId: {
        type: mongoose.Types.ObjectId,
        required: true,
        ref: 'User'
    },
    categoryId: {
        type: mongoose.Types.ObjectId,
        required: true,
        ref: 'Category'
    },
    rating: {
        type: Number,
        required: true
    },
    reviewIds: {
        type: [mongoose.Types.ObjectId],
        required: true,
        ref: 'Review'
    },
    noOfReviews: {
        type: Number,
        required: true
    },
    location: {
        type: String,
        required: true
    },
    bookingIds: {
        type: [mongoose.Types.ObjectId],
        required: true,
        ref: 'Booking'
    }
    // TODO: contactNo, email, subCategoryIds
})

module.exports = mongoose.model('Service', serviceSchema)