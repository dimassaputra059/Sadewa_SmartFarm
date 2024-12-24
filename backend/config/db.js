const mongoose = require('mongoose');

const connection = mongoose.createConnection('mongodb://localhost:27017/').on('open', ()=>{
      console.log('Connected to MongoDB');
}).on('error', ()=>{
      console.log('Error connecting to MongoDB');
});

module.exports = connection;