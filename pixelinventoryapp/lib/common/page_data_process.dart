import 'dart:convert';
import 'package:pixelinventoryapp/common/page_common.dart';

GeneralSettings generalSettings = GeneralSettings();

void setGeneralSettings(GeneralSettings settings) {
  generalSettings = settings;
}

GeneralSettings getGeneralSettings() {
  return generalSettings;
}

String getPayloadWithMailContent() {

  List<ComponentDetails> componentList =
      mapSelectedCompnentList.values.toList();

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
