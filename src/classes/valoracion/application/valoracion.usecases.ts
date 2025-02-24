import Coffe from "../../coffe/domain/Coffe";
import User from "../../user/domain/User";
import Valoracion from "../domain/Valoracion";
import ValoracionRepository from "../domain/valoracion.repository";

export default class ValoracionUseCases{
    constructor(private valoracionRepo:ValoracionRepository){}


    async cafesPorValorar(user:User):Promise<Coffe[]>{
        return await this.valoracionRepo.getCafesParaValorar(user);
    }

    async valorarCafe(cafe:Coffe, user:User, valoracion:number):Promise<Valoracion>{

        if(!valoracion || isNaN(valoracion))
            throw new Error("Faltan datos");
            

        return await this.valoracionRepo.valorarCafe(cafe, user, valoracion)
    }
}