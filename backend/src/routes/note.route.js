import {noteController} from '../controllers/note.controller.js';
import express from 'express';
const router = express.Router();

router.get('/', noteController.getAllNote);

export default router;