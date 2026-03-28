import {authService} from "../services/auth.service.js";

class AuthController {
    register = async(req, res) => {
        try{
            const user = await authService.register(req.body);
            res.status(201).json({
                message: 'Đăng ký thành công',
                userId: user._id
            });

        } catch (err)
        {
            res.status(400).json({error: err.message});
        }
    }

    login = async(req, res) => {
        try{
            const {email, password} = req.body;
            const result = await authService.login(email, password);
            res.json(result);
        } catch (err)
        {
            res.status(401).json({error: err.message});
        }
    }
}

export const authController = new AuthController();