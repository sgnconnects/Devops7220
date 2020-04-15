// Import npm packages
const express = require('express');
const mongoose = require('mongoose');//object data model for mongodb
const morgan = require('morgan');
const path = require('path');

const app = express();
const PORT = process.env.PORT || 8080;

const routes = require('./routes/api');
//link of connection where mongodb is running in string
const MONGODB_URI='mongodb+srv://root:Onepiece181195@cyril-spa-zudqm.mongodb.net/Devops7220?retryWrites=true&w=majority';
mongoose.connect(MONGODB_URI, {
    useNewUrlParser: true,
    useUnifiedTopology: true
});
mongoose.connection.on('connected', () => {
    console.log('Mongoose is connected!!!!');
});
//Data Parsing
app.use(express.json());
app.use(express.urlencoded({extended:true}));
// HTTP request logger, every single request in terminal
app.use(morgan('tiny'));
app.use('/api',routes);

app.listen(PORT,console.log(`server is starting at ${PORT}`));