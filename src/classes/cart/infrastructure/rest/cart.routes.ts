import express, { Request, Response } from 'express'
import CartRepository from '../../domain/cart.repository'
import CartPostgresRepository from '../db/cart.postgresdb'
import CartUseCases from '../../application/cart.usecases'
import { isAuth } from '../../../../context/security/auth'
import Cart from '../../domain/Cart'
import User from '../../../user/domain/User'

const cartRepo:CartRepository = new CartPostgresRepository();
const cartUseCases:CartUseCases = new CartUseCases(cartRepo);

const router = express.Router();

router.post('/', isAuth, async(req:Request, res:Response) => {

    try {
        const { email, nombre } = req.body;

        const apiUser:User = {
            email:email,
            nombre:nombre
        }

        const carritoFromDB = await cartUseCases.getCarritoUser(apiUser);

        if(!carritoFromDB)
            res.status(400).send({message:'Error de peticion'})

        else res.status(200).send(carritoFromDB)
    } catch (error) {
        res.status(400).send({message:error.message})
    }
});

export { router as routerCarrito };