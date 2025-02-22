import User from "../../user/domain/User";
import Order from "../domain/Order";
import OrderRepository from "../domain/order.repository";

export default class OrderUseCases{
    constructor(private orderRepo:OrderRepository) {
    }

    async pedir(user:User):Promise<Order>{
        return await this.orderRepo.pedir(user)
    }
}