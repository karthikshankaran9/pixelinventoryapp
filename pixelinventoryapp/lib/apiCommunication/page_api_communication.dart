import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';

const String rmsWebServerHost = 'http://10.44.100.27:8000';
const String loginAPI = 'login';
const String registrationiAPI = 'registration';
const String emailAPI = 'email';

Future<Map<String, dynamic>> getLoginInfo(String email, String password) async {
  final reqBody = {
    'Gmail': email,
    'Password': password,
  };

  try {
    final response = await http.post(
      Uri.parse('$rmsWebServerHost/$loginAPI'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonDecode(reqBody as String),
    );
    Map<String, dynamic> data;
    if (response.statusCode == 200) {
      data = json.decode(response.body);
    } else {
      data = {"failure": "Invalid response"};
    }
    return data;
  } catch (e) {
    return {"failure": "Exception"};
  }
}

Future<Map<String, dynamic>> registerLoginInfo(
    String name, String gmail, String password, String confirmPassword) async {
  var reqBody = {};
  reqBody["name"] = name;
  reqBody["gmail"] = gmail;
  reqBody["password"] = password;
  reqBody["confirmPassword"] = confirmPassword;

  String str = json.encode(reqBody);

  try {
    final response = await http.post(
      Uri.parse('$rmsWebServerHost/$registrationiAPI'),
      body: str,
    );
    Map<String, dynamic> data;
    if (response.statusCode == 200) {
      data = json.decode(response.body);
    } else {
      data = {"failure": "Invalid response"};
    }
    return data;
  } catch (e) {
    return {"failure": "Exception"};
  }
}

Future<List<Map<String, dynamic>>> getComponentsListFromServer(
    String getComponetsAPI) async {
  final response = await http
      .get(Uri.parse('$rmsWebServerHost/$getComponetsAPI'), headers: {
    "Accept": "application/json",
    "Access-Control-Allow-Origin": "*"
  });

  if (response.statusCode == 200) {
    List<Map<String, dynamic>> componentList =
        List<Map<String, dynamic>>.from(jsonDecode(response.body));

    return componentList;
  } else {
    throw Exception('Failed to load data');
  }
}

Future<List<Map<String, dynamic>>> getallComponentsListFromServer(
    String getallComponetsAPI) async {
  final response = await http
      .get(Uri.parse('$rmsWebServerHost/$getallComponetsAPI'), headers: {
    "Accept": "application/json",
    "Access-Control-Allow-Origin": "*"
  });

  if (response.statusCode == 200) {
    List<Map<String, dynamic>> componentList =
        List<Map<String, dynamic>>.from(jsonDecode(response.body));

    return componentList;
  } else {
    throw Exception('Failed to load data');
  }
}


Future<void> sendSelectedItems(String name, List<String> selectedItems, Map<String, int> quantities) async {
   Map<String, dynamic> payload = {
  'name': name,
  'subject': 'Component Request',
  'body': selectedItems,
};

  var jsonPayload = json.encode(payload);

  try {
    var response = await http.post(
      Uri.parse('$rmsWebServerHost/$emailAPI'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonPayload,
    );

    if (response.statusCode == 200) {
      Fluttertoast.showToast(
        msg: 'Items sent successfully!',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } else {
      Fluttertoast.showToast(
        msg: 'Failed to send items.',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  } catch (e) {
    Fluttertoast.showToast(
      msg: 'Failed to send items: $e',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}