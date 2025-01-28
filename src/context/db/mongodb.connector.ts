import { MongoClient, Db, Collection } from 'mongodb'
import dotenv from 'dotenv';

dotenv.config();

const dbUrl = process.env.MONGO_URL;
const dbName = process.env.MONGO_DB_NAME;
const collections: { [key: string]: Collection } = {};

async function createMongoConnection() {
    try {
        const client = await MongoClient.connect(String(dbUrl));
        const db = client.db(dbName);
        addCollections(db);
        console.log('Connected to MongoDB')        
    } catch (error) {
        console.error(error.message)
    }
}

const addCollections = (db:Db)=> {
    collections.users = db.collection('users');
    collections.coffe = db.collection('coffe');
    collections.pedidos = db.collection('pedidos')
}

export default createMongoConnection;
export { collections }