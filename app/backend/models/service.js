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
        type: mongoose.Types.ObjectId,      // userSchema ObjectId
        required: true
    },
    categoryId: {
        type: mongoose.Types.ObjectId,      // categorySchema ObjectId
        required: true
    },
    rating: {
        type: Number,
        required: true
    },
    reviewIds: {
        type: [mongoose.Types.ObjectId],    // reviewSchema ObjectId
        required: true
    },
    noOfReviews: {
        type: Number,
        required: true
    }
    // TODO: location, contactNo, email, subCategoryIds
})

module.exports = mongoose.model('Service', serviceSchema)