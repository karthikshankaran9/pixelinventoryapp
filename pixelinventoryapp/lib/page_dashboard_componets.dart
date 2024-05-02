import 'package:flutter/material.dart';
import 'package:pixelinventoryapp/Overalllistdetailspage.dart';
import 'package:pixelinventoryapp/apiCommunication/api_communication.dart';


class UserInfoWidget extends StatelessWidget {
  final String name;
  final String email;
  const UserInfoWidget({
    required this.name,
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          name,
          style: const TextStyle(fontSize: 16, color: Colors.white),
        ),
        const SizedBox(width: 10),
        Text(
          email,
          style: const TextStyle(fontSize: 16, color: Colors.white),
        ),
      ],
    );
  }
}

class DashBoard extends StatefulWidget {
  final String email;
  DashBoard({required this.email});
  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  List<Map<String, dynamic>> _componentList = [];
  String? _selectedDeviceOption;
  List<String> stringList = [];
  List<String> filteredList = [];
  List<String> selectedItems = [];
  Map<String, int> quantities = {};
  TextEditingController _textEditingController = TextEditingController();
  @override
  void initState() {
    super.initState();
    updateComponentsList('programmablecomponents');
    _selectedDeviceOption = 'Programmable';
  }

  void updateComponentsList(String getComponetsAPI) async {
    _componentList = await getComponentsListFromServer(getComponetsAPI);

    setState(() {
      stringList =
          _componentList.map((item) => item['c_name'].toString()).toList();
      filteredList.clear();
      filteredList.addAll(stringList);
    });
  }

  void add(String item) {
    setState(() {
      if ((quantities[item] ?? 0) <
          _componentList.firstWhere(
            (element) => element['c_name'] == item,
          )['no_of_counts']) {
        quantities[item] = (quantities[item] ?? 0) + 1;
      }
    });
  }

  void minus(String item) {
    setState(() {
      if (quantities[item]! > 0) {
        quantities[item] = (quantities[item]! - 1);
      }
    });
  }

  void filterList(String query) {
    setState(() {
      filteredList = stringList.where((element) {
        return element.toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  void addToSelectedList(String item) {
    if (!selectedItems.contains(item)) {
      setState(() {
        selectedItems.add(item);
        quantities[item] = 1;
      });
    }
  }

  void removeFromSelectedList(String item) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Delete Confirmation"),
          content: const Text(
              "Are you sure you want to remove this item from the selected list?"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("No"),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  selectedItems.remove(item);
                  quantities.remove(item);
                });
                Navigator.of(context).pop();
              },
              child: const Text("Yes"),
            ),
          ],
        );
      },
    );
  }

  void removeAllItems() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Remove All items Confirmation"),
          content: const Text(
              "Are you sure you want to remove all items from the selected list?"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("No"),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  selectedItems.clear();
                  quantities.clear();
                });
                Navigator.of(context).pop();
              },
              child: const Text("Yes"),
            ),
          ],
        );
      },
    );
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
          actions: [
    //Positioned(
     // top: 30,
      //left: 200,
    //  child: 
      UserInfoWidget(
        name: 'karthik',
        email: widget.email,
      ),
    //),
  ],
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
                  top: 15,
                  left: 15,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Tooltip(
                        message:
                            "Click here to view the programmable components",
                        child: ElevatedButton(
                          onPressed: () {
                            _selectedDeviceOption = 'Programmable';
                            updateComponentsList('programmablecomponents');
                          },
                          child: Text(
                            'Programmable',
                            style: TextStyle(color: Colors.black),
                          ),
                          style: ElevatedButton.styleFrom(
                            fixedSize: Size(200, 50),
                            backgroundColor:
                                _selectedDeviceOption == 'Programmable'
                                    ? Colors.green
                                    : null,
                          ),
                        ),
                      ),
                      const SizedBox(width: 30),
                      Tooltip(
                        message:
                            "Click here to view the non-programmable components",
                        child: ElevatedButton(
                          onPressed: () {
                            _selectedDeviceOption = 'Non Programmable';
                            updateComponentsList('nonprogrammablecomponents');
                          },
                          child: Text(
                            'Non-Programmable',
                            style: TextStyle(color: Colors.black),
                          ),
                          style: ElevatedButton.styleFrom(
                            fixedSize: Size(200, 50),
                            backgroundColor:
                                _selectedDeviceOption == 'Non Programmable'
                                    ? Colors.green
                                    : null,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 15,
                  right: 15,
                  child: Tooltip(
                    message: "Click here to view the Overall components list",
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.green),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Overalllist(),
                          ),
                        );
                      },
                      child: const Text('Overall List',
                          style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ),
                Positioned(
                  top: 70,
                  left: 15,
                  width: 550,
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: SizedBox(
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
                  top: 140,
                  left: 15,
                  width: 550,
                  bottom: 15,
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height - 150,
                    width: MediaQuery.of(context).size.width - 30,
                    child: ListView.builder(
                      itemCount: filteredList.length,
                      itemBuilder: (context, index) {
                        final component = _componentList.firstWhere((element) =>
                            element['c_name'] == filteredList[index]);
                        return ListTile(
                          title: Text(filteredList[index]),
                          subtitle: Text('Count: ${component['no_of_counts']}'),
                          onTap: () {
                            setState(() {
                              _textEditingController.text = filteredList[index];
                              addToSelectedList(filteredList[index]);
                            });
                          },
                        );
                      },
                    ),
                  ),
                ),
                Positioned(
                  top: 100,
                  right: 30,
                  child: Container(
                    height: 500,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          for (var item in selectedItems)
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Chip(
                                    label: Text(
                                      item.length > 15
                                          ? item.substring(0, 15)
                                          : item,
                                      textAlign: TextAlign
                                          .left, // Ensure text is left-aligned
                                    ),
                                    deleteIcon: const Icon(Icons.delete),
                                    deleteButtonTooltipMessage:
                                        "Click this to delete the item from the selected list",
                                    onDeleted: () {
                                      removeFromSelectedList(item);
                                    },
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    ("Status: Available"),
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 15),
                                  ),
                                  SizedBox(width: 10),
                                  IconButton(
                                    icon: const Icon(Icons.remove),
                                    color:
                                        const Color.fromARGB(255, 229, 30, 15),
                                    onPressed: () {
                                      minus(item);
                                    },
                                    iconSize: 20,
                                  ),
                                  Text(
                                    '${quantities[item]}',
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 18),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.add),
                                    color:
                                        const Color.fromARGB(255, 228, 37, 24),
                                    onPressed: () {
                                      add(item);
                                    },
                                    iconSize: 20,
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 15,
                  right: 120,
                  child: Row(
                    children: [
                      Tooltip(
                        message: "Click here to view the Remove All Items",
                        child: ElevatedButton(
                          onPressed: () {
                            removeAllItems();
                          },
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.green),
                          ),
                          child: const Text(
                            "Remove All",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 15,
                  right: 20,
                  child: Row(
                    children: [
                      Tooltip(
                        message: "Click here to Submit",
                        child: ElevatedButton(
                          onPressed: () {
                            sendSelectedItems(widget.email, selectedItems,
                                quantities); // Send the data to the backend
                          },
                          // getFluttertoastMessage(
                          //   Colors.black,
                          //   Colors.white,
                          //   "Successfully submitted",
                          //   Toast.LENGTH_LONG,
                          //   16.0,
                          //   //ToastGravity.TOP,);
                          //   ToastGravity.CENTER,
                          // );
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.green),
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
      ),
    );
  }
}
