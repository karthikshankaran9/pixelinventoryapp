// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';

// Future<void> sendSelectedItems(
//     String name, Map<String, int> mapSelectedCompnentList) async {
//   Map<String, dynamic> payload = {
//     'name': name,
//     'subject': 'Component Request',
//     'body':mapSelectedCompnentList.keys.toList(),
//   };

//   var jsonPayload = json.encode(payload);

//   var response = await http.post(
//     Uri.parse('http://10.44.100.27:8000/email'),
//     headers: {
//       'Content-Type': 'application/json',
//     },
//     body: jsonPayload,
//   );

//   if (response.statusCode == 200) {
//     Fluttertoast.showToast(
//       msg: 'Items sent successfully!',
//       toastLength: Toast.LENGTH_SHORT,
//       gravity: ToastGravity.CENTER,
//       backgroundColor: Colors.green,
//       textColor: Colors.white,
//       fontSize: 16.0,
//     );
//   } else {
//     Fluttertoast.showToast(
//       msg: 'Failed to send items.',
//       toastLength: Toast.LENGTH_SHORT,
//       gravity: ToastGravity.CENTER,
//       backgroundColor: Colors.red,
//       textColor: Colors.white,
//       fontSize: 16.0,
//     );
//   }
// }

