import mongoose from 'mongoose';

const noteSchema = new mongoose.Schema({
    title: String,
    content: String,
    owner: {
        type: mongoose.Schema.Types.ObjectId, 
        ref: 'User'
    },
    createAt: {
        type: Date,
        default: Date.now
    },
})

export default mongoose.model('Note', noteSchema);