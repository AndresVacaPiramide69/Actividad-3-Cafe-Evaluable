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
            res.status(400).send({message:'Error de creacion del usuario'})
        else {
            const token = createToken(userFromDb);
            res.status(201).send({token});
        }
    } catch (error) {
        res.status(400).json({message:error.message})
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
            res.status(400).send({message:'Error de inicio de sesion'})
        else {
            const token = createToken(userFromDb);
            res.status(201).send({token});
        }
    } catch (error) {
        res.status(400).json({message:error.message})
    }
});

router.post('/changePassword', isAuth, async(req:Request, res:Response) => {
    try {
        const { password , nombre, email } = req.body;
        const user:User = {
            nombre:nombre,
            email:email,
            password:password
        }
        const changePassword = await userUseCases.changePassword(user);

        res.status(200).send(changePassword)
    } catch (error) {
        res.status(400).send({message:error.message})
    }
})

export { router as routerUser}