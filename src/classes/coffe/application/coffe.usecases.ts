import Coffe from "../domain/Coffe";
import CafeRepository from "../domain/coffe.repository";
import CafePostgresRepository from "../infrastructure/db/coffe.postgresdb";

export default class CafeUseCases{
    constructor(private cafeRepo:CafeRepository){}

    async getAll():Promise<Coffe[]>{
        return this.cafeRepo.getAllCafes()
    }

    async getCafesByFiltro(filtro: Coffe,
            precioMin: number,
            precioMax: number,
            orderByNombre: string,
            paginaActual: number
        ): Promise<{ cafes: Coffe[]; currentPage: number; totalCoffes: number, paginasTotales:number}> {
        return await this.cafeRepo.getCafesByFiltro(filtro, precioMin, precioMax, orderByNombre, paginaActual);
    }

    async getAllTuestes():Promise<Coffe[]>{
        return await this.cafeRepo.getAllTuestes();
    }
}