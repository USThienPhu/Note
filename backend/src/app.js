const express  = require('express');
const mongoose = require('mongoose');
const Note = require('./models/node.model');

const app = express();
app.use(express.json());

mongoose.connect(process.env.MONGO_URI)
  .then(() => console.log('Connected MongoDB'))
  .catch(err => console.log(err));

  


module.exports = app;