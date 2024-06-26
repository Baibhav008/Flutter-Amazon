const express = require('express');
const authRouter = express.Router();
const jwt = require('jsonwebtoken');
const User = require('../model/user');
const bcrypt = require('bcryptjs');
const auth = require('../middleware/auth');


//mongodb+srv://wildwolf:wildwolf008@cluster0.lmlxjr6.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0

/*
authRouter.get("/d",(req,res)=>{
    res.json({data:"500"});

});
*/

authRouter.post("/api/signup",async (req,res)=>{

    try{
        const {name,email,password} = req.body;
        if(password.length<6)
            {
                return res.status(400).json({msg : "Password too short"});
            }
        //Validate
        const exist = await User.findOne({email});
        if(exist)
            {
                return res.status(400).json({msg : "User already exist"});
            }
        
        //Upload to DB

        const hashedPassword = await bcrypt.hash(password,3);
    
        var user = new User({
            name,
            email,
            password : hashedPassword
    
        });
        user = await user.save();
        res.json(user);
    }catch(e){
        res.status(500).json({error : e.message});
        console.log(e);
    }
    //Recieve data

});


authRouter.post("/api/signin",async (req,res)=>{
    try{
        const {email,password} = req.body;
        const user = await User.findOne({email});
        if(!user)
            {
                return res.status(400).json({msg : "User does not exist"});
            }
        const isMatch = await bcrypt.compare(password,user.password);
        if(!isMatch)
            {
                return res.status(400).json({msg : "Wrong password"});
            }

        //JSON WEB TOKEN
        // TOKEN CREATION
        // TOKEN TRANSMISSION
        // TOKEN USAGE
        // TOKEN VERIFICATION
        // ACCESS CONTROL
        const stamp = jwt.sign({id:user._id},"secretKey");
        res.json({stamp,...user._doc});
    }catch(e)
    {
        res.status(500).json({error : e.message});

    }
});



authRouter.post("/validateStamp",async(req,res)=>{
    try{
        const stamp = req.header('stamp');
    if(!stamp) return res.json(false);
    const isValid = jwt.verify(stamp,"secretKey");
    if(!isValid) return res.json(false);
    const user = await User.findById(isValid.id);
    if(!user) return res.json(false);
    return res.json(true);

    }catch(e)
    {
        res.status(500).json({error:e.message});

    }

});

authRouter.get("/",auth,async(req,res)=>{
    const user = await User.findById(req.user);
    res.json({...user._doc,stamp:req.stamp});
});

module.exports = authRouter;