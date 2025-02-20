import User from "../../../user/domain/User";
import Cart from "../../domain/Cart";
import CartRepository from "../../domain/cart.repository";
import executeQuery from '../../../../context/db/postgresdb.connector';
import Coffe from "../../../coffe/domain/Coffe";
import bcrypt from 'bcrypt';

export default class CartPostgresRepository implements CartRepository {

    async getCarritoUser(user: User): Promise<Cart[]> {

        const query = `SELECT * FROM "carrito" WHERE 
        user_nombre = \'${user.nombre}\' 
        AND user_email = \'${user.email}\'
        ORDER BY cafe_nombre ASC`;

        const rows = await executeQuery(query);
        return rows;
    }

    async addToCart(cafe: Coffe, user: User): Promise<Cart[]> {
        const userFromDB = await executeQuery(
            `SELECT * FROM "user" WHERE nombre = '${user.nombre}' AND email = '${user.email}'`
        )

        if (!userFromDB || userFromDB.length === 0) throw new Error('No hay usuario');


        const userApi: User = {
            nombre: userFromDB[0].nombre,
            email: userFromDB[0].email,
            password: userFromDB[0].password,
            domicilio: userFromDB[0].domicilio
        }


        const queryCafe = `SELECT * FROM "cafe" WHERE nombre LIKE \'${cafe.nombre}\'
            AND origen LIKE \'${cafe.origen}\' 
            AND tueste LIKE \'${cafe.tueste}\' 
            AND tienda_nombre LIKE \'${cafe.nombreTienda}\' 
            AND tienda_email LIKE \'${cafe.emailTienda}\'`
        const cafeFromDb = await executeQuery(queryCafe);


        if (!cafeFromDb || cafeFromDb.length === 0) throw new Error('No existe el café especificado')

        const cafeApi: Coffe = {
            nombre: cafeFromDb[0].nombre,
            origen: cafeFromDb[0].origen,
            tueste: cafeFromDb[0].tueste,
            nombreTienda: cafeFromDb[0].tienda_nombre,
            emailTienda: cafeFromDb[0].tienda_email,
            peso: cafeFromDb[0].peso,
            precio: cafeFromDb[0].precio
        }

        const cartFromDB = await executeQuery(
            `SELECT * FROM "carrito" WHERE 
            user_nombre = '${userApi.nombre}' 
            AND user_email = '${userApi.email}' 
            AND cafe_nombre = '${cafeApi.nombre}' 
            AND cafe_origen = '${cafeApi.origen}' 
            AND cafe_tueste = '${cafeApi.tueste}' 
            AND cafe_tienda_nombre = '${cafeApi.nombreTienda}' 
            AND cafe_tienda_email = '${cafeApi.emailTienda}'`
        )

        if (!cartFromDB || cartFromDB.length === 0) {
            const insertedCart = await executeQuery(
                `INSERT INTO "carrito" (user_nombre, user_email, cafe_nombre, cafe_origen, cafe_tueste, cafe_tienda_nombre, cafe_tienda_email, cantidad) VALUES 
                (\'${userApi.nombre}\', \'${userApi.email}\', \'${cafeApi.nombre}\', \'${cafeApi.origen}\', \'${cafeApi.tueste}\', \'${cafeApi.nombreTienda}\', \'${cafeApi.emailTienda}\', 1) RETURNING *`
            )
            if (!insertedCart || insertedCart.length === 0) throw new Error('No se pudo añadir al carrito');

            return insertedCart;
        } else {
            const updatedCart = await executeQuery(
                `UPDATE "carrito" 
                SET cantidad = cantidad + 1 
                WHERE user_nombre = '${userApi.nombre}' 
                AND user_email = '${userApi.email}' 
                AND cafe_nombre = '${cafeApi.nombre}' 
                AND cafe_origen = '${cafeApi.origen}' 
                AND cafe_tueste = '${cafeApi.tueste}' 
                AND cafe_tienda_nombre = '${cafeApi.nombreTienda}' 
                AND cafe_tienda_email = '${cafeApi.emailTienda}'
                RETURNING *`
            );
            if (!updatedCart || updatedCart.length === 0) throw new Error('No se pudo actualizar el carrito');

            return updatedCart;
        }
    }
    async decrementCoffeCart(cafe: Coffe, user: User): Promise<Cart[]> {

        const cafeFromDb = await executeQuery(
            `SSELECT * FROM "cafe" WHERE nombre LIKE \'${cafe.nombre}\'
            AND origen LIKE \'${cafe.origen}\' 
            AND tueste LIKE \'${cafe.tueste}\' 
            AND tienda_nombre LIKE \'${cafe.nombreTienda}\' 
            AND tienda_email LIKE \'${cafe.emailTienda}\'`
        )

        if (!cafeFromDb || cafeFromDb.length === 0) throw new Error('No existe el café');

        const userFromDB = await executeQuery(
            `SELECT * FROM "user" WHERE nombre = '${user.nombre}' AND email = '${user.email}'`
        )

        if(!userFromDB || cafeFromDb.length === 0)throw new Error("Usuario no encontrado");
        
        const userApi: User = {
            nombre: userFromDB[0].nombre,
            email: userFromDB[0].email,
            password: userFromDB[0].password,
            domicilio: userFromDB[0].domicilio
        }

        const cafeApi: Coffe = {
            nombre: cafeFromDb[0].nombre,
            origen: cafeFromDb[0].origen,
            tueste: cafeFromDb[0].tueste,
            nombreTienda: cafeFromDb[0].tienda_nombre,
            emailTienda: cafeFromDb[0].tienda_email,
            peso: cafeFromDb[0].peso,
            precio: cafeFromDb[0].precio
        }

        const cartFromDb = await executeQuery(
            `SELECT * FROM "carrito" WHERE 
            user_nombre = '${userApi.nombre}' 
            AND user_email = '${userApi.email}' 
            AND cafe_nombre = '${cafeApi.nombre}' 
            AND cafe_origen = '${cafeApi.origen}' 
            AND cafe_tueste = '${cafeApi.tueste}' 
            AND cafe_tienda_nombre = '${cafeApi.nombreTienda}' 
            AND cafe_tienda_email = '${cafeApi.emailTienda}'`
        )

        if(cartFromDb[0].cantidad === '1'){
            const deletedCoffeCart = await executeQuery(
                `DELETE FROM "carrito" WHERE 
                user_nombre = '${userApi.nombre}' 
                AND user_email = '${userApi.email}' 
                AND cafe_nombre = '${cafeApi.nombre}' 
                AND cafe_origen = '${cafeApi.origen}' 
                AND cafe_tueste = '${cafeApi.tueste}' 
                AND cafe_tienda_nombre = '${cafeApi.nombreTienda}' 
                AND cafe_tienda_email = '${cafeApi.emailTienda}' 
                RETURNING *`
            );
            if (!deletedCoffeCart || deletedCoffeCart.length === 0) throw new Error('No se pudo eliminar el café del carrito');
            return deletedCoffeCart;
        }else{
            const updatedCart = await executeQuery(
                `UPDATE "carrito" 
                SET cantidad = cantidad - 1 
                WHERE user_nombre = '${userApi.nombre}' 
                AND user_email = '${userApi.email}' 
                AND cafe_nombre = '${cafeApi.nombre}' 
                AND cafe_origen = '${cafeApi.origen}' 
                AND cafe_tueste = '${cafeApi.tueste}' 
                AND cafe_tienda_nombre = '${cafeApi.nombreTienda}' 
                AND cafe_tienda_email = '${cafeApi.emailTienda}'
                RETURNING *`);
                return updatedCart;
        }
    }
}