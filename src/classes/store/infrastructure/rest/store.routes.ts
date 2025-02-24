import express, { Request, Response } from 'express';
import { createAdminToken, isAdmin, isAuth } from '../../../../context/security/auth'
import StoreUseCases from '../../application/coffe.usecases';
import StoreRepository from '../../domain/store.repository';
import StorePostgresRepository from '../db/store.postgresdb';
import Store from '../../domain/Store';

const storeRepository: StoreRepository = new StorePostgresRepository();
const storeUseCases: StoreUseCases = new StoreUseCases(storeRepository);
const router = express.Router();

router.post('/cafeFromStore', isAdmin, async (req: Request, res: Response) => {
    try {
        const { adminEmail, adminName } = req.body
        const storeApi:Store = {
            nombre:adminName,
            email:adminEmail
        }

        const cafesFromBD = await storeUseCases.getCoffesFromStore(storeApi);

        if (!cafesFromBD) {
            res.status(400).send({ message: 'Error peticion' })
        } else res.status(200).send(cafesFromBD)
    } catch (error) {
        res.status(400).send({ message: 'Error peticion' })
    }
});

router.post('/createStore', async(req:Request, res:Response) => {
    try {
        const { nombre, email, direccion, password } = req.body;

        const storeApi:Store = {
            nombre:nombre,
            email:email,
            domicilio:direccion,
            password:password
        }

        const storeFromDB = await storeUseCases.createStore({ nombre, email, domicilio: direccion, password});

        if(!storeFromDB) 
            res.status(400).send({message:'Error de peticion'});
        else {
            const adminToken = createAdminToken(storeFromDB, true);
            res.status(200).send({token:adminToken})
        }
    } catch (error) {
        res.status(400).send({message:error.message});
    }  
})

router.get('/nombres', isAuth, async(req:Request, res:Response) => {
    try {
        
        const nombres = await storeUseCases.getNombreTiendas()
        res.status(200).send(nombres)

    } catch (error) {
        res.status(400).send({ message:error.message })
    }
})

export { router as routerStore};