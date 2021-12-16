import express from 'express';
import 'express-async-errors';

import cors from 'cors';
import morgan from 'morgan';
import helmet from 'helmet';
import passport from 'passport';
import cookieParser from 'cookie-parser';

import * as error from './modules/error.js';
import * as swagger from './modules/swagger.js';
import * as passportStrategy from './modules/passport.js';

import config from './config/index.js';
import routes from './routes/index.js';
import * as db from './db/database.js';

const app = express();

app.use('/api/docs', swagger.serve, swagger.setup);

app.use(
  cors({
    origin: true,
    credentials: true,
  }),
);
app.use(morgan('tiny'));
app.use(helmet());
app.use(cookieParser());
app.use(express.json());
app.use(express.urlencoded({ extended: true })); // 폼으로 넘어오는 데이터를 처리하는 것

app.use(passport.initialize());
passport.use(passportStrategy.JWT);

app.use('/api', routes());

app.use(error.errorPageNotFound);
app.use(error.errorHandler);

db.Sequelize.sync();

app.listen(config.host.port, '0.0.0.0');
