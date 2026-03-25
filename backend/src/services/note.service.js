import  Note from '../models/note.model.js';

export const noteService = {
    async findAllNote()
    {
        return await Note.find();
    },
}