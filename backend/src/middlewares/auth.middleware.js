import jsonwebToken from 'jsonwebtoken';

export const verifyToken = (req, res, next) => {
    const token = req.headers.authorization?.split(' ')[1];
    if (!token){
        return res.status(401).json({message: "Restrict"});
    }

    try {
        const verified = jsonwebToken.verify(token, process.env.JWT_SECRET);
        req.user = verified;
        next();
    
    } catch (err) {
        res.status(400).json({ message: 'Token không hợp lệ' });
    }
}