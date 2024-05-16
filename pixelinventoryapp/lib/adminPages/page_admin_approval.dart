import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
      });
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  void updateComponents(int? userAssetId, String newStatus) {
    if (userAssetId != null) {
      setState(() {
        data.forEach((item) {
          if (item['user_asset_id'] == userAssetId) {
            item['newStatus'] = newStatus;
          }
        });
      });
    } else {
      print('userAssetId is null');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Select the Components List'),
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
            children: [
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
              Expanded(
                child: SingleChildScrollView(
                  child: DataTable(
                    columns: const [
                      DataColumn(
                        label: Text('Components List',style: TextStyle(height: 1.2,fontSize: 15.2,fontWeight: FontWeight.bold,color: Colors.black,),),
                      ),
                      DataColumn(
                        label: Text('Selected Asset_Id',style: TextStyle(height: 1.2,fontSize: 15.2,fontWeight: FontWeight.bold,color: Colors.black,),),
                      ),
                      DataColumn(
                        label: Text('Change Status',style: TextStyle(height: 1.2,fontSize: 15.2,fontWeight: FontWeight.bold,color: Colors.black,),),
                      ),
                      DataColumn(
                        label: Text('Available Count Status',style: TextStyle(height: 1.2,fontSize: 15.2,fontWeight: FontWeight.bold,color: Colors.black,),),
                      ),
                    ],
                    rows: data.map((item) {
                      return DataRow(cells: [
                        DataCell(Text(item['components'])),
                        DataCell(Text(item['asset_id'].toString())),
                        DataCell(
                          DropdownButtonFormField<String>(
                            value: item['newStatus'] as String?,
                            onChanged: (String? newValue) {
                              updateComponents(item['user_asset_id'] as int?, newValue ?? '');
                            },
                            items: <String>['In use', 'Not Working', 'Not Available']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            decoration: const InputDecoration(labelText: 'Status'),
                          ),
                        ),
                        DataCell(Text(item['no_of_counts'].toString())),
                      ]);
                    }).toList(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Regards: ${widget.sender}",
                  style: const TextStyle(height: 3.0, fontSize: 15.2, fontWeight: FontWeight.bold, color: Colors.black),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Tooltip(
                      message: "Click this to send an email",
                      child: ElevatedButton(
                        onPressed: () {
                          // Add functionality here
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                        ),
                        child: const Text(
                          "Submit",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
