const express = require('express');

const router = express.Router();

const crypto_currencies = require('../models/cryptocurrency');

//defining route
router.get('/',(req,res)=>{    
    crypto_currencies.find({ })
    .then((data)=>{
//console.log('Data: ',data);
res.json(data);
    })
    .catch((error)=>{
console.log('error: ',error);
    });
   
});


module.exports=router;