<<<<<<< HEAD
=======
// import 'package:flutter/material.dart';
// import 'package:pixelinventoryapp/page_over_all_list_detail.dart';
// import 'package:pixelinventoryapp/apiCommunication/page_api_communication.dart';
// import 'package:pixelinventoryapp/common/Page_common.dart';

// class UserInfoWidget extends StatelessWidget {
//   final String name;
//   final String email;
//   const UserInfoWidget({
//     required this.name,
//     required this.email,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.end,
//       children: [
//         Text(
//           name,
//           style: const TextStyle(fontSize: 16, color: Colors.white),
//         ),
//         const SizedBox(width: 10),
//         Text(
//           email,
//           style: const TextStyle(fontSize: 16, color: Colors.white),
//         ),
//       ],
//     );
//   }
// }

// class DashBoard extends StatefulWidget {
//   final String email;
//   DashBoard({required this.email});
//   @override
//   _DashBoardState createState() => _DashBoardState();
// }

// class _DashBoardState extends State<DashBoard> {
//   List<Map<String, dynamic>> _componentList = [];
//   ComponentCategory componentCategory = ComponentCategory.programmable;
//   List<String> lstComponentNames = [];
//   List<String> lstFilteredComponentNames = [];
//   Map<String, int> mapCompnentList = {};
//   Map<String, int> mapSelectedCompnentList = {};
//   final TextEditingController _textEditingController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     updateComponentsList(componentCategory.index);
//   }

//   void updateComponentsList(int componentCategory) async {
//     _componentList = await getComponentsListFromServer(componentCategory);
//     setState(() {
//       mapCompnentList = {
//         for (var item in _componentList)
//           item['c_name'].toString(): item['no_of_counts']
//       };

//       lstComponentNames = mapCompnentList.keys.toList();

//       lstFilteredComponentNames.clear();
//       lstFilteredComponentNames.addAll(lstComponentNames);
//       _textEditingController.clear();
//     });
//   }

//   void increaseDeviceCount(String item) {
//     setState(() {
//       if ((mapSelectedCompnentList[item] ?? 0) < mapCompnentList[item]!) {
//         mapSelectedCompnentList[item] =
//             (mapSelectedCompnentList[item] ?? 0) + 1;
//       }else {
//       showMaxCountPopup  ("$item");
//      }
//     });
//   }

//    void showMaxCountPopup(String item) {
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         title:const Text("Maximum Count Reached"),
//         content: Text("You have reached the maximum available count for $item."),
//         actions: <Widget>[
//           TextButton(
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//             child:const Text("OK"),
//           ),
//         ],
//       );
//     },
//   );
// }

//   void decreaseDeviceCount(String item) {
//     setState(() {
//       if (mapSelectedCompnentList[item]! > 0) {
//         mapSelectedCompnentList[item] = (mapSelectedCompnentList[item]! - 1);
//       }
//     });
//   }

//   void addComponentToFilterList(String query) {
//     setState(() {
//       lstFilteredComponentNames = lstComponentNames.where((element) {
//         return element.toLowerCase().contains(query.toLowerCase());
//       }).toList();
//     });
//   }

//   void addComponentToSelectedList(String item) {
//     if (!mapSelectedCompnentList.containsKey(item)) {
//       setState(() {
//         mapSelectedCompnentList[item] = 1;
//       });
//     }
//   }

//   void removeFromSelectedList(String item) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text("Remove Confirmation"),
//           content: const Text(
//               "Are you sure you want to remove this item from the selected list?"),
//           actions: <Widget>[
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: const Text("No"),
//             ),
//             TextButton(
//               onPressed: () {
//                 setState(() {
//                   mapSelectedCompnentList.remove(item);
//                 });
//                 Navigator.of(context).pop();
//               },
//               child: const Text("Yes"),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   void removeAllItems() {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text("Remove All items Confirmation"),
//           content: const Text(
//               "Are you sure you want to remove all items from the selected list?"),
//           actions: <Widget>[
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: const Text("No"),
//             ),
//             TextButton(
//               onPressed: () {
//                 setState(() {
//                   mapSelectedCompnentList.clear();
//                 });
//                 Navigator.of(context).pop();
//               },
//               child: const Text("Yes"),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Select the Components List'),
//           flexibleSpace: Container(
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [Colors.teal.shade200, Colors.purple.shade900],
//               ),
//             ),
//           ),
//           leading: IconButton(
//             icon: const Icon(Icons.arrow_back),
//             onPressed: () {
//               Navigator.pop(context);
//             },
//           ),
//           actions: [
//             Positioned(
//               top: 15,
//               right: 100,
//               child: UserInfoWidget(
//                 name: '',
//                 email: widget.email,
//               ),
//             ),
//           ],
//         ),
//         body: Align(
//           child: Container(
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [Colors.teal.shade200, Colors.purple.shade900],
//               ),
//             ),
//             child: Stack(
//               children: [
//                 Positioned(
//                   top: 15,
//                   left: 20,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       Tooltip(
//                         message:
//                             "Click this to view the programmable components",
//                         child: ElevatedButton(
//                           onPressed: () {
//                             setState(() {
//                               componentCategory =
//                                   ComponentCategory.programmable;
//                             });
//                             updateComponentsList(
//                                 ComponentCategory.programmable.index);
//                           },
//                           style: ElevatedButton.styleFrom(
//                             fixedSize: const Size(200, 50),
//                             backgroundColor: componentCategory ==
//                                     ComponentCategory.programmable
//                                 ? Colors.green
//                                 : null,
//                           ),
//                           child: const Text(
//                             'Programmable',
//                             style: TextStyle(color: Colors.black),
//                           ),
//                         ),
//                       ),
//                       const SizedBox(width: 30),
//                       Tooltip(
//                         message:
//                             "Click this to view the non-programmable components",
//                         child: ElevatedButton(
//                           onPressed: () {
//                             setState(() {
//                               componentCategory =
//                                   ComponentCategory.nonprogrammable;
//                             });
//                             updateComponentsList(
//                                 ComponentCategory.nonprogrammable.index);
//                           },
//                           style: ElevatedButton.styleFrom(
//                             fixedSize: const Size(200, 50),
//                             backgroundColor: componentCategory ==
//                                     ComponentCategory.nonprogrammable
//                                 ? Colors.green
//                                 : null,
//                           ),
//                           child: const Text(
//                             'Non-Programmable',
//                             style: TextStyle(color: Colors.black),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Positioned(
//                   top: 15,
//                   right: 15,
//                   child: Tooltip(
//                     message: "Click this to view the Overall components list",
//                     child: ElevatedButton(
//                       style: ButtonStyle(
//                         backgroundColor:
//                             MaterialStateProperty.all<Color>(Colors.green),
//                       ),
//                       onPressed: () async {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => Overalllist(),
//                           ),
//                         );
//                       },
//                       child: const Text('Overall List',
//                           style: TextStyle(color: Colors.white)),
//                     ),
//                   ),
//                 ),
//                 Positioned(
//                   top: 70,
//                   left: 15,
//                   width: 550,
//                   child: Padding(
//                     padding: const EdgeInsets.all(4.0),
//                     child: SizedBox(
//                       width: 300,
//                       child: TextField(
//                         controller: _textEditingController,
//                         onChanged: (value) {
//                           addComponentToFilterList(value);
//                         },
//                         decoration: const InputDecoration(
//                           labelText: 'Search',
//                           hintText: 'Type to search...',
//                           prefixIcon: Icon(Icons.search),
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.all(
//                               Radius.circular(10.0),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 Positioned(
//                   top: 140,
//                   left: 15,
//                   width: 550,
//                   bottom: 15,
//                   child: SizedBox(
//                     height: MediaQuery.of(context).size.height - 150,
//                     width: MediaQuery.of(context).size.width - 30,
//                     child: ListView.builder(
//                       itemCount: lstFilteredComponentNames.length,
//                       itemBuilder: (context, index) {
//                         return ListTile(
//                           title: Text(lstFilteredComponentNames[index]),
//                           subtitle: Text(
//                               'Count: ${mapCompnentList[lstFilteredComponentNames[index]]}'),
//                           onTap: () {
//                             setState(() {
//                               _textEditingController.text =
//                                   lstFilteredComponentNames[index];
//                               addComponentToSelectedList(
//                                   lstFilteredComponentNames[index]);
//                             });
//                           },
//                         );
//                       },
//                     ),
//                   ),
//                 ),
//                 Positioned(
//                   top: 100,
//                   right: 30,
//                   child: Container(
//                     height: 400,
//                     child: SingleChildScrollView(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.end,
//                         children: [
//                           for (var item
//                               in mapSelectedCompnentList.keys.toList())
//                             Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Row(
//                                 children: [
//                                   Chip(
//                                     label: SizedBox(
//                                       width: 100,
//                                       child: Text(
//                                         item.length > 15
//                                             ? item.substring(0, 15)
//                                             : item,
//                                         textAlign: TextAlign.left,
//                                         overflow: TextOverflow.ellipsis,
//                                       ),
//                                     ),
//                                     deleteIcon: const Icon(Icons.delete),
//                                     deleteButtonTooltipMessage:
//                                         "Click this to delete the item from the selected list",
//                                     onDeleted: () {
//                                       removeFromSelectedList(item);
//                                     },
//                                   ),
//                                   const SizedBox(width: 5),
//                                   const Text(
//                                     ("Status: Available"),
//                                     style: TextStyle(
//                                         color: Colors.white, fontSize: 15),
//                                   ),
//                                   const SizedBox(width: 10),
//                                   IconButton(
//                                     icon: const Icon(Icons.remove),
//                                     color:
//                                         const Color.fromARGB(255, 229, 30, 15),
//                                     onPressed: () {
//                                       decreaseDeviceCount(item);
//                                     },
//                                     iconSize: 20,
//                                   ),
//                                   Text(
//                                     '${mapSelectedCompnentList[item]}',
//                                     style: const TextStyle(
//                                         color: Colors.white, fontSize: 18),
//                                   ),
//                                   IconButton(
//                                     icon: const Icon(Icons.add),
//                                     color:
//                                         const Color.fromARGB(255, 228, 37, 24),
//                                     onPressed: () {
//                                       increaseDeviceCount(item);
//                                     },
//                                     iconSize: 20,
//                                   ),
//                                 ],
//                               ),
//                             ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//                 Positioned(
//                   bottom: 15,
//                   right: 120,
//                   child: Row(
//                     children: [
//                       Tooltip(
//                         message: "Click this to Remove All Items",
//                         child: ElevatedButton(
//                           onPressed: () {
//                             removeAllItems();
//                           },
//                           style: ButtonStyle(
//                             backgroundColor:
//                                 MaterialStateProperty.all<Color>(Colors.green),
//                           ),
//                           child: const Text(
//                             "Remove All",
//                             style: TextStyle(color: Colors.white),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Positioned(
//                   bottom: 15,
//                   right: 20,
//                   child: Row(
//                     children: [
//                       Tooltip(
//                         message: "Click this to send an email",
//                         child: ElevatedButton(
//                           onPressed: () {
//                             sendSelectedItems(widget.email, mapSelectedCompnentList);
//                           },
//                           style: ButtonStyle(
//                             backgroundColor:
//                                 MaterialStateProperty.all<Color>(Colors.green),
//                           ),
//                           child: const Text(
//                             "Submit",
//                             style: TextStyle(color: Colors.white),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

>>>>>>> 31c0b17b4ad1f39e48f6716969daf0c4984ad92b
import 'package:flutter/material.dart';
import 'package:pixelinventoryapp/page_over_all_list_detail.dart';
import 'package:pixelinventoryapp/apiCommunication/page_api_communication.dart';
import 'package:pixelinventoryapp/common/page_common.dart';
import 'package:pixelinventoryapp/common/page_data_process.dart';

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
  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  List<Map<String, dynamic>> _componentList = [];
  ComponentCategory componentCategory = ComponentCategory.programmable;
  List<String> lstComponentNames = [];
  List<String> lstFilteredComponentNames = [];

  final TextEditingController _textEditingController = TextEditingController();
  final ScrollController _listScrollController = ScrollController();
  GeneralSettings generalSettings = GeneralSettings();

  @override
  void initState() {
    super.initState();
    updateComponentsList(componentCategory.index);
  }

  void updateComponentsList(int componentCategory) async {
    ComponentDetails componentDetails = ComponentDetails();
    _componentList = await getComponentsListFromServer(componentCategory);
    setState(() {
      generalSettings = getGeneralSettings();
      // mapCompnentList = {
      //   for (var item in _componentList)
      //     item['c_name'].toString(): item['no_of_counts']
      // };

<<<<<<< HEAD
      mapCompnentList.clear();
      for (var item in _componentList) {
        componentDetails = ComponentDetails();
=======
      for (var item in _componentList) {
>>>>>>> 31c0b17b4ad1f39e48f6716969daf0c4984ad92b
        componentDetails.assetId = item['asset_no'];
        componentDetails.count = item['no_of_counts'];
        componentDetails.componentName = item['c_name'].toString();
        mapCompnentList[item['c_name'].toString()] = componentDetails;
      }

      lstComponentNames = mapCompnentList.keys.toList();

      lstFilteredComponentNames.clear();
      lstFilteredComponentNames.addAll(lstComponentNames);
      _textEditingController.clear();
<<<<<<< HEAD
=======
      //scrollToBottom(); // Scroll to bottom after updating the list
>>>>>>> 31c0b17b4ad1f39e48f6716969daf0c4984ad92b
    });
  }

  void scrollToBottom() {
    _listScrollController
        .jumpTo(_listScrollController.position.maxScrollExtent);
  }

  void increaseDeviceCount(String item) {
    setState(() {
      if ((mapSelectedCompnentList[item]!.count) <
          mapCompnentList[item]!.count) {
        mapSelectedCompnentList[item]!.count += 1;
<<<<<<< HEAD
      } else {
        showMaxCountPopup("$item");
=======
>>>>>>> 31c0b17b4ad1f39e48f6716969daf0c4984ad92b
      }
    });
  }

  void showMaxCountPopup(String item) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Maximum Count Reached"),
          content:
              Text("You have reached the maximum available count for $item."),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  void decreaseDeviceCount(String item) {
    setState(() {
      if (mapSelectedCompnentList[item]!.count > 0) {
        mapSelectedCompnentList[item]!.count -= 1;
      }
    });
  }

  void addComponentToFilterList(String query) {
    setState(() {
      lstFilteredComponentNames = lstComponentNames.where((element) {
        return element.toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  void addComponentToSelectedList(String selectedItem) {
    if (!mapSelectedCompnentList.containsKey(selectedItem)) {
      setState(() {
        ComponentDetails componentDetails = ComponentDetails();
        ComponentDetails selectedComponentDetails = ComponentDetails();
        componentDetails = mapCompnentList[selectedItem]!;

        if (componentDetails.count > 0) {
          selectedComponentDetails.count = 1;
        } else {
          selectedComponentDetails.count = 0;
        }

        selectedComponentDetails.assetId = componentDetails.assetId;
        selectedComponentDetails.componentName = componentDetails.componentName;
        mapSelectedCompnentList[selectedItem] = selectedComponentDetails;
      });
    }
  }
<<<<<<< HEAD
=======
// void addComponentToSelectedList(String item) {
//   if (!mapSelectedCompnentList.containsKey(item)) {
//     setState(() {
//       mapSelectedCompnentList[item] = 1;
//     });
//     // Get the position of the top item
//     double topPosition = 0.0;
//     if (_listScrollController.hasClients) {
//       topPosition = _listScrollController.position.minScrollExtent;
//     }
//     // Scroll to the top after adding the item
//     _listScrollController.animateTo(
//       topPosition,
//       duration: Duration(milliseconds: 500),
//       curve: Curves.easeInOut,
//     );
//   }
// }
>>>>>>> 31c0b17b4ad1f39e48f6716969daf0c4984ad92b

  void removeFromSelectedList(String item) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Remove Confirmation"),
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
                  mapSelectedCompnentList.remove(item);
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
                  mapSelectedCompnentList.clear();
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
            Positioned(
              top: 15,
              right: 100,
              child: UserInfoWidget(
                name: '',
                email: generalSettings.email,
              ),
            ),
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
                  left: 20,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Tooltip(
                        message:
                            "Click this to view the programmable components",
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              componentCategory =
                                  ComponentCategory.programmable;
                            });
                            updateComponentsList(
                                ComponentCategory.programmable.index);
                          },
                          style: ElevatedButton.styleFrom(
                            fixedSize: const Size(200, 50),
                            backgroundColor: componentCategory ==
                                    ComponentCategory.programmable
                                ? Colors.green
                                : null,
                          ),
                          child: const Text(
                            'Programmable',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                      const SizedBox(width: 30),
                      Tooltip(
                        message:
                            "Click this to view the non-programmable components",
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              componentCategory =
                                  ComponentCategory.nonprogrammable;
                            });
                            updateComponentsList(
                                ComponentCategory.nonprogrammable.index);
                          },
                          style: ElevatedButton.styleFrom(
                            fixedSize: const Size(200, 50),
                            backgroundColor: componentCategory ==
                                    ComponentCategory.nonprogrammable
                                ? Colors.green
                                : null,
                          ),
                          child: const Text(
                            'Non-Programmable',
                            style: TextStyle(color: Colors.black),
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
                    message: "Click this to view the Overall components list",
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.green),
                      ),
                      onPressed: () async {
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
                          addComponentToFilterList(value);
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
<<<<<<< HEAD
=======
                      //controller: _listScrollController,
>>>>>>> 31c0b17b4ad1f39e48f6716969daf0c4984ad92b
                      itemCount: lstFilteredComponentNames.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(lstFilteredComponentNames[index]),
                          subtitle: Text(
                              'Count: ${mapCompnentList[lstFilteredComponentNames[index]]!.count}'),
                          onTap: () {
                            setState(() {
                              _textEditingController.text =
                                  lstFilteredComponentNames[index];
                              addComponentToSelectedList(
                                  lstFilteredComponentNames[index]);
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
                    height: 400,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          for (var item
                              in mapSelectedCompnentList.keys.toList())
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Chip(
                                    label: SizedBox(
                                      width: 100,
                                      child: Text(
                                        item.length > 15
                                            ? item.substring(0, 15)
                                            : item,
                                        textAlign: TextAlign.left,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    deleteIcon: const Icon(Icons.delete),
                                    deleteButtonTooltipMessage:
                                        "Click this to delete the item from the selected list",
                                    onDeleted: () {
                                      removeFromSelectedList(item);
                                    },
                                  ),
                                  const SizedBox(width: 5),
                                  const Text(
                                    ("Status: Available"),
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 15),
                                  ),
                                  const SizedBox(width: 10),
                                  IconButton(
                                    icon: const Icon(Icons.remove),
                                    color:
                                        const Color.fromARGB(255, 229, 30, 15),
                                    onPressed: () {
                                      decreaseDeviceCount(item);
                                    },
                                    iconSize: 20,
                                  ),
                                  Text(
                                    '${mapSelectedCompnentList[item]!.count}',
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 18),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.add),
                                    color:
                                        const Color.fromARGB(255, 228, 37, 24),
                                    onPressed: () {
                                      increaseDeviceCount(item);
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
                        message: "Click this to Remove All Items",
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
                        message: "Click this to send an email",
                        child: ElevatedButton(
                          onPressed: () {
                            sendSelectedItems();
                          },
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
