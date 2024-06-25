import 'dart:convert';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:amazon_clone/constant/global.dart';
import 'package:amazon_clone/model/userModel.dart';
import 'package:amazon_clone/utils/errorHandler.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthController
{
  Future<void> signUpUser({required BuildContext context,required String name,required String email, required String password }) async
  {
    User user = User(id: '', name: name, email: email, password: password, address: '', type: '');
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

    httpErrorHandler(context: context, response: res, onSuccess: (){
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




    });


  }


}