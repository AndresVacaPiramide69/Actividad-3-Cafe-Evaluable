import Coffe from "../../domain/Coffe";
import CafeRepository from "../../domain/coffe.repository";
import executeQuery from '../../../../context/db/postgresdb.connector';

export default class CafePostgresRepository implements CafeRepository {

    async getAllCafes(): Promise<Coffe[]> {

        const query = 'SELECT * FROM "cafe"'

        const rows = await executeQuery(query);

        if (rows.length === 0) {
            throw new Error("Error en la busqueda");
        }

        return rows;
    }

    async getCafesByFiltro(filtro: Coffe, precioMin: number, precioMax: number, orderByNombre: string): Promise<Coffe[]> {
        precioMin?precioMin = Number(precioMin):undefined;
        precioMax?precioMax = Number(precioMax):undefined;
        // filtro.nombre.normalize('NFD').replace(/[\u0300-\u036f]/g, "").toLocaleLowerCase();
        const query = `
    SELECT *
    FROM cafe
    WHERE 
        precio BETWEEN ${precioMin !== undefined ? precioMin : 0} 
                    AND ${precioMax !== undefined ? precioMax : 1000000}
                        ${filtro.peso !== undefined ? `AND peso = ${filtro.peso}` : ''}
                        ${filtro.tueste !== undefined ? `AND TUESTE = '${filtro.tueste}'`:''}
                        ${filtro.nombre !== undefined ? `AND LOWER(unaccent(nombre)) LIKE LOWER(unaccent('${filtro.nombre}%'))`:''}
                        ${orderByNombre === 'ASC' ? `ORDER BY nombre ASC`:'ORDER BY nombre DESC'}
`;


        const cafes = await executeQuery(query);
        return cafes;
    }
}