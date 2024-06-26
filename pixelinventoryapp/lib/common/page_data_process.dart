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

  Map<String, dynamic> payload = {
    'employee_name': getGeneralSettings().name,
    'request': 'Component Request',
    'component_list': componentMapList,
  };

  return jsonEncode(payload);
}
