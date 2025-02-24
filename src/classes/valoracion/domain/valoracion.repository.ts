import Coffe from '../../coffe/domain/Coffe';
import User from '../../user/domain/User';
import Valoracion from './Valoracion'
export default interface ValoracionRepository{

    valorarCafe(cafe:Coffe, user:User, valoracion:number):Promise<Valoracion>
    getCafesParaValorar(user:User):Promise<Coffe[]>
}