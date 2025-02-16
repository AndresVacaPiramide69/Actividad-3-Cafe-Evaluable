import UserPostgresRepository from "../infrastructure/db/user.postgres";
import User from "../domain/User";
import UserRepository from "../domain/user.repository";
import { hash, compare } from '../../../context/security/encrypt';


export default class UserUseCases{
    constructor(private repository: UserRepository){
    }

    async createUser(user: User): Promise<User> {

        if(!user.nombre || !user.email || !user.password || !user.domicilio)
            throw new Error('Faltan datos');

        user.password = hash(user.password);

        const userFromDB = await this.repository.createUser(user);
        return userFromDB;
    }

    async login(user: User): Promise<User> {

        if(!user.email || !user.password)
            throw new Error('Faltan datos');

        const userFromDb = await this.repository.login(user)

        const equals = compare(user.password, userFromDb.password);

        if(!equals)
            throw new Error('Usuario o contraseña incorrectos');

        return userFromDb;
    }

    async findByEmail(email: string): Promise<User | null> {
        return this.repository.findByEmail(email);
    }

    async findById(id: number): Promise<User | null> {
        return this.repository.findById(id);
    }
}