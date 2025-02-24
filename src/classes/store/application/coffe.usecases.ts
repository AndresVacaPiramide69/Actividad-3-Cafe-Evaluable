import { hash } from "../../../context/security/encrypt";
import Coffe from "../../coffe/domain/Coffe";
import Store from "../domain/Store";
import StoreRepository from "../domain/store.repository";

export default class StoreUseCases{
    constructor(private storeRepo:StoreRepository){}

    async getCoffesFromStore(tienda:Store){
        return await this.storeRepo.getCafesFromTienda(tienda);
    }

    async createStore(tienda:Store){
        if(!tienda.domicilio || !tienda.email || !tienda.domicilio || !tienda.password)throw new Error('Faltan datos');

        tienda.password = hash(tienda.password)

        return await this.storeRepo.createTienda(tienda)
    }
    
    async getNombreTiendas():Promise<Store[]>{
        return await this.storeRepo.getNombreTiendas();
    }

    async createCoffe(cafe:Coffe, tienda:Store):Promise<Coffe>{

        if(!cafe.nombre || !cafe.origen || !cafe.precio || !cafe.peso || !cafe.tueste) {
            throw new Error('Faltan datos del café');
        }

        return await this.storeRepo.createCoffe(cafe, tienda);
    }
}