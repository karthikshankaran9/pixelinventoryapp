import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pixelinventoryapp/adminPages/page_admin_approval.dart';

class Mail {
  final int id;
  final String sender;
  final String subject;
  final String body;

  Mail({
    required this.id,
    required this.sender,
    required this.subject,
    required this.body,
  });
}

class AdminMainPage extends StatefulWidget {
  @override
  _AdminListViewState createState() => _AdminListViewState();
}

class _AdminListViewState extends State<AdminMainPage> {
  List<String> employeeNames = [];
    final List<Mail> mails = [
    Mail(
      id: 1,
      sender: 'Amy Lucky',
      subject: 'Report Submission',
      body: 'My components request is wait for your approval. Please click here to approve/reject.',
    ),
  ];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse('http://10.44.100.27:8000/adminlistview'));
    if (response.statusCode == 200) {
      setState(() {
        List<Map<String, dynamic>> data = List<Map<String, dynamic>>.from(jsonDecode(response.body));
        employeeNames = data.map((e) => e['employee_name'] as String).toList();
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin List View Inbox'),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.teal.shade200, Colors.purple.shade900],
            ),
          ),
        ),
      ),
      body:Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.teal.shade200, Colors.purple.shade900],
          ),
        ),
      child:ListView.builder(
        itemCount: employeeNames.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(employeeNames[index]),
              onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AdminDetailScreen(
                    title: mails[index].subject,
                    sender: mails[index].sender,
                    body: mails[index].body,
                  ),
                ),
              );
            },
          );
        },
      ),
      ),
    );
  }
}

