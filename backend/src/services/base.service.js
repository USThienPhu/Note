class BaseService {
    constructor(model){
        this.model = model;
    }

    async getAll()
    {
        const notes = await this.model.find();
        return notes;
    }

    async getByID(id)
    {
        const note = await this.model.findById(id);
        return note;
    }

    async create(data)
    {
        const item = new this.model(data);
        return await item.save();
    }
}

export default BaseService;