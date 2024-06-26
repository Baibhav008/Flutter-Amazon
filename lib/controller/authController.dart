import 'dart:convert';
import 'package:amazon_clone/controller/providerController/userProvider.dart';
import 'package:amazon_clone/utils/BottomNavBar.dart';
import 'package:amazon_clone/view/HomeScreen.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:amazon_clone/constant/global.dart';
import 'package:amazon_clone/model/userModel.dart';
import 'package:amazon_clone/utils/errorHandler.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController
{
  Future<void> signUpUser({required BuildContext context,required String name,required String email, required String password }) async
  {
    User user = User(id: '', name: name, email: email, password: password, address: '', type: '',stamp: '');
    http.Response res = await http.post(Uri.parse("${GlobalVariables.uri}/auth/api/signup"),
    body: jsonEncode(user.fromAppToDB()),
    headers:<String,String>{
      'Content-Type':'application/json; charset=UTF-8'
    } );
    
    httpErrorHandler(context: context, response: res, onSuccess: (){
      //showSnackBar(context, "Account created");
          final snackBar = SnackBar(
            elevation: 0,
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            content: AwesomeSnackbarContent(
              title: 'Account Created',
              message:
              'Login with the same credentials',
              contentType: ContentType.success,
            ),
          );
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(snackBar);




    });


  }

  Future<void> signinUser({required BuildContext context,required String email, required String password }) async
  {

    http.Response res = await http.post(Uri.parse("${GlobalVariables.uri}/auth/api/signin"),
        body: jsonEncode({"email":email,"password":password}),
        headers:<String,String>{
          'Content-Type':'application/json; charset=UTF-8'
        } );

    httpErrorHandler(context: context, response: res, onSuccess: () async{
      //showSnackBar(context, "Account created");

      final snackBar = SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: 'Login Successful',
          message:
          'Happy Shopping',
          contentType: ContentType.success,
        ),
      );
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);


      //print(jsonDecode(res.body)['stamp']);

      Provider.of<UserProvider>(context,listen:false).setUser(res.body);
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      await sharedPreferences.setString("stamp", jsonDecode(res.body)['stamp']);
      Navigator.pushNamedAndRemoveUntil(context, BottomNavBar.routeName,(route)=>false);




    });


  }

  Future<void> fetchUserData(BuildContext context) async {
    try{
      print("I AM CALLING");
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      String? stamp = sharedPreferences.getString("stamp");
      print("SAVED STAMP VALUE");
      print(stamp);

      if(stamp == null){
        sharedPreferences.setString("stamp", "");
      }
      print("I AM CALLING2");
      var stampRes = await http.post(Uri.parse("${GlobalVariables.uri}/auth/validateStamp"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'stamp' : stamp!
          }
      );

      var response =  jsonDecode(stampRes.body) ;
      print("I AM CALLING3");
      print(response);
      if(response == true){
        http.Response userRes = await http.get(Uri.parse("${GlobalVariables.uri}/auth"),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'stamp' : stamp
            }



        );


        var userProvider = Provider.of<UserProvider>(context, listen: false);
        print("USER RES");
        print(userRes.body);
        print("USER RES");
        userProvider.setUser(userRes.body);

      }

    }catch (e){
      print(e.toString());
      // showSnackBar(context, e.toString());
    }
  }


}