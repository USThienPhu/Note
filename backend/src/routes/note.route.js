import {noteController} from '../controllers/note.controller.js';
import express from 'express';
import {verifyToken} from '../middlewares/auth.middleware.js';
const router = express.Router();

router.use(verifyToken);
//Note router
router.get('/', noteController.getAll);
router.get('/:id', noteController.getById);
router.post('/', noteController.create);
router.put('/:id', noteController.update);
router.delete('/:id', noteController.delete);

export default router;