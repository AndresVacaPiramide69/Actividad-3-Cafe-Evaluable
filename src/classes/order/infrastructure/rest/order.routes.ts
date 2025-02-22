import express, { Request, Response } from 'express'
import User from '../../../user/domain/User'
import Order from '../../domain/Order'
import OrderUseCases from '../../application/order.usecases'
import OrderRepository from '../../domain/order.repository'
import OrderPostgresRepository from '../db/order.postgresdb'
import { isAuth } from '../../../../context/security/auth';
const orderRepo:OrderRepository = new OrderPostgresRepository()
const orderUseCases:OrderUseCases = new OrderUseCases(orderRepo);

const router = express.Router()

router.post('/pedir', isAuth, async(req:Request, res:Response) => {
    try {
        
        const { nombre, email } = req.body;

        const pedido = await orderUseCases.pedir({ nombre, email})

        if(!pedido)
            res.status(400).send({ message:'Error de peticion'});
                else res.status(200).send(pedido)

    } catch (error) {
        res.status(400).send({ message:error.message })
    }
});

export { router as routerOrder};