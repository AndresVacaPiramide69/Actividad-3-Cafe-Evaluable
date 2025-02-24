import express, { Request, Response } from 'express'
import CartRepository from '../../domain/cart.repository'
import CartPostgresRepository from '../db/cart.postgresdb'
import CartUseCases from '../../application/cart.usecases'
import { isAuth } from '../../../../context/security/auth'
import Cart from '../../domain/Cart'
import User from '../../../user/domain/User'
import Coffe from '../../../coffe/domain/Coffe'

const cartRepo:CartRepository = new CartPostgresRepository();
const cartUseCases:CartUseCases = new CartUseCases(cartRepo);

const router = express.Router();

router.get('/', isAuth, async(req:Request, res:Response) => {

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

router.post('/addToCart', isAuth, async(req:Request, res:Response) => {
    try {
        console.log(req.body)
        const { nombre , email } = req.body;
        const { coffe } = req.body;
        // console.log(nombre, email);

        const cartFromDb = await cartUseCases.addToCart({nombre, email}, coffe);

        if(cartFromDb)
            res.status(200).json(cartFromDb)

        else res.status(500).send({message:'No hay cart'})
    } catch (error) {
        // Manejar errores
         res.status(500).send({ message: error.message || 'Error interno del servidor' });
    }
});

router.put('/decrementCoffe', isAuth, async(req:Request, res:Response) => {
    try {
        const { nombre , email } = req.body;
        const { coffe } = req.body;
        console.log(coffe)

        const cartFromDb = await cartUseCases.decrementCoffeCart(coffe, {nombre, email});
        console.log(cartFromDb)
        if(cartFromDb)
            res.status(200).json(cartFromDb)

        else res.status(500).send({message:'No hay cart'})
    } catch (error) {
        // Manejar errores
         res.status(500).send({ message: error.message || 'Error interno del servidor' });
    }
});

router.delete('/deleteCoffeFromCart', isAuth, async(req:Request, res:Response) => {
    try {
        
        const { nombre, email } = req.body
        const { coffe } = req.body

        const cartFromDb = await cartUseCases.deleteCoffeFromCart(coffe, { nombre, email })


        if(!cartFromDb)
            res.status(400).send({message:'Error de peticion'})

        else res.status(200).json(cartFromDb)
    } catch (error) {
        res.status(400).send({message:error.message})
    } 
});
export { router as routerCarrito };