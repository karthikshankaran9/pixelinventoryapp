import 'package:flutter/material.dart';
import 'package:pixelinventoryapp/apiCommunication/page_api_communication.dart';

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
  late List<String> selectedStatusList; 

  @override
  void initState() {
    super.initState();
    fetchDataFromServer();
  }

  Future<void> fetchDataFromServer() async {
    try {
      List<Map<String, dynamic>> responseData = await adminApprovalFetchData();
      setState(() {
        data = responseData;
        selectedStatusList = List<String>.filled(data.length, 'Use'); // Initialize selectedStatusList
      });
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

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
                    style: const TextStyle(height: 3.0, fontSize: 15.2, fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  Text(
                    widget.body,
                    style: const TextStyle(height: 3.0, fontSize: 15.2, color: Colors.black),
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
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              DropdownButtonFormField<String>(
                                value: selectedStatusList[index],
                                onChanged: (String? newValue) {
                                  setState(() {
                                    selectedStatusList[index] = newValue ?? selectedStatusList[index];
                                  });
                                },
                                items: <String>['Use', 'Not Working', 'Available']
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
                style: const TextStyle(height: 3.0, fontSize: 15.2, fontWeight: FontWeight.bold, color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

