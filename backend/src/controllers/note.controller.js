import {noteService} from '../services/note.service.js';
import BaseController from '../controllers/base.controller.js';

class NoteController extends BaseController {
    constructor()
    {
        super(noteService);
    }
}

export const noteController = new NoteController();