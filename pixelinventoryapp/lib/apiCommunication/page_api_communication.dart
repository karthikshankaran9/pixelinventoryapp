import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:pixelinventoryapp/common/Page_common.dart';

const String rmsWebServerHost = 'http://10.44.100.27:8000';
const String loginAPI = 'login';
const String registrationAPI = 'registration';
const String emailAPI = 'email';
const String getComponentListAPI = 'getComponentList';

Future<Map<String, dynamic>> getLoginInfo(String email, String password) async {
  var reqBody = {
    "Gmail": email,
    "Password": password,
  };
  String str = json.encode(reqBody);

  try {
    final response = await http.post(
      Uri.parse('$rmsWebServerHost/$loginAPI'),
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

Future<Map<String, dynamic>> registerLoginInfo(
    String name, String gmail, String password, String confirmPassword) async {
  var reqBody = {
    "name": name,
    "gmail": gmail,
    "password": password,
    "confirmPassword": confirmPassword,
  };

  String str = json.encode(reqBody);

  try {
    final response = await http.post(
      Uri.parse('$rmsWebServerHost/$registrationAPI'),
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
    int deviceCategory) async {
  var reqBody = {'category': (deviceCategory + 1)};

  final response = await http.post(
    Uri.parse('$rmsWebServerHost/$getComponentListAPI'),
    headers: {
      "Content-Type": "application/json", 
    },
    body: jsonEncode(reqBody), 
  );

  if (response.statusCode == 200) {
    List<Map<String, dynamic>> componentList =
        List<Map<String, dynamic>>.from(jsonDecode(response.body));
    return componentList;
  } else {
    throw Exception('Failed to load data');
  }
}

Future<void> sendSelectedItems(
    String name, Map<String, int> mapCompnentList) async {
  Map<String, dynamic> payload = {
    'name': name,
    'subject': 'Component Request',
    'body': mapCompnentList.keys.toList(),
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
       getFluttertoastMessage(
          Colors.green,
          Colors.white,
          'Items sent successfully!',
          Toast.LENGTH_LONG,
          15,
          ToastGravity.CENTER);
    } else {
       getFluttertoastMessage(
          Colors.green,
          Colors.white,
          'Failed to send items.',
          Toast.LENGTH_LONG,
          15,
          ToastGravity.CENTER);
    }
  } catch (e) {
    getFluttertoastMessage(
          Colors.green,
          Colors.white,
          'Failed to send items.',
          Toast.LENGTH_LONG,
          15,
          ToastGravity.CENTER);
  }
}


