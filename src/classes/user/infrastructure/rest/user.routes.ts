import express, { Request, Response} from 'express';
import { createToken, isAuth } from '../../../../context/security/auth';
import UserPostgresRepository from '../db/user.postgres';
import UserUseCases from '../../application/user.usecases';
import User from '../../domain/User';

const userPostgresRepo = new UserPostgresRepository();
const userUseCases = new UserUseCases(userPostgresRepo);

const router = express.Router();

router.post('/registro', async(req:Request, res:Response) => {
    try {
        

        const { nombre, email, password, domicilio } = req.body
        const apiUser:User = {
            nombre,
            email,
            domicilio,
            password
        }

        const userFromDb = await userUseCases.createUser(apiUser)

        if(!userFromDb)
            res.status(400).send({Mensaje:'Error de creacion del usuario'})
        else {
            const token = createToken(userFromDb);
            res.status(201).send({ Token : token});
        }
    } catch (error) {
        res.status(400).json(error.message)
    }
});

export { router as routerUser}