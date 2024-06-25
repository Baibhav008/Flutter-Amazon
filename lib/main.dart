import 'package:amazon_clone/constant/global.dart';
import 'package:amazon_clone/router.dart';
import 'package:amazon_clone/view/auth/authScreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      onGenerateRoute: (settings)=> generateRoute(settings),

        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: Colors.white,
          colorScheme: ColorScheme.light(
              primary: GlobalVariables.primaryColor),
          useMaterial3: true,

        ),

        home:Scaffold(
        appBar: AppBar(

          elevation: 10.00,
          title: Text("Amazon",style: TextStyle(color: Colors.white,fontSize: 28,fontWeight: FontWeight.bold),),
          centerTitle: true,
          backgroundColor: Colors.lightBlueAccent,
        ),
          body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text( 'Flutter Demo Home Page'),
              Builder(
                builder: (context) {
                  return ElevatedButton(onPressed: (){
                    Navigator.pushNamed(context, AuthScreen.routeName);
                  }, child: Text("Click Me"));
                }
              )
            ],
          )))
    );


  }

}

