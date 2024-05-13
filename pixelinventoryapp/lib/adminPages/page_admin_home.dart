import 'package:flutter/material.dart';
import 'package:pixelinventoryapp/Page_admin_approval.dart';

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

class MailListScreen extends StatelessWidget {
  final List<Mail> mails = [
    Mail(
      id: 1,
      sender: 'Amy Lucky',
      subject: 'Report Submission',
      body: 'My components request is wait for your approval. Please click here to approve/reject.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inbox'),
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
        child:  ListView.builder(
        itemCount: mails.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(mails[index].sender),
            subtitle: Text(mails[index].subject),
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







