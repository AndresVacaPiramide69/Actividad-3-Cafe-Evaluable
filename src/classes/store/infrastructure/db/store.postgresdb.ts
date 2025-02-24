import Store from '../../domain/Store';
import StoreRepository from '../../domain/store.repository';
import executeQuery from '../../../../context/db/postgresdb.connector';
import Coffe from '../../../coffe/domain/Coffe';
export default class StorePostgresRepository implements StoreRepository {

    async getCafesFromTienda(tienda: Store): Promise<Store[]> {
        const cafesOfStore = await executeQuery(
            `SELECT * FROM "cafe" WHERE tienda_nombre = '${tienda.nombre}'
             AND tienda_email = '${tienda.email}'`
        )

        return cafesOfStore;
    }

    async createTienda(tienda: Store): Promise<Store> {

        const insertedStore = await executeQuery(
            `INSERT INTO "tienda" (nombre, email, password, domicilio)
             VALUES (\'${tienda.nombre}\', \'${tienda.email}\', \'${tienda.password}\', \'${tienda.domicilio}\') RETURNING *`
        )

        if (!insertedStore) throw new Error('No se ha podido crear la tienda');


        const storeApi: Store = {
            nombre: insertedStore[0].nombre,
            email: insertedStore[0].email,
        }

        return storeApi;
    }

    async getNombreTiendas(): Promise<Store[]> {
        return await executeQuery('SELECT nombre FROM "tienda"');
    }

    async createCoffe(cafe: Coffe, tienda: Store): Promise<Coffe> {

        const adminFromDB = await executeQuery(
            `SELECT * FROM "tienda" WHERE nombre = '${tienda.nombre}' AND email = '${tienda.email}'`
        )

        if (!adminFromDB.length) {
            throw new Error('Tienda no encontrada');
        }

        const insertedCoffe = await executeQuery(
            `INSERT INTO "cafe" (nombre, origen, tueste, tienda_nombre, tienda_email, precio, peso)
             VALUES ('${cafe.nombre}', '${cafe.origen}', '${cafe.tueste}', '${tienda.nombre}', '${tienda.email}', ${cafe.precio}, ${cafe.peso}) RETURNING *`
        );

        if(!insertedCoffe.length)
            throw new Error('No se ha podido insertar');
            

        return insertedCoffe[0];
    }
}