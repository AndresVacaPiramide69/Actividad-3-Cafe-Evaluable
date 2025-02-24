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
    ): Promise<{ cafes: Coffe[]; currentPage: number; totalCoffes: number; paginasTotales: number }> {
        
        precioMin = precioMin === undefined || isNaN(precioMin) || !precioMin ? 0 : Number(precioMin);
        precioMax = precioMax === undefined || isNaN(precioMax) || !precioMax ? 10000 : Number(precioMax);
    
        const itemsPorPage = 6;
        const offset = (paginaActual - 1) * itemsPorPage;

        const dataQuery = `
            SELECT *
            FROM cafe
            WHERE 
                precio BETWEEN '${precioMin}' AND '${precioMax}'
                ${filtro.nombre !== undefined ? `AND LOWER(unaccent(nombre)) LIKE LOWER(unaccent('%${filtro.nombre}%'))` : ''}
                ${filtro.peso !== undefined ? `AND peso = '${filtro.peso}'` : ''}
                ${filtro.tueste ? `AND tueste = '${filtro.tueste}'` : ''}
                ${filtro.nombreTienda ? `AND tienda_nombre = '${filtro.nombreTienda}'` : ''}
            ${orderByNombre === 'ASC' ? 'ORDER BY nombre ASC' : 'ORDER BY nombre DESC'}
            LIMIT ${itemsPorPage}
            OFFSET ${offset}
        `;
    
        // Construcción de la consulta para contar los resultados
        const countQuery = `
            SELECT COUNT(*) as total
            FROM cafe
            WHERE 
                precio BETWEEN ${precioMin} AND ${precioMax}
                ${filtro.nombre !== undefined ? `AND LOWER(unaccent(nombre)) LIKE LOWER(unaccent('%${filtro.nombre}%'))` : ''}
                ${filtro.peso !== undefined ? `AND peso = ${filtro.peso}` : ''}
                ${filtro.tueste ? `AND tueste = '${filtro.tueste}'` : ''}
                ${filtro.nombreTienda ? `AND LOWER(unaccent(tienda_nombre)) LIKE LOWER(unaccent('%${filtro.nombreTienda}%'))` : ''}
        `;
    
        // Ejecuta ambas consultas en paralelo
        const [cafes, totalResult] = await Promise.all([
            executeQuery(dataQuery),
            executeQuery(countQuery)
        ]);
    
        // Aseguramos que totalResult[0].total sea un número y calculamos las páginas totales
        const totalCoffes = parseInt(totalResult[0].total) || 0;
        const paginasTotales = Math.ceil(totalCoffes / itemsPorPage);
    
        return {
            cafes: cafes,
            currentPage: paginaActual,
            totalCoffes: totalCoffes,
            paginasTotales: paginasTotales
        };
    }
    

    async getAllTuestes(): Promise<Coffe[]> {
        return await executeQuery('SELECT DISTINCT tueste from "cafe"')
    }
}