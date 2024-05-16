import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pixelinventoryapp/userPages/page_register.dart';
import 'package:pixelinventoryapp/userPages/page_forgot_password.dart';
import 'package:pixelinventoryapp/userPages/page_dashboard_componets.dart';
import 'package:pixelinventoryapp/adminPages/page_admin_home.dart';
import 'package:pixelinventoryapp/common/page_data_process.dart';
import 'package:pixelinventoryapp/common/page_common.dart';
import 'package:pixelinventoryapp/common/page_common_controls_UI.dart';
import 'package:pixelinventoryapp/apiCommunication/page_api_communication.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pixel Inventory Management System',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _emailController =
      TextEditingController(text: '@pixelexpert.net');
  final TextEditingController _passwordController = TextEditingController();
  String message = '';

  Future<void> login() async {
    final String email = _emailController.text;
    final String password = _passwordController.text;
    GeneralSettings generalSettings = GeneralSettings();

    // Regular login process
    if (!email.contains('@pixelexpert.net') || email.split('@')[0].isEmpty) {
      getFluttertoastMessage(
          Colors.red,
          Colors.white,
          'Please enter a valid Pixel email ID',
          Toast.LENGTH_LONG,
          16.0,
          ToastGravity.CENTER);
      return;
    }
    if (password.isEmpty) {
      getFluttertoastMessage(
          Colors.red,
          Colors.white,
          'Password should not be empty...',
          Toast.LENGTH_LONG,
          16.0,
          ToastGravity.CENTER);
      return;
    }
    Map<String, dynamic> loginInfo;
    loginInfo = await getLoginInfo(email, password);

    if (loginInfo['success'] == true) {
      getFluttertoastMessage(
          Colors.green,
          Colors.white,
          ('Welcome ' + loginInfo['name']),
          Toast.LENGTH_LONG,
          15,
          ToastGravity.CENTER);
      generalSettings.email = email;
      generalSettings.name = loginInfo['name'];

      setGeneralSettings(generalSettings);

      if (loginInfo['role'] == 'admin') {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AdminMainPage(),
          ),
        );
      } else
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DashBoard(),
          ),
        );
    } else {
      getFluttertoastMessage(Colors.green, Colors.red, loginInfo['message'],
          Toast.LENGTH_LONG, 15, ToastGravity.CENTER);
    }
  }

  bool isPasswordVisible = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: double.infinity,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.teal.shade200, Colors.purple.shade900])),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    height: 100,
                    width: 300,
                    decoration: const BoxDecoration(
                        gradient:
                            LinearGradient(colors: [Colors.red, Colors.yellow]),
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 4,
                              spreadRadius: 3,
                              color: Colors.black12)
                        ],
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(200),
                            bottomRight: Radius.circular(200))),
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 35, left: 65),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          getCommonTextControl('Pixel', 30, Colors.white),
                          getCommonTextControl(
                              'Login', 30, Colors.pink.shade600),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30)
                      .copyWith(bottom: 10),
                  child: TextField(
                    controller: _emailController,
                    style: const TextStyle(color: Colors.white, fontSize: 14.5),
                    decoration: InputDecoration(
                        prefixIconConstraints:
                            const BoxConstraints(minWidth: 45),
                        prefixIcon: const Icon(
                          Icons.alternate_email_outlined,
                          color: Colors.white70,
                          size: 22,
                        ),
                        border: InputBorder.none,
                        hintText: 'Enter your Pixel email ID',
                        hintStyle: const TextStyle(
                            color: Colors.white60, fontSize: 14.5),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100).copyWith(
                                bottomRight: const Radius.circular(0)),
                            borderSide:
                                const BorderSide(color: Colors.white38)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100).copyWith(
                                bottomRight: const Radius.circular(0)),
                            borderSide:
                                const BorderSide(color: Colors.white70))),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30)
                      .copyWith(bottom: 10),
                  child: TextField(
                    controller: _passwordController,
                    style: const TextStyle(color: Colors.white, fontSize: 14.5),
                    obscureText: isPasswordVisible ? false : true,
                    decoration: InputDecoration(
                        prefixIconConstraints:
                            const BoxConstraints(minWidth: 45),
                        prefixIcon: const Icon(
                          Icons.lock,
                          color: Colors.white70,
                          size: 22,
                        ),
                        suffixIconConstraints:
                            const BoxConstraints(minWidth: 45, maxWidth: 46),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              isPasswordVisible = !isPasswordVisible;
                            });
                          },
                          child: Icon(
                            isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.white70,
                            size: 22,
                          ),
                        ),
                        border: InputBorder.none,
                        hintText: 'Enter your Password',
                        hintStyle: const TextStyle(
                            color: Colors.white60, fontSize: 14.5),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100).copyWith(
                                bottomRight: const Radius.circular(0)),
                            borderSide:
                                const BorderSide(color: Colors.white38)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100).copyWith(
                                bottomRight: const Radius.circular(0)),
                            borderSide:
                                const BorderSide(color: Colors.white70))),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ForgetPasswordPage()),
                        );
                      },
                      child: const Padding(
                        padding: EdgeInsets.only(left: 100),
                        child: Text(
                          "Forgot Password?",
                          style: TextStyle(
                            fontSize: 16,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    login();
                  },
                  child: Container(
                    height: 53,
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(horizontal: 30),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 4,
                              color: Colors.black12.withOpacity(.2),
                              offset: const Offset(2, 2))
                        ],
                        borderRadius: BorderRadius.circular(100)
                            .copyWith(bottomRight: const Radius.circular(0)),
                        gradient: LinearGradient(colors: [
                          Colors.purple.shade600,
                          Colors.amber.shade900
                        ])),
                    child: Text('Login',
                        style: TextStyle(
                            color: Colors.white.withOpacity(.8),
                            fontSize: 15,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                const Text('Don\'t have an account?',
                    style: TextStyle(color: Colors.white70, fontSize: 13)),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Register()),
                    );
                  },
                  child: Container(
                    height: 53,
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(horizontal: 30),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white60),
                      borderRadius: BorderRadius.circular(100)
                          .copyWith(bottomRight: const Radius.circular(0)),
                    ),
                    child: Text('Sign Up',
                        style: TextStyle(
                            color: Colors.white.withOpacity(.8),
                            fontSize: 15,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
                const SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
