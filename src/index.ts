import express, { Request, Response, ErrorRequestHandler, NextFunction, Application } from 'express';
import cors from 'cors';
import dotenv from 'dotenv';

dotenv.config();

import usersRoutes from './routes/users';
import prismaErrorCodes from './prismaErrorCodes';

const app: Application = express();

app.use(express.json());
app.use(cors());

// Routes
app.use('/users', usersRoutes);

app.get('/', (req: Request, res: Response) => {
  res.status(200).json({
    msg: 'Hey !',
  });
});

app.use((err: Err, req: Request, res: Response, next: NextFunction) => {
  const statusCode = res.statusCode !== 200 ? res.statusCode : 500;
  res.status(statusCode).json({
    msg: prismaErrorCodes[err.code],
    ...err,
    stack: process.env.NODE_ENV === 'production' ? '🥞' : err.stack,
  });
});

app.listen(process.env.PORT || 5000, () => {
  console.log('Running on 5000...');
});

interface Err extends Error {
  code: string;
  clientVersion: string;
  meta: {
    target: string[];
  };
}
