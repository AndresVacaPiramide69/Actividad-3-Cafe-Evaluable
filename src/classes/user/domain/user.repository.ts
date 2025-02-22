import User from "./User";
export default interface UserRepository {
    createUser(user: User): Promise<User>;
    login(user: User): Promise<User>;
    findByEmail(email: string): Promise<User | null>;
    findById(id: number): Promise<User | null>;
    updatePassword(user:User):Promise<User>
}