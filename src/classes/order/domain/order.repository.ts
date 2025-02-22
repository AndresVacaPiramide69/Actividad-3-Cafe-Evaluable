import Order from "./Order";
import Cart from '../../cart/domain/Cart';
import User from '../../user/domain/User';

export default interface OrderRepository{
    pedir(user:User):Promise<Order>,
}