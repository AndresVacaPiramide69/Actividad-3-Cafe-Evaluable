import User from "../../domain/User";
import UserRepository from "../../domain/user.repository";
import executeQuery from "../../../../context/db/postgresdb.connector";
export default class UserPostgresRepository implements UserRepository{
    
    async createUser(user: User): Promise<User> {

        const sql = `INSERT INTO users (nombre, email, password, direccion) VALUES ('${user.nombre}', '${user.email}', '${user.password}', '${user.direccion}') RETURNING *`;

        const rows = await executeQuery(sql);

        const insertedUser:User = {
            nombre: rows[0].nombre,
            email: rows[0].email,
            password: rows[0].password,
            direccion: rows[0].direccion
        }

        return insertedUser;
    }

    async login(user: User): Promise<User> {
        const sql = `SELECT * FROM users WHERE email = '${user.email}'`;
        const rows = await executeQuery(sql);

        if(rows.length === 0){
            throw new Error('Usuario o contraseña incorrectos');
        }
        const userFromDb:User = {
            nombre: rows[0].nombre,
            email: rows[0].email,
            password: rows[0].password,
            direccion: rows[0].direccion
        }
        return user;
    }

    async findByEmail(email: string): Promise<User | null> {

        const sql = `SELECT * FROM users WHERE email = '${email}'`;
        const rows = await executeQuery(sql);

        if(rows.length === 0){
            return null;
        }
        const user:User = {
            nombre: rows[0].nombre,
            email: rows[0].email,
            password: rows[0].password,
            direccion: rows[0].direccion
        }
        return user;
    }

    async findById(id: number): Promise<User | null> {
        const sql = `SELECT * FROM users WHERE id = ${id}`;
        const rows = await executeQuery(sql);

        if(rows.length === 0){
            return null;
        }
        const user:User = {
            nombre: rows[0].nombre,
            email: rows[0].email,
            password: rows[0].password,
            direccion: rows[0].direccion
        }
        return user;
    }

}