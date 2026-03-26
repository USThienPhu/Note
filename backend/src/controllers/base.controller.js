class BaseController {
    constructor(service)
    {
        this.service = service;
    }

    getAll = async(req, res) =>
    {
        try {
            const data = await this.service.getAll();
            res.json(data);
        }
        catch (err){
            res.status(500).json({error: err.message });
        }
    }

    getById = async(req, res) => {
        try {
            const {id } = req.params;
            console.log("ID nhận được từ URL:", id);
            const data = await this.service.getByID(id);
            if (!data)
            {
                res.status(404).json({error: 'Can not find data by id'})
            }
            res.json(data);
        }
        catch (err)
        {
            res.status(400).json({error: 'invalid ID'});
        }
    }

}

export default BaseController;