import {noteService} from '../services/note.service.js';

export const noteController = {
    async getAllNote(req, res) 
    {
        try {
        const data = await noteService.findAllNote();
        res.json(data);
        } catch (err) {
            res.status(500).json({ error: err.message });
        }
    },
}