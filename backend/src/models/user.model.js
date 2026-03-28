import mongoose from 'mongoose';

const userSchema   = new mongoose.Schema ({
    email: 
    {
        type: String,
        unique: true,
        require: true,
        trim: true,
        lowercase: true
    },
    password: {
        type: String, 
        require: true
    },
}, {timestamps: true});

export default mongoose.model('User', userSchema);