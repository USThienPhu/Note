import {noteController} from '../controllers/note.controller.js';
import express from 'express';
const router = express.Router();

router.get('/', noteController.getAll);
router.get('/:id', noteController.getById);

export default router;