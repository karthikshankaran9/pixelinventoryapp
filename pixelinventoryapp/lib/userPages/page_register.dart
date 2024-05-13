import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../main.dart';
import 'package:pixelinventoryapp/common/page_common_controls_UI.dart';
import 'package:pixelinventoryapp/apiCommunication/page_api_communication.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmpasswordController =
      TextEditingController();

  Future<void> register() async {
    final String name = _nameController.text.trim();
    final String gmail = _emailController.text.trim();
    final String password = _passwordController.text.trim();
    final String confirmPassword = _confirmpasswordController.text.trim();

    Map<String, dynamic> registerInfo;
    registerInfo =
        await registerLoginInfo(name, gmail, password, confirmPassword);

    if (registerInfo['success'] == true) {
      getFluttertoastMessage(
          Colors.green,
          Colors.white,
          'Registration Successful',
          Toast.LENGTH_LONG,
          15,
          ToastGravity.CENTER);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MyHomePage(),
        ),
      );
    } else {
      getFluttertoastMessage(Colors.orange, Colors.white,
          registerInfo['message'], Toast.LENGTH_LONG, 15, ToastGravity.CENTER);
    }
  }

  bool isPasswordVisible = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.teal.shade200, Colors.purple.shade900])),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                      padding: const EdgeInsets.only(left: 30),
                      icon: const Icon(Icons.arrow_back_ios,
                          color: Color(0xFF363f93)),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
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
                              'Register', 30, Colors.pink.shade600),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 40, right: 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextInput(
                        textString: "Name",
                        textController: _nameController,
                        obscureText: false,
                      ),
                      TextInput(
                        textString: "Email",
                        textController: _emailController,
                        obscureText: false,
                      ),
                      TextInput(
                        textString: "Password",
                        textController: _passwordController,
                        obscureText: !isPasswordVisible,
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
                      ),
                      TextInput(
                        textString: "Confirmed Password",
                        textController: _confirmpasswordController,
                        obscureText: !isPasswordVisible,
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
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      GestureDetector(
                        onTap: () {
                          register();
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
                              borderRadius: BorderRadius.circular(100).copyWith(
                                  bottomRight: const Radius.circular(0)),
                              gradient: LinearGradient(colors: [
                                Colors.purple.shade600,
                                Colors.amber.shade900
                              ])),
                          child: Text('Signup',
                              style: TextStyle(
                                  color: Colors.white.withOpacity(.8),
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      const Center(
                        child: Text(
                          'Already have an account?',
                          style: TextStyle(color: Colors.white70, fontSize: 13),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MyHomePage()),
                          );
                        },
                        child: Container(
                          height: 53,
                          width: double.infinity,
                          margin: const EdgeInsets.symmetric(horizontal: 30),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white60),
                            borderRadius: BorderRadius.circular(100).copyWith(
                                bottomRight: const Radius.circular(0)),
                          ),
                          child: Text('Login',
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TextInput extends StatelessWidget {
  final String textString;
  final TextEditingController textController;
  final bool obscureText;
  final Widget? suffixIcon;
  const TextInput({
    required this.textString,
    required this.textController,
    required this.obscureText,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textController,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: textString,
        suffixIcon: suffixIcon,
      ),
    );
  }
}
