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

    create = async(req, res) => {
        try{
            const data = await this.service.create(req.body);
            res.status(201).json(data);
        }
        catch (err)
        {
            res.status(400).json({error: err.message});
        }
    }

}

export default BaseController;