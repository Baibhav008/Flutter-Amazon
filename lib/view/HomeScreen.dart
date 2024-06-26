import 'package:amazon_clone/controller/providerController/userProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  static const String routeName = '/homeScreen';

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<UserProvider>(context).user;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Text(user.password),
              Text(user.name),
              Text(user.type),
              Text(user.address),
              Text(user.email),
              Text(user.stamp),
            ],
          ),
        ),
      ),
    );
  }
}
