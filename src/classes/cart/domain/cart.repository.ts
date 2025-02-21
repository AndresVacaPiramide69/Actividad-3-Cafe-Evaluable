import Coffe from '../../coffe/domain/Coffe';
import User from '../../user/domain/User';
import Cart from './Cart';
export default interface CartRepository{

    getCarritoUser(user:User):Promise<Cart[]>
    addToCart(cafe:Coffe, user:User):Promise<Cart[]>
    decrementCoffeCart(cafe:Coffe, user:User):Promise<Cart[]>
    deleteCafeFromCart(cafe:Coffe, user:User):Promise<Cart[]>
}