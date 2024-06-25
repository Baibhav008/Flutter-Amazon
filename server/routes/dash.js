const express = require('express');
const dash = express.Router();

dash.get("/dashboard",(req,res)=>{
    res.json({data:"500"});

});

module.exports = dash;