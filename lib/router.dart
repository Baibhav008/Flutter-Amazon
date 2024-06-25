import 'package:amazon_clone/view/auth/authScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings)
{
  switch(routeSettings.name)
  {
    case AuthScreen.routeName :
      return MaterialPageRoute(builder: (_)=>AuthScreen());
    default:
      return MaterialPageRoute(builder: (_)=>Scaffold(body: Center(child: Text("Page do not exist"),),));

  }
}