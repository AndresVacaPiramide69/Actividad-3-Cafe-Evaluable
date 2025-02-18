import User from "../../../user/domain/User";
import Cart from "../../domain/Cart";
import CartRepository from "../../domain/cart.repository";
import executeQuery from '../../../../context/db/postgresdb.connector';
import Coffe from "../../../coffe/domain/Coffe";
import bcrypt from 'bcrypt';

export default class CartPostgresRepository implements CartRepository{
    
    async getCarritoUser(user: User): Promise<Cart[]> {

        const query = `SELECT * FROM "carrito" WHERE 
        'nombre_usuario' = '${user.nombre}' 
        AND 'email_usuario' = '${user.email}'`;
        
        const rows = await executeQuery(query);
        return rows;
    }

    async addToCart(cafe: Coffe, user:User): Promise<Cart[]> {

        const userFromDB = await executeQuery(
            `SELECT * FROM "user" WHERE nombre = '${user.nombre}' AND email = '${user.email}'`
        )

        if(!userFromDB || userFromDB.length === 0)throw new Error('No hay usuario');
        

        const userApi:User = {
            nombre: userFromDB[0].nombre,
            email: userFromDB[0].email,
            password: userFromDB[0].password,
            domicilio: userFromDB[0].domicilio
        }
        
        const cafeFromDb = await executeQuery(
            `SELECT * FROM "cafe" WHERE nombre = $1 
            AND origen = $2 
            AND tueste = $3 
            AND tienda_nombre = $4 
            AND tienda_email = $5`,
            [cafe.nombre, cafe.origen, cafe.tueste, cafe.nombreTienda, cafe.emailTienda]
        );

        console.log(cafeFromDb)
        
        if(!cafeFromDb) throw new Error('El café no se ha encontrado');

        return[]
    }
}