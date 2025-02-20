import CartRepository from "../domain/cart.repository";
import CartPostgresRepository from "../infrastructure/db/cart.postgresdb";
import Cart from "../domain/Cart";
import User from "../../user/domain/User";
import Coffe from "../../coffe/domain/Coffe";
export default class CartUseCases{
    constructor(private cartRepo:CartRepository){}

    async getCarritoUser(user:User){
        if(!user.email || !user.nombre)
            throw new Error('Faltan datos')

        return await this.cartRepo.getCarritoUser(user);
    }

    async addToCart(user:User, coffe:Coffe){
        // if(!user.email || !user.nombre || !coffe.emailTienda || !coffe.nombreTienda || !coffe.nombre || !coffe.origen)
            // throw new Error('Faltan datos');

         return await this.cartRepo.addToCart(coffe, user);
    }


    async decrementCoffeCart(cafe:Coffe, user:User){
        return await this.cartRepo.decrementCoffeCart(cafe, user)
    }
}