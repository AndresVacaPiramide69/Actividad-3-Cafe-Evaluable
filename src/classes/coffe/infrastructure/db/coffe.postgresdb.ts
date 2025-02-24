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

    async getCafesByFiltro(
        filtro: Coffe,
        precioMin: number,
        precioMax: number,
        orderByNombre: string,
        paginaActual: number
    ): Promise<{ Cafes: Coffe[]; currentPage: number; totalCoffes: number }> {

        precioMin = precioMin === undefined || isNaN(precioMin) ? 0 : Number(precioMin);
        precioMax = precioMax === undefined || isNaN(precioMax) ? 10000 : Number(precioMax);


        const itemsPorPage = 14;
        const offset = (paginaActual - 1) * itemsPorPage;

        precioMin = precioMin !== undefined ? Number(precioMin) : 0;
        precioMax = precioMax !== undefined ? Number(precioMax) : 1000000;

        const nombreSearch = filtro.nombre?.normalize('NFD')
            .replace(/[\u0300-\u036f]/g, "")
            .toLowerCase();

        const dataQuery = `
            SELECT *
            FROM cafe
            WHERE 
                precio BETWEEN \'${precioMin}\' AND \'${precioMax}\'
                ${filtro.peso !== undefined ? `AND peso = \'${filtro.peso}\'` : ''}
                ${filtro.tueste ? `AND tueste = '${filtro.tueste}'` : ''}
                ${nombreSearch ? `
                    AND LOWER(unaccent(nombre)) 
                    LIKE LOWER(unaccent('${nombreSearch}%'))
                ` : ''}
            ${orderByNombre === 'ASC' ? 'ORDER BY nombre ASC' : 'ORDER BY nombre DESC'}
            LIMIT ${itemsPorPage}
            OFFSET ${offset}
        `;

        const countQuery = `
            SELECT COUNT(*) as total
            FROM cafe
            WHERE 
                precio BETWEEN ${precioMin} AND ${precioMax}
                ${filtro.peso !== undefined ? `AND peso = ${filtro.peso}` : ''}
                ${filtro.tueste ? `AND tueste = '${filtro.tueste}'` : ''}
                ${nombreSearch ? `
                    AND LOWER(unaccent(nombre)) 
                    LIKE LOWER(unaccent('${nombreSearch}%'))
                ` : ''}
        `;

        const [cafes, totalResult] = await Promise.all([
            executeQuery(dataQuery),
            executeQuery(countQuery)
        ]);

        return {
            Cafes: cafes,
            currentPage: paginaActual,
            totalCoffes: totalResult[0]?.total || 0
        };
    }
    async getAllTuestes(): Promise<Coffe[]> {
        return await executeQuery('SELECT DISTINCT tueste from "cafe"')
    }
}
