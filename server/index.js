// Mandatory imports
const express = require('express');
const mongoose = require('mongoose');
//Database connection
const DB = "mongodb+srv://wildwolf:wildwolf008@cluster0.lmlxjr6.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0"
//Routes and Middlewares
const dash = require('./routes/dash');
const authRouter = require('./routes/authRouter');

//Initialize server
const app = express();
const PORT = 3000;

//Connect to mongoDB
//mongodb+srv://wildwolf:wildwolf008@cluster0.lmlxjr6.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0
mongoose.connect(DB).then(()=>{
    console.log("Mongoose Connected");
}).catch((e)=>{
    console.log(e);
});

//Defining Routes
app.use("/dash",dash);
app.use(express.json());
app.use("/auth",authRouter);

/*
app.get("/",(req,res)=>{
    res.send("Home Page");
})
    */


app.get("/nodemon",(req,res)=>{
    console.log("Run Nodemon website")
    res.send("Nodemon Page");
})


app.listen(PORT,"0.0.0.0",function(){
    console.log("Server Started!!");
});

