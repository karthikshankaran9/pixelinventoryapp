import 'package:flutter/material.dart';
import 'package:pixelinventoryapp/apiCommunication/page_api_communication.dart';
import 'package:pixelinventoryapp/forgetpassword.dart/page_update_password.dart';

class ForgetPasswordPage extends StatefulWidget {
  @override
  _ForgetPasswordPageState createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  TextEditingController _employeeIdController = TextEditingController();
  String _message = '';

  Future<void> _forgetPassword() async {
    String employeeId = _employeeIdController.text;
    if (employeeId.isEmpty) {
      setState(() {
        _message = 'Please enter your Employee ID';
      });
      return;
    }

    try {
      Map<String, dynamic> response = await forgetPassword(employeeId);
      if (response['success']) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => UpdatePasswordPage()),
        );
      } else {
        setState(() {
          _message = response['message'] ?? 'Failed to reset password';
        });
      }
    } catch (e) {
      setState(() {
        _message = 'An error occurred: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text('Forget Password'),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.teal.shade200, Colors.purple.shade900],
            ),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.teal.shade200, Colors.purple.shade900],
          ),
        ),
        child: Padding(
          padding:const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _employeeIdController,
                decoration:const InputDecoration(labelText: 'Employee ID'),
              ),
             const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _forgetPassword,
                child:const Text('Reset Password'),
              ),
             const SizedBox(height: 20),
              Text(
                _message,
                style:const TextStyle(color: Colors.red),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

