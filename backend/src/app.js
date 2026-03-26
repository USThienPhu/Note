import express from 'express';
import mongoose from 'mongoose';
import noteRouter from './routes/note.route.js';
import authRouter from './routes/auth.rout.js';

const app = express();
app.use(express.json());

mongoose.connect(process.env.MONGO_URI)
  .then(() => console.log('Connected MongoDB'))
  .catch(err => console.log(err));

  
app.use('/api/notes', noteRouter);
app.use('/api/auth', authRouter);

export default app;