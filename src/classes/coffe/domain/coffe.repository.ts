import Coffe from './Coffe';
export default interface CafeRepository{
    getAllCafes():Promise<Coffe[]>
}