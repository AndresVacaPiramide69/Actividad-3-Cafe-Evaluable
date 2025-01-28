// import { NextFunction, Request, Response } from "express";
// import jwt, { Secret } from "jsonwebtoken";
// import User from '../../users/domain/User';

// const SECRET_KEY: Secret = "totyclave";

// const decode = (token:string) => {
//     return jwt.decode(token);
// }

// const createAdminToken = (user:User, isAdmin:boolean):string => {
//     const payload = {
//         isAdmin:isAdmin,
//         id:user.id,
//         alias:user.alias
//     }
//     return jwt.sign(payload, SECRET_KEY, { expiresIn: '1 days'})
// }

// const createToken = (user:User):string => {
//     const payload = {
//         id:user.id,
//         alias:user.alias
//     }
//     return jwt.sign(payload, SECRET_KEY, { expiresIn: '1 days'})
// }

// const isAuth = (req:Request, res:Response, next:NextFunction) => {
//     try {
//         const authHeader = req.headers['authorization'];
//         const token: string | undefined = authHeader && authHeader.split(' ')[1];

//         if(token){
//             const decoded:any = jwt.verify(token, SECRET_KEY);
//             req.body.alias = decoded.alias;
//             req.body.id = decoded.id
//             next();
//         }else{
//             res.status(401).json({message:'No autorizado'} )
//         }
//     } catch (error) {
//         console.error(error);
//         res.status(401).json({ mensaje: "No autorizado" });
//     }
// }

// const isAdmin = (req: Request, res: Response, next: NextFunction) => {
//     try {
//         const authHeader = req.headers['authorization'];
//         const token: string | undefined = authHeader && authHeader.split(' ')[1];
        
//         if (token) {
//             const decoded: any = jwt.verify(token, SECRET_KEY);
//             if (decoded.isAdmin) {
//                 req.body.alias = decoded.alias;
//                 req.body.id = decoded.id;
//                 next();
//             } else {
//                 res.status(403).json({ mensaje: "No tienes permisos de administrador" });
//             }
//         } else {
//             res.status(401).json({ mensaje: "No autorizado" });
//         }
//     } catch (error) {
//         console.error(error.message);
//         res.status(401).json({ mensaje: "No autorizado" });
//     }
// };


// export { decode, createToken, isAuth, isAdmin }