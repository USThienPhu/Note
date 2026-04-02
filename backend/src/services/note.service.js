import  Note from '../models/note.model.js';
import BaseService from './base.service.js';

class NoteService extends BaseService  {
    constructor() {
        super(Note);
    }

    async findAllByUser(ownerId)
    {
        return await this.model.find({owner: ownerId});
    }

    async findOneByUser(ownerId, noteId)
    {
        return await this.model.findOne({_id: noteId, owner: ownerId});
    }

    async updateByUser(noteId, ownerId, updateData) {
        return await this.model.findOneAndUpdate(
            { _id: noteId, owner: ownerId }, 
            updateData, 
            { returnDocument: 'after' } 
        );
    }

    async create(data) {
        return await this.model.create(data);
    }

    async delete(noteId, ownerId) {
    return await this.model.findOneAndDelete({
        _id: noteId,
        owner: ownerId 
    });
}

}

export const noteService = new NoteService();