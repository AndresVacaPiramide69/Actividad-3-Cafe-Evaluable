import express, { Request, Response } from 'express';
import ValoracionUseCases from '../../application/valoracion.usecases';
import ValoracionRepository from '../../domain/valoracion.repository';
import ValoracionPostgresRepository from '../db/valoracion.postgresdb';
import { isAuth } from '../../../../context/security/auth'
const router = express.Router();
const valoracionRepo:ValoracionRepository = new ValoracionPostgresRepository();
const valoracionUseCases:ValoracionUseCases = new ValoracionUseCases(valoracionRepo);

router.post('/cafesParaValorar', isAuth, async(req:Request, res:Response) => {
    try {
        
        const { nombre, email } = req.body;

        const cafes = await valoracionUseCases.cafesPorValorar({ nombre, email})

        res.status(200).send(cafes);
    } catch (error) {
        res.status(400).send({ message:error.message })
    }
});

router.post('/valorar', isAuth, async(req:Request, res:Response) => {
    try{

        const { nombre, email } = req.body;
        const { coffe, valoracion } = req.body;
        const valoracionFromDb = await valoracionUseCases.valorarCafe(coffe, {nombre, email}, valoracion)

        res.status(200).send(valoracionFromDb);
    }catch(error){
        res.status(400).send({ message:error.message });
    }
})

export { router as routerValoracion }