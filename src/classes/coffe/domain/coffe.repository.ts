import Coffe from './Coffe';
export default interface CafeRepository{
    getAllCafes():Promise<Coffe[]>
    getCafesByFiltro(filtro: Coffe, precioMin:number, precioMax:number, orderByNombre:string):Promise<Coffe[]>
}