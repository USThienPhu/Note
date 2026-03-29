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
        // MongoDB sẽ tìm bản ghi có _id = noteId VÀ owner = ownerId
        // Nếu không khớp cả 2, nó sẽ không cập nhật gì cả
        return await this.model.findOneAndUpdate(
            { _id: noteId, owner: ownerId }, 
            updateData, 
            { returnDocument: 'after' } // Trả về bản ghi sau khi sửa (thay cho new: true)
        );
    }

    async create(data) {
        return await this.model.create(data);
    }
}

export const noteService = new NoteService();