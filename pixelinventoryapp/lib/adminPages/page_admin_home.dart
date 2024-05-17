import 'package:flutter/material.dart';
import 'package:pixelinventoryapp/adminPages/page_admin_approval.dart';
import 'package:pixelinventoryapp/apiCommunication/page_api_communication.dart';

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
  List<Mail> mails = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      List<Map<String, dynamic>> data = await fetchData();
      if (data.isEmpty) {
        _showPopup('No Request', 'There is no request available to display.');
      } else {
        setState(() {
          employeeNames = data.map((e) => e['employee_name'] as String).toList();
          // Create a corresponding mail for each employee
          mails = employeeNames.map((name) {
            return Mail(
              id: employeeNames.indexOf(name) + 1,
              sender: name,
              subject: 'Report Submission',
              body: 'My components request is wait for your approval. Please click here to approve/reject.',
            );
          }).toList();
        });
      }
    } catch (e) {
      print('Error loading data: $e');
    }
  }

  void _showPopup(String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
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
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.teal.shade200, Colors.purple.shade900],
          ),
        ),
        child: ListView.builder(
          itemCount: employeeNames.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(employeeNames[index]),
              onTap: () {
                if (index < mails.length) {
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
                } else {
                  print('No corresponding mail found for employee');
                }
              },
            );
          },
        ),
      ),
    );
  }
}
