import 'package:amazon_clone/controller/authController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gradient_app_bar/flutter_gradient_app_bar.dart';

class AuthScreen extends StatefulWidget {
  static const String routeName = '/auth-name';
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isLoginEnabled = false;

  final emailController  = TextEditingController();
  final nameController  = TextEditingController();
  final passwordController  = TextEditingController();

  var signUpKey = GlobalKey<FormState>();
  var loginKey = GlobalKey<FormState>();

  void _signupSubmit(String name,String email,String password) {
   final isValid = signUpKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    signUpKey.currentState!.save();
    AuthController().signUpUser(context:context,name: name, email: email, password: password);
  }

  void _loginSubmit(String email,String password) {
    final isValid = loginKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    loginKey.currentState!.save();
    AuthController().signinUser(context: context, email: email, password: password);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GradientAppBar(
        elevation: 10.00,
        title: Text(
          "Amazon",
          style: TextStyle(
              color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        gradient: LinearGradient(colors: [
          Colors.blueAccent,
          Colors.lightBlueAccent,
          Colors.white,
        ], begin: Alignment.bottomCenter, end: Alignment.topCenter),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SingleChildScrollView(
            child: SizedBox(
                height: MediaQuery.of(context).size.height-140 ,
                child: isLoginEnabled
                    ? Form(
                  key: loginKey,
                      child: Column(
                          children: [
                            Text(
                              "Sign in with your email and password",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w400),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Sign In",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold, fontSize: 28),
                                ),
                                TextButton(
                                    onPressed: () {},
                                    child: Text(
                                      "Forgot Password",
                                      style: TextStyle(fontSize: 18),
                                    ))
                              ],
                            ),
                            TextFormField(
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                if (value!.isEmpty ||
                                    !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                        .hasMatch(value)) {
                                  return 'Enter a valid email!';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                  hintText: "Email",
                                  errorBorder: OutlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Colors.black)),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Colors.black)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Colors.black))),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            TextFormField(
                              controller: passwordController,
                              keyboardType: TextInputType.visiblePassword,
                              validator: (value) {
                                RegExp regex = RegExp(
                                    r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{6,}$');
                                if (value!.isEmpty) {
                                  return 'Please enter password';
                                } else {
                                  if (value.length < 6) {
                                    return 'Enter valid password';
                                  } else {
                                    return null;
                                  }
                                }
                              },
                              obscureText: true,
                              decoration: InputDecoration(
                                  hintText: "Password",
                                  errorBorder: OutlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Colors.black)),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Colors.black)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Colors.black))),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            CheckboxListTile(
                              value: true,
                              onChanged: (value) {},
                              title: Text("Show Password"),
                            ),
                            CheckboxListTile(
                              value: true,
                              onChanged: (value) {},
                              title: Text("Keep me logged in"),
                            ),
                            InkWell(
                              onTap: () {_loginSubmit(emailController.text,passwordController.text);},
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal:
                                        MediaQuery.of(context).size.width / 2 -
                                            64,
                                    vertical: 18),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.lightBlueAccent,
                                ),
                                child: Text(
                                  "Sign In",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Divider(),
                            SizedBox(
                              height: 8,
                            ),
                            Text("New to Amazon ?"),
                            SizedBox(
                              height: 16,
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  isLoginEnabled = false;
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal:
                                        MediaQuery.of(context).size.width / 2 -
                                            120,
                                    vertical: 18),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.lightBlueAccent,
                                ),
                                child: Text(
                                  "Create a new account",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
                            Spacer(),
                            TextButton(
                                onPressed: () {},
                                child: Text("Conditions of user Privacy Notice"))
                          ],
                        ),
                    )
                    : Form(
                        key: signUpKey,
                        child: Container(
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "Create Account",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 28),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                controller: nameController,
                                keyboardType: TextInputType.name,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Enter your name";
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                    hintText: "Your Name",
                                    errorBorder: OutlineInputBorder(
                                        borderSide:
                                        BorderSide(color: Colors.black)),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black)),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black))),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                controller: emailController,
                                keyboardType: TextInputType.emailAddress,
                                validator: (value) {
                                  if (value!.isEmpty ||
                                      !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                          .hasMatch(value)) {
                                    return 'Enter a valid email!';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                    hintText: "Email",
                                    errorBorder: OutlineInputBorder(
                                        borderSide:
                                        BorderSide(color: Colors.black)),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black)),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black))),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                controller: passwordController,
                                keyboardType: TextInputType.visiblePassword,
                                validator: (value) {
                                  RegExp regex = RegExp(
                                      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{6,}$');
                                  if (value!.isEmpty) {
                                    return 'Please enter password';
                                  } else {
                                    if (value.length < 6) {
                                      return 'Enter valid password';
                                    } else {
                                      return null;
                                    }
                                  }
                                },
                                obscureText: true,
                                decoration: InputDecoration(
                                    hintText: "Password",
                                    errorBorder: OutlineInputBorder(
                                        borderSide:
                                        BorderSide(color: Colors.black)),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black)),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black))),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text("Password must be atleast 6 characters"),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                keyboardType: TextInputType.visiblePassword,
                                validator: (value) {
                                  RegExp regex = RegExp(
                                      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{6,}$');
                                  if (value!.isEmpty) {
                                    return 'Please enter password';
                                  } else {
                                    if (value.length < 6) {
                                      return 'Enter valid password';
                                    } else {
                                      return null;
                                    }
                                  }
                                },
                                obscureText: true,
                                decoration: InputDecoration(
                                    hintText: "Re-enter Password",
                                    errorBorder: OutlineInputBorder(
                                        borderSide:
                                        BorderSide(color: Colors.black)),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black)),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black))),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              InkWell(
                                onTap: () {_signupSubmit(nameController.text,emailController.text,passwordController.text);},
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal:
                                          MediaQuery.of(context).size.width / 2 -
                                              80,
                                      vertical: 18),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Colors.lightBlueAccent,
                                  ),
                                  child: Text(
                                    "Create Account",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Divider(),
                              SizedBox(
                                height: 4,
                              ),
                              Text("Already a user ?"),
                              SizedBox(
                                height: 16,
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    isLoginEnabled = true;
                                  });
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal:
                                          MediaQuery.of(context).size.width / 2 -
                                              48,
                                      vertical: 18),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Colors.lightBlueAccent,
                                  ),
                                  child: Text(
                                    "Sign In",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ),
                              Spacer(),
                              TextButton(
                                onPressed: () {},
                                child: Center(
                                  child: Text(
                                    "By creating an account you agree to Amazon's Conditions of Use and Privacy Notice",
                                    textAlign: TextAlign
                                        .center, // Optional: Align text within the button
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      )),
          ),
        ),
      ),
    );
  }
}
