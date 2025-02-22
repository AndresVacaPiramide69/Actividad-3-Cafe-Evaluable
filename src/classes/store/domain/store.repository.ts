import Store from './Store'

export default interface StoreRepository{
    getCafesFromTienda(tienda:Store):Promise<Store[]>
    createTienda(tienda:Store):Promise<Store>
}