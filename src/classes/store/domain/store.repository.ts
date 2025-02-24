import Coffe from '../../coffe/domain/Coffe'
import Store from './Store'

export default interface StoreRepository{
    getCafesFromTienda(tienda:Store):Promise<Store[]>
    createTienda(tienda:Store):Promise<Store>
    getNombreTiendas():Promise<Store[]>
    createCoffe(cafe:Coffe, tienda:Store):Promise<Coffe>
}