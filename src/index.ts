import express, { Response, Request} from 'express';
import { routerUser } from './classes/user/infrastructure/rest/user.routes'
const app = express();
const port = 3000;

app.get('/', (req, res) => {
    res.send('Hello World!');
});

app.use('/api', routerUser);


app.listen(port, () => {
    console.log(`Server is running at http://localhost:${port}`);
});