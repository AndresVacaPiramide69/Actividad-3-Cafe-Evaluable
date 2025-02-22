import Cart from "../../../cart/domain/Cart";
import User from "../../../user/domain/User";
import Order from "../../domain/Order";
import OrderRepository from "../../domain/order.repository";
import executeQuery from '../../../../context/db/postgresdb.connector';

export default class OrderPostgresRepository implements OrderRepository {

    async pedir(user: User): Promise<Order> {

        const cartFromDb = await executeQuery(
            `SELECT 
        carrito.*, 
        cafe.precio  -- Obtenemos el precio del café
    FROM "carrito"
    INNER JOIN "cafe" ON 
        carrito.cafe_nombre = cafe.nombre AND
        carrito.cafe_origen = cafe.origen AND
        carrito.cafe_tueste = cafe.tueste AND
        carrito.cafe_tienda_nombre = cafe.tienda_nombre AND
        carrito.cafe_tienda_email = cafe.tienda_email
    WHERE 
        carrito.user_nombre = '${user.nombre}' 
        AND carrito.user_email = '${user.email}'`
        )


        const precioTotal = cartFromDb.reduce((total: any, item: any) => {
            return total + (item.precio * item.cantidad);
        }, 0);

        console.log(cartFromDb)

        const insertedOrder = await executeQuery(
            `INSERT INTO "pedido" (fecha, precioTotal, user_nombre, user_email)
             VALUES (NOW(), ${String(precioTotal)}, '${user.nombre}', '${user.email}')
             RETURNING *`
        )

        const insertOrderCafe = await executeQuery(
            `INSERT INTO "pedido_cafe" 
             (id_pedido, cafe_nombre, cafe_origen, cafe_tueste, cafe_tienda_nombre, cafe_tienda_email, cantidad) VALUES 
             ${cartFromDb.map((item: any) => `(${insertedOrder[0].id}, '${item.cafe_nombre}', '${item.cafe_origen}', '${item.cafe_tueste}', '${item.cafe_tienda_nombre}', '${item.cafe_tienda_email}', ${item.cantidad})`).join(", ")}`
        )

        const deletedCart = await executeQuery(
            `DELETE FROM "carrito"
             WHERE user_nombre = '${user.nombre}'
             AND user_email = '${user.email}'`
        );
        
        return insertedOrder;
    }
}