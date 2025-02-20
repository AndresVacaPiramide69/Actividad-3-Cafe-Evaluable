import express, { Request, Response} from 'express';
import Coffe from '../../domain/Coffe';
import CafePostgresRepository from '../db/coffe.postgresdb';
import CafeRepository from '../../domain/coffe.repository';
import CafeUseCases from '../../application/coffe.usecases';

const cafeRepo:CafeRepository = new CafePostgresRepository();
const cafeUseCases:CafeUseCases = new CafeUseCases(cafeRepo);

const router = express.Router();
router.get('/', async(req:Request, res:Response) => {

    try {
        const cafes = await cafeUseCases.getAll();


        if(!cafes){
            res.status(400).send({message:'No hay cafes'})
        }
        res.status(200).send(cafes)

    } catch (error) {
        res.status(400).send({message:error.message})
    }

})

router.get('/busqueda', async(req:Request, res:Response) => {
    try {

        const { precioMin } = req.body;
        const {precioMax} = req.body;
        const { orderByNombre } = req.body;


        const {coffe} = req.body;
        const cafes = await cafeUseCases.getCafesByFiltro(coffe, precioMin, precioMax, orderByNombre);

        if(!cafes)
            res.status(400).send({message:'Error de peticion'})
        else res.status(200).send(cafes);
    } catch (error) {
        res.status(400).send({message:error.message})
    }
})

export { router as routerCafes };