import Coffe from "../../../coffe/domain/Coffe";
import User from "../../../user/domain/User";
import ValoracionRepository from "../../domain/valoracion.repository";
import executeQuery from '../../../../context/db/postgresdb.connector';
import Valoracion from "../../domain/Valoracion";

export default class ValoracionPostgresRepository implements ValoracionRepository {

    async valorarCafe(cafe: Coffe, user: User, valoracion: number): Promise<Valoracion> {

        const valorarCafe = await executeQuery(
            `INSERT INTO "valoracion" (
            user_nombre, 
            user_email, 
            cafe_nombre, 
            cafe_origen, 
            cafe_tueste, 
            cafe_tienda_nombre, 
            cafe_tienda_email, 
            valoracion
        ) VALUES (
            '${user.nombre}',
            '${user.email}',
            '${cafe.nombre}',
            '${cafe.origen}',
            '${cafe.tueste}',
            '${cafe.nombre}',
            '${cafe.emailTienda}',
            ${valoracion}
        )
        RETURNING *`
        )

        return {}
    }

    async getCafesParaValorar(user: User): Promise<Coffe[]> {

        const cafesForValidar = await executeQuery(
            `SELECT 
        c.nombre AS café,
        c.origen,
        c.tueste,
        t.nombre AS tienda,
        MAX(p.fecha) AS último_pedido,
        COUNT(pc.id_pedido) AS veces_comprado
    FROM "pedido" p
    JOIN "pedido_cafe" pc ON p.id = pc.id_pedido
    JOIN "cafe" c ON 
        pc.cafe_nombre = c.nombre AND
        pc.cafe_origen = c.origen AND
        pc.cafe_tueste = c.tueste AND
        pc.cafe_tienda_nombre = c.tienda_nombre AND
        pc.cafe_tienda_email = c.tienda_email
    JOIN "tienda" t ON c.tienda_nombre = t.nombre AND c.tienda_email = t.email
    LEFT JOIN "valoracion" v ON 
        v.user_nombre = p.user_nombre AND
        v.user_email = p.user_email AND
        v.cafe_nombre = c.nombre AND
        v.cafe_origen = c.origen AND
        v.cafe_tueste = c.tueste AND
        v.cafe_tienda_nombre = c.tienda_nombre AND
        v.cafe_tienda_email = c.tienda_email
    WHERE 
        p.user_nombre = '${user.nombre}' AND 
        p.user_email = '${user.email}' AND
        v.valoracion IS NULL
    GROUP BY 
        c.nombre, c.origen, c.tueste, t.nombre, 
        c.tienda_nombre, c.tienda_email`
        );
        return cafesForValidar;
    }
}