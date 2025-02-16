import express, { Response, Request} from 'express';
import { routerUser } from './classes/user/infrastructure/rest/user.routes'
import dotenv from 'dotenv'
import cors from 'cors';
dotenv.config();

const app = express();

const allowedOrigins = ["http://localhost:5173", "http://127.0.0.1:5173"];
const options: cors.CorsOptions = {
  origin: allowedOrigins,
};

app.use(cors(options))
app.use(express.json())

const port = 3000;

app.get('/', (req, res) => {
    res.send('Hello World!');
});

app.use('/api/user', routerUser);


app.listen(port, () => {
    console.log(`Server is running at http://localhost:${port}`);
});