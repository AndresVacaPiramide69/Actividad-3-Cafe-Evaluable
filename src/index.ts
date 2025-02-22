import express, { Response, Request} from 'express';
import { routerUser } from './classes/user/infrastructure/rest/user.routes'
import { routerCarrito } from './classes/cart/infrastructure/rest/cart.routes'
import { routerCafes } from './classes/coffe/infrastructure/rest/coffe.routes'
import { routerStore } from './classes/store/infrastructure/rest/store.routes'
import { routerOrder } from './classes/order/infrastructure/rest/order.routes'
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
app.use('/api/cafe', routerCafes);
app.use('/api/cart', routerCarrito);
app.use('/api/store', routerStore);
app.use('/api/order', routerOrder)

app.listen(port, () => {
    console.log(`Server is running at http://localhost:${port}`);
});