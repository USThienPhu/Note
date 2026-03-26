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

}

export default BaseController;