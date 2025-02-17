import User from "../../../user/domain/User";
import Cart from "../../domain/Cart";
import CartRepository from "../../domain/cart.repository";
import executeQuery from '../../../../context/db/postgresdb.connector';

export default class CartPostgresRepository implements CartRepository{
    
    async getCarritoUser(user: User): Promise<Cart[]> {

        const query = `SELECT * FROM "carrito" WHERE 
        'nombre_usuario' = '${user.nombre}' 
        AND 'email_usuario' = '${user.email}'`;
        
        const rows = await executeQuery(query);
        return rows;
    }
}