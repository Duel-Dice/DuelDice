import express from 'express';
import 'express-async-errors';

import cors from 'cors';
import morgan from 'morgan';
import helmet from 'helmet';
import passport from 'passport';
import cookieParser from 'cookie-parser';

import * as error from './modules/error.js';
import * as passportStrategy from './modules/passport.js';

import config from './config/index.js';
import routes from './routes/index.js';
import * as db from './db/database.js';

const app = express();

app.use(cors({}));
app.use(morgan('tiny'));
app.use(helmet());
app.use(cookieParser());
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

app.use(passport.initialize());
passport.use(passportStrategy.JWT);

app.use('/', routes());

app.use(error.errorPageNotFound);
app.use(error.errorHandler);

db.Sequelize.sync();

app.listen(config.host.port, '0.0.0.0');
