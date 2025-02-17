import Coffe from "../domain/Coffe";
import CafeRepository from "../domain/coffe.repository";
import CafePostgresRepository from "../infrastructure/db/coffe.postgresdb";

export default class CafeUseCases{
    constructor(private cafeRepo:CafeRepository){}

    async getAll():Promise<Coffe[]>{
        return this.cafeRepo.getAllCafes()
    }
}