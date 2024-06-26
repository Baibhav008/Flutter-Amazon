import 'package:amazon_clone/constant/global.dart';
import 'package:amazon_clone/controller/authController.dart';
import 'package:amazon_clone/controller/providerController/userProvider.dart';
import 'package:amazon_clone/router.dart';
import 'package:amazon_clone/utils/BottomNavBar.dart';
import 'package:amazon_clone/view/HomeScreen.dart';
import 'package:amazon_clone/view/auth/authScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
  providers: [
    ChangeNotifierProvider(create: (context)=>UserProvider())
  ],
      child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  final AuthController authController = AuthController();
  @override
  void initState() {
    authController.fetchUserData(context);
    print("Error checking ");
    //print(Provider.of<UserProvider>(context).user.stamp);
    super.initState();
  }
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

        home:Provider.of<UserProvider>(context).user.stamp.isNotEmpty?BottomNavBar():AuthScreen()
    );


  }
}

