import {noteController} from '../controllers/note.controller.js';
import express from 'express';
const router = express.Router();


//Note router
router.get('/', noteController.getAll);
router.get('/:id', noteController.getById);
router.post('/', noteController.create);

export default router;