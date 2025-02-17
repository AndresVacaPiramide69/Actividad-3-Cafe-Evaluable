import User from '../../user/domain/User';
import Cart from './Cart';
export default interface CartRepository{

    getCarritoUser(user:User):Promise<Cart[]>
}