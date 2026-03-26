class BaseService {
    constructor(model){
        this.model = model;
    }

    async getAll()
    {
        const notes = await this.model.find();
        return notes;
    }
}

export default BaseService;