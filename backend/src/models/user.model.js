import mongoose from 'mongoose';

const userSchema   = new mongoose.Schema ({
    email: 
    {
        type: String,
        unique: true,
        required: true,
        trim: true,
        lowercase: true
    },
    password: {
        type: String, 
        required: true
    },
    name:
    {
        type:String,
        unique: false,
        required: true,
    }
}, {timestamps: true});

export default mongoose.model('User', userSchema);