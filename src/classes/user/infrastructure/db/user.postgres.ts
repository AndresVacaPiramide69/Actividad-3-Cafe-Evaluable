import User from "../../domain/User";
import UserRepository from "../../domain/user.repository";
import executeQuery from "../../../../context/db/postgresdb.connector";
export default class UserPostgresRepository implements UserRepository {

    async createUser(user: User): Promise<User> {
        const sql = `INSERT INTO "user" (nombre, email, password, domicilio) VALUES ('${user.nombre}', '${user.email}', '${user.password}', '${user.domicilio}') RETURNING *`;
        const rows = await executeQuery(sql);

        const userFromDb: User = {
            nombre: rows[0].nombre,
            email: rows[0].email,
            password:rows[0].password,
            domicilio: rows[0].domicilio
        }
        return userFromDb;
    }

    async login(user: User): Promise<User> {

        const sql = `SELECT * FROM "user" WHERE email = '${user.email}'`;
        const rows = await executeQuery(sql);

        if (rows.length === 0) {
            throw new Error('Usuario o contraseña incorrectos');
        }

        const userFromDb: User = {
            nombre: rows[0].nombre,
            email: rows[0].email,
            password: rows[0].password,
            domicilio: rows[0].domicilio
        }
        return userFromDb;
    }

    async findByEmail(email: string): Promise<User | null> {

        const sql = `SELECT * FROM user WHERE email = '${email}'`;
        const rows = await executeQuery(sql);

        if (rows.length === 0) {
            return null;
        }
        const userFromDB: User = {
            nombre: rows[0].nombre,
            email: rows[0].email,
            password: rows[0].password,
            domicilio: rows[0].domicilio
        }
        return userFromDB;
    }

    async findById(id: number): Promise<User | null> {
        const sql = `SELECT * FROM user WHERE id = ${id}`;
        const rows = await executeQuery(sql);

        if (rows.length === 0) {
            return null;
        }
        const userFromDb: User = {
            nombre: rows[0].nombre,
            email: rows[0].email,
            password: rows[0].password,
            domicilio: rows[0].domicilio
        }
        return userFromDb;
    }

    async updatePassword(user: User): Promise<User> {
        const updatedUser = await executeQuery(
            `UPDATE "user" SET password = \'${user.password}\' 
             WHERE email = '${user.email}' 
             AND nombre = '${user.nombre}'
             RETURNING *`
        )

        const userApi: User = {
            nombre: updatedUser[0].nombre,
            email: updatedUser[0].email
        }

        if (!updatedUser || updatedUser.length === 0)
            throw new Error('Error de peticion');
        else return userApi;
    }

}