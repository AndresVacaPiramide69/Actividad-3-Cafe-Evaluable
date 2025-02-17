import express, { Request, Response} from 'express';
import { createToken, isAuth } from '../../../../context/security/auth';
import UserPostgresRepository from '../db/user.postgres';
import UserUseCases from '../../application/user.usecases';
import User from '../../domain/User';
import UserRepository from '../../domain/user.repository';

const userPostgresRepo:UserRepository = new UserPostgresRepository();
const userUseCases = new UserUseCases(userPostgresRepo);

const router = express.Router();

router.post('/registro', async(req:Request, res:Response) => {
    try {
        const { nombre, email, password, domicilio } = req.body

        const apiUser:User = {
            nombre:nombre,
            email:email,
            domicilio:domicilio,
            password:password
        }

        const userFromDb = await userUseCases.createUser(apiUser)
        if(!userFromDb)
            res.status(400).send({Mensaje:'Error de creacion del usuario'})
        else {
            const token = createToken(userFromDb);
            res.status(201).send({ Token : token});
        }
    } catch (error) {
        res.status(400).json({Mensaje:error.message})
    }
});

router.post('/login', async(req:Request, res:Response) => {
    try {
        const { email, password } = req.body
        const apiUser:User = {
            email:email,
            password:password
        }

        const userFromDb = await userUseCases.login(apiUser)
        if(!userFromDb)
            res.status(400).send({Mensaje:'Error de inicio de sesion'})
        else {
            const token = createToken(userFromDb);
            res.status(201).send({token});
        }
    } catch (error) {
        res.status(400).json({Mensaje:error.message})
    }
});

export { router as routerUser}