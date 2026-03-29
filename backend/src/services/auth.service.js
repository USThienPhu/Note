import User from "../models/user.model.js";
import bcryptjs from "bcryptjs";
import jsonwebtoken from 'jsonwebtoken';

class AuthService {
    async register(data){
        const existUser = await User.findOne({email: data.email});
        if (existUser)
        {
            throw new Error("Email already linked to another account");
        }
        const hashedPassword = await bcryptjs.hash(data.password, 10);
        return await User.create({email: data.email, password: hashedPassword, name: data.name});
    }

    async login(email, password)
    {
        const user = await User.findOne({email});
        if (!user) {
            throw new Error("No existed user");
        }
        const isMatch =  await bcryptjs.compare(password, user.password);
        if (!isMatch) {
            throw new Error('Mật khẩu không chính xác');
        }

        const token = jsonwebtoken.sign(
            {
                id: user._id,
                email: user.email,
            },
            process.env.JWT_SECRET,
            { expiresIn: '1d' }
        );

        return {token, user: {id: user._id, email: user.email}};
    }
}

export const authService = new AuthService();