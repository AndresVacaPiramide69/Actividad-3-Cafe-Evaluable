import CartRepository from "../domain/cart.repository";
import CartPostgresRepository from "../infrastructure/db/cart.postgresdb";
import Cart from "../domain/Cart";
import User from "../../user/domain/User";
export default class CartUseCases{
    constructor(private cartRepo:CartRepository){}

    async getCarritoUser(user:User){
        if(!user.email || !user.nombre)
            throw new Error('Faltan datos')

        return await this.cartRepo.getCarritoUser(user);
    }
}