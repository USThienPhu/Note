import  Note from '../models/note.model.js';
import BaseService from './base.service.js';

class NoteService extends BaseService  {
    constructor() {
        super(Note);
    }
}

export const noteService = new NoteService();