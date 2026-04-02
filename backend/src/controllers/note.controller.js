import {noteService} from '../services/note.service.js';
import BaseController from '../controllers/base.controller.js';

class NoteController extends BaseController {
    constructor()
    {
        super(noteService);
    }

    getAll = async(req, res) => {
        try {
            const userId = req.user.id;
            const data = await this.service.findAllByUser(userId);
            res.json(data);
        } catch (err)
        {
            res.status(500).json({error: err.message});
        }
    }

    create = async(req, res) => {
        const userId = req.user.id;
        const noteData = {
            ...req.body,
            owner: userId
        };

        const data = await this.service.create(noteData);
        res.status(200).json(data);
    }

    delete = async (req, res) => {
        try {
            const { id } = req.params;
            const userId = req.user.id;
            
            const data = await this.service.delete(id, userId);
            
            if (!data) return res.status(404).json({ message: 'Không tìm thấy Note hoặc bạn không có quyền xóa' });
            res.json({ message: 'Xóa thành công' });
        } catch (err) {
            res.status(400).json({ error: 'ID không hợp lệ' });
        }
    }

    update = async (req, res) => {
    try {
        const { id } = req.params; // ID của Note cần sửa
        const userId = req.user.id; // ID của người đang đăng nhập

        const data = await this.service.updateByUser(id, userId, req.body);
        
        if (!data) {
            return res.status(404).json({ 
                message: 'Không tìm thấy Note hoặc bạn không có quyền chỉnh sửa' 
            });
        }
        
        res.json(data);
    } catch (err) {
        res.status(400).json({ error: 'Dữ liệu không hợp lệ hoặc ID sai định dạng' });
    }
}
}

export const noteController = new NoteController();