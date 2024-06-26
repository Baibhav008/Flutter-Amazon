import 'package:amazon_clone/controller/providerController/userProvider.dart';
import 'package:amazon_clone/utils/SingleProduct.dart';
import 'package:amazon_clone/utils/accountButton.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    
    final user = Provider.of<UserProvider>(context).user;
    
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(color: Colors.lightBlueAccent),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Image.asset(
                  "assets/images/logo.png",
                  width: 150,
                  height: 150,
                ),
              ),
              Spacer(),
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.notifications,
                    size: 28,
                  )),
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.search,
                    size: 28,
                  )),
            ],
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
            child: Text("Hello !! ${user.name}",style: TextStyle(
              fontSize: 28,
            ),),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ProfileButton(text: "Your Orders",onTap: (){},),
              ProfileButton(text: "Your WishList",onTap: (){}),
            ],
          ),
          SizedBox(height: 28,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ProfileButton(text: "Seller Mode",onTap: (){}),
              ProfileButton(text: "Log Out",onTap: (){}),
            ],
          ),
          SizedBox(height: 20,),
          Padding(

            padding: const EdgeInsets.only(left: 14),
            child: Text("Your Orders",style: TextStyle(fontSize: 18),),
          ),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SingleProduct(imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQZ5Sz8tKr0nLh2OwrBmBIrP7iZBFemCJvkqA&s"),
              SingleProduct(imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRmD3Ab8aOMnuR-SHno579ed1EtnEdV8TCz3Q&s")
            ],
          )
        ],
      ),
    );
  }
}
