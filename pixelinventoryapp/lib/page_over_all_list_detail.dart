import 'package:flutter/material.dart';
import 'package:pixelinventoryapp/apiCommunication/page_api_communication.dart';
import 'package:pixelinventoryapp/common/Page_common.dart';

class Overalllist extends StatefulWidget {
  @override
  _OveralllistState createState() => _OveralllistState();
}

class _OveralllistState extends State<Overalllist> {
  List<Map<String, dynamic>> _componentList = [];
  List<String> stringList = [];
  List<String> filteredList = [];
  TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    ComponentCategory componentCategory = ComponentCategory.allcomponents;
    updateComponentsList(componentCategory.index);
  }

  void updateComponentsList(int componentCategory) async {
    _componentList = await getComponentsListFromServer(componentCategory);
    setState(() {
      stringList =
          _componentList.map((item) => item['c_name'].toString()).toList();
      filteredList.clear();
      filteredList.addAll(stringList);
    });
  }

  void filterList(String query) {
    filteredList.clear();
    if (query.isNotEmpty) {
      filteredList.addAll(stringList.where((element) {
        return element.toLowerCase().contains(query.toLowerCase());
      }));
    } else {
      filteredList.addAll(stringList);
    }
    setState(() {});
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
        body: Align(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.teal.shade200, Colors.purple.shade900],
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  top: 20,
                  left: 15,
                  width: 550,
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Container(
                      width: 300,
                      child: TextField(
                        controller: _textEditingController,
                        onChanged: (value) {
                          filterList(value);
                        },
                        decoration: const InputDecoration(
                          labelText: 'Search',
                          hintText: 'Type to search...',
                          prefixIcon: Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 100,
                  left: 15,
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height - 100,
                    width: MediaQuery.of(context).size.width - 30,
                    child: ListView.builder(
                      itemCount: filteredList.length,
                      itemBuilder: (context, index) {
                        final component = _componentList.firstWhere(
                          (comp) => comp['c_name'] == filteredList[index],
                        );
                        return ListTile(
                          title: Text(filteredList[index]),
                          subtitle: Text('Count: ${component['no_of_counts']}'),
                          onTap: () {
                            _textEditingController.text = filteredList[index];
                          },
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
