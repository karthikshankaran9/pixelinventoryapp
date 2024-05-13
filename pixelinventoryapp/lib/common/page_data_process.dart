import 'dart:convert';
import 'package:pixelinventoryapp/common/page_common.dart';

GeneralSettings generalSettings = GeneralSettings();

void setGeneralSettings(GeneralSettings settings) {
  generalSettings = settings;
}

GeneralSettings getGeneralSettings() {
  return generalSettings;
}

<<<<<<< HEAD
String getPayloadWithMailContent() {

  List<ComponentDetails> componentList =
      mapSelectedCompnentList.values.toList();
=======

String getPayloadWithMailContent() {
  // List<Map<String, dynamic>> componentList =
  //     mapSelectedCompnentList.values.cast<Map<String, dynamic>>().toList();

  List<ComponentDetails> componentList =
      mapSelectedCompnentList.values.toList();
  //String jsonString = jsonEncode(mapSelectedCompnentList.values.toJson());
>>>>>>> 31c0b17b4ad1f39e48f6716969daf0c4984ad92b

  List<Map<String, dynamic>> componentMapList =
      componentList.map((component) => component.toJson()).toList();

  String jsonString = jsonEncode(componentMapList);

  Map<String, dynamic> payload = {
    'employee_name': getGeneralSettings().email,
    'request': 'Component Request',
    'component_list': jsonString,
  };

  return jsonEncode(payload);
}
