import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:pixelinventoryapp/common/page_common_controls_UI.dart';
import 'package:pixelinventoryapp/common/page_data_process.dart';

const String rmsWebServerHost = 'http://10.44.100.27:8000';
const String loginAPI = 'login';
const String registrationAPI = 'registration';
const String emailAPI = 'email';
const String forgetPasswordAPI = 'forgetPassword';
const String updatePasswordAPI = 'updatePassword';
const String getComponentListAPI = 'getComponentList';
const String  admindashboardlistAPI = 'admindashboard' ;
const String adminlistviewlistAPI = 'adminlistview';
const String adminstatuschangelistAPI = 'admin_status_change';


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

Future<Map<String, dynamic>> forgetPassword(String employeeId) async {
  final url = '$rmsWebServerHost/$forgetPasswordAPI';
  final Map<String, dynamic> data = {
    "employee_id": employeeId,
  };

  final response = await http.post(
    Uri.parse(url),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(data),
  );

   if (response.statusCode == 200) {
    final responseData = json.decode(response.body);
    getFluttertoastMessage(Colors.green, Colors.white, responseData['message'],
        Toast.LENGTH_LONG, 15, ToastGravity.CENTER);
    return responseData;
  } else {
    getFluttertoastMessage(Colors.red, Colors.white, 'Failed to reset passworda',
        Toast.LENGTH_LONG, 15, ToastGravity.CENTER);
    return {"failure": "Failed to reset password"};
  }
}

 Future<Map<String, dynamic>> updatePassword(
    String email, String password, String confirmPassword) async {
 final url = '$rmsWebServerHost/$updatePasswordAPI';
  final Map<String, dynamic> data = {
    "email": email,
    "password": password,
    "confirmpassword": confirmPassword,
  };

  final response = await http.post(
    Uri.parse(url),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(data),
  );

  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    return {"failure": "Failed to update password"};
  }
}

Future<List<Map<String, dynamic>>> getComponentsListFromServer(
    int deviceCategory) async {
  var reqBody = {
    'category': (deviceCategory + 1),
  };

  final response = await http.post(
    Uri.parse('$rmsWebServerHost/$getComponentListAPI'),
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

Future<List<Map<String, dynamic>>> fetchData() async {
  final response = await http.get(Uri.parse('$rmsWebServerHost/$adminlistviewlistAPI'));

  if (response.statusCode == 200) {
    List<Map<String, dynamic>> data = List<Map<String, dynamic>>.from(jsonDecode(response.body));
    return data;
  } else {
    throw Exception('Failed to load data');
  }
}

  Future<void> adminApprovalFetchData(String sender, Function(List<Map<String, dynamic>>) updateData) async {
  try {
    final response = await http.post(
      Uri.parse('$rmsWebServerHost/$admindashboardlistAPI'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'name': sender}),
    );

    if (response.statusCode == 200) {
      List<Map<String, dynamic>> responseData = List<Map<String, dynamic>>.from(json.decode(response.body));
      updateData(responseData);
    } else {
      print('Failed to load data');
    }
  } catch (e) {
    print('Error fetching data: $e');
  }
}

Future<void> sendApprovalData(List<Map<String, dynamic>> data,) async {
  List<Map<String, String>> componentsDetails = data.map((item) {
    return {
      "user_asset_id": item['asset_id'].toString(),
    };
  }).toList();

  Map<String, dynamic> requestData = {
    "components_details": componentsDetails,
  };

  try {
    final response = await http.post(
      Uri.parse('$rmsWebServerHost/$adminstatuschangelistAPI'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(requestData),
    );

    if (response.statusCode == 200) {
      print('Data sent successfully');
      getFluttertoastMessage(Colors.green, Colors.white, 'Data sent successfully',
        Toast.LENGTH_LONG, 15, ToastGravity.CENTER);
    } else {
      print('Failed to send data');
      getFluttertoastMessage(Colors.green, Colors.white, 'Failed to send data',
        Toast.LENGTH_LONG, 15, ToastGravity.CENTER);
    }
  } catch (e) {
    print('Error sending data: $e');
      getFluttertoastMessage(Colors.green, Colors.white, 'Error sending data: $e',
        Toast.LENGTH_LONG, 15, ToastGravity.CENTER);
  
  }
}

Future<void> sendSelectedItems() async {
  try {
    var response = await http.post(
      Uri.parse('$rmsWebServerHost/$emailAPI'),
      body: getPayloadWithMailContent(),
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
      getFluttertoastMessage(Colors.green, Colors.white,
          'Failed to send items.', Toast.LENGTH_LONG, 15, ToastGravity.CENTER);
    }
  } catch (e) {
    getFluttertoastMessage(Colors.green, Colors.white, 'Failed to send items.',
        Toast.LENGTH_LONG, 15, ToastGravity.CENTER);
  }
}
