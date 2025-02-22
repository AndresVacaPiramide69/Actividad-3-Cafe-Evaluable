import { NextFunction, Request, Response } from "express";
import jwt, { Secret } from "jsonwebtoken";
import User from '../../classes/user/domain/User';
import Store from '../../classes/store/domain/Store';
import executeQuery from "../db/postgresdb.connector";

const SECRET_KEY: Secret = "totyclave";

const decode = (token:string) => {
    return jwt.decode(token);
}

const createAdminToken = (tienda:Store, isAdmin:boolean):string => {
    const payload = {
        isAdmin:isAdmin,
        adminName:tienda.nombre,
        adminEmail:tienda.email
    }
    return jwt.sign(payload, SECRET_KEY, { expiresIn: '1 days'})
}

const createToken = (user:User):string => {
    const payload = {
        nombre:user.nombre,
        direccion:user.domicilio,
        email:user.email
    }
    return jwt.sign(payload, SECRET_KEY, { expiresIn: '1 days'})
}

const isAuth = (req:Request, res:Response, next:NextFunction) => {
    try {
        const authHeader = req.headers['authorization'];
        const token: string | undefined = authHeader && authHeader.split(' ')[1];

        if(token){
            const decoded:any = jwt.verify(token, SECRET_KEY);
            req.body.nombre = decoded.nombre;
            req.body.domicilio = decoded.domicilio
            req.body.email = decoded.email
            next();
        }else{
            res.status(401).json({message:'No autorizado'} )
        }
    } catch (error) {
        console.error(error);
        res.status(401).json({ mensaje: "No autorizado" });
    }
}

const isAdmin = async(req: Request, res: Response, next: NextFunction) => {
    try {
        const authHeader = req.headers['authorization'];
        const token: string | undefined = authHeader && authHeader.split(' ')[1];
        
        if (token) {
            const decoded: any = jwt.verify(token, SECRET_KEY);
            if (decoded.isAdmin) {
                req.body.adminName = decoded.adminName;
                req.body.adminEmail = decoded.adminEmail;

                const { adminName, adminEmail } = req.body;

                const existAdmin = await executeQuery(
                    `SELECT nombre FROM "tienda"
                     WHERE nombre = \'${adminName}\'
                     AND email = \'${adminEmail}\'`
                )
                
                if(!existAdmin || existAdmin.length === 0 )
                    res.status(403).json( { message : 'No tienes permisos'})
                else next();
            } else {
                res.status(403).json({ message: "No tienes permisos de administrador" });
            }
        } else {
            res.status(401).json({ message: "No autorizado" });
        }
    } catch (error) {
        console.error(error.message);
        res.status(401).json({ message: "No autorizado" });
    }
};

export { decode, createToken, isAuth, createAdminToken, isAdmin }