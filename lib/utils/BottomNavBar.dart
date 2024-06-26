import 'package:amazon_clone/view/HomeScreen.dart';
import 'package:amazon_clone/view/auth/authScreen.dart';
import 'package:amazon_clone/view/profileScreen.dart';
import 'package:flutter/material.dart';

class BottomNavBar extends StatefulWidget {
  static const String routeName = 'navBar';
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {

  int scrIdx = 0;
  List<Widget> screens = [HomeScreen(),ProfileScreen()];

  updateScreen(int idx)
  {
    setState(() {
      scrIdx=idx;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[scrIdx],
      bottomNavigationBar: BottomNavigationBar(
        onTap: updateScreen,
        selectedItemColor: Colors.blue,
        iconSize: 40,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home,color: scrIdx==0?Colors.blue:Colors.black,),label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.person,color: scrIdx==1?Colors.blue:Colors.black),label: ""),
        ],
      ),
    );
  }
}
