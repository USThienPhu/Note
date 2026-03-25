import express from 'express';
import mongoose from 'mongoose';
import router from './routes/note.route.js';

const app = express();
app.use(express.json());

mongoose.connect(process.env.MONGO_URI)
  .then(() => console.log('Connected MongoDB'))
  .catch(err => console.log(err));

  
app.use('/api/notes', router);

export default app;