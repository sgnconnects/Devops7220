const mongoose = require('mongoose');

//Schema
const Schema=mongoose.Schema;
const cryptoDashboardSchema=new Schema({
    id: String,
    name: String, 
    price: String
});

//Model
const crypto_currencies=mongoose.model('crypto_currencies',cryptoDashboardSchema);
module.exports =  crypto_currencies;