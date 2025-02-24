import Coffe from './Coffe';
export default interface CafeRepository {
    getAllCafes(): Promise<Coffe[]>
    getCafesByFiltro(filtro: Coffe,
            precioMin: number,
            precioMax: number,
            orderByNombre: string,
            paginaActual: number): Promise<{ cafes: Coffe[]; currentPage: number; totalCoffes: number, paginasTotales:number }>
    getAllTuestes():Promise<Coffe[]>
}