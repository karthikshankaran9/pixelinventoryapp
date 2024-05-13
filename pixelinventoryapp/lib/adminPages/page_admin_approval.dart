import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AdminDetailScreen extends StatefulWidget {
  final String title;
  final String sender;
  final String body;

  const AdminDetailScreen({
    Key? key,
    required this.title,
    required this.sender,
    required this.body,
  }) : super(key: key);

  @override
  _AdminDetailScreenState createState() => _AdminDetailScreenState();
}

class _AdminDetailScreenState extends State<AdminDetailScreen> {
  List<Map<String, dynamic>> data = [];
  String selectedStatus = 'Use';

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final Uri url = Uri.parse('http://10.44.100.27:8000/admindashboard');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> responseBody = jsonDecode(response.body);
      setState(() {
        data = responseBody.cast<Map<String, dynamic>>();
      });
    } else {
      throw Exception('Failed to load data');
    }
  }
  
  // Future<void> updateAdminStatus(List<Map<String, dynamic>> componentsDetails) async {
  //   final String apiUrl = 'http://10.44.100.27:8000/admin_status_change';

  //   try {
  //     // Prepare data
  //     Map<String, dynamic> requestData = {'components_details': componentsDetails};
  //     String requestBody = jsonEncode(requestData);

  //     // Send POST request
  //     final http.Response response = await http.post(
  //       Uri.parse(apiUrl),
  //       headers: <String, String>{
  //         'Content-Type': 'application/json; charset=UTF-8',
  //       },
  //       body: requestBody,
  //     );

  //     // Check response status
  //     if (response.statusCode == 200) {
  //       print('Update successful');
  //     } else {
  //       print('Failed to update: ${response.reasonPhrase}');
  //     }
  //   } catch (e) {
  //     print('Error: $e');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.teal.shade200, Colors.purple.shade900],
            ),
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.teal.shade200, Colors.purple.shade900],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "From: ${widget.sender}",
                    style: const TextStyle(height: 3.0,fontSize: 15.2,fontWeight: FontWeight.bold,color: Colors.black,),
                  ),
                  Text(
                    widget.body,
                    style: const TextStyle(height: 3.0,fontSize: 15.2,color: Colors.black,),
                  ),
                ],
              ),
            ),
           const Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: <Widget>[
                  SizedBox(width: 50),
                  Expanded(
                    flex: 2,
                    child: Text('Components List', style: TextStyle(height: 3.0, fontSize: 15.2, fontWeight: FontWeight.bold)),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text('Required Quantity', style: TextStyle(height: 3.0, fontSize: 15.2, fontWeight: FontWeight.bold)),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text('Change Status', style: TextStyle(height: 3.0, fontSize: 15.2, fontWeight: FontWeight.bold)),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text('Available Count Status ', style: TextStyle(height: 3.0, fontSize: 15.2, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: data.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 2,
                          child: Text(data[index]['components']),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(data[index]['asset_id'].toString()),
                        ),
                        Expanded(
                          flex: 2,
                          child:Column(
                           crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                             DropdownButtonFormField<String>(
                            value: selectedStatus,
                            onChanged: (String? newValue) {
                             setState(() {
                             selectedStatus = newValue!;
                             });
                            },
                           items: <String>['Use', 'Not Working', ' Available']
                           .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                            );
                           }).toList(),
                          decoration: InputDecoration(labelText: 'Status'),
                          ),
                         ],
                         ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(data[index]['no_of_counts'].toString()),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Regards: ${widget.sender}",
                style:const TextStyle(height: 3.0,fontSize: 15.2,fontWeight: FontWeight.bold,color: Colors.black,),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
