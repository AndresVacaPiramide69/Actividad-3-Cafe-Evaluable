import Coffe from "../../domain/Coffe";
import CafeRepository from "../../domain/coffe.repository";
import executeQuery from '../../../../context/db/postgresdb.connector';

export default class CafePostgresRepository implements CafeRepository{
    
    async getAllCafes(): Promise<Coffe[]> {

        const query = 'SELECT * FROM "cafe"'

        const rows = await executeQuery(query);

        if(rows.length === 0){
            throw new Error("Error en la busqueda");
        }

        return rows;    
    }
}