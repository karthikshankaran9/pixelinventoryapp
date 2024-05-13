enum ComponentCategory { programmable, nonprogrammable, allcomponents }

class GeneralSettings {
  String email = "";

  GeneralSettings();
}

class ComponentDetails {
  String componentName = "";
  String assetId = "";
  int count = 0;

  ComponentDetails(
      {this.componentName = "", this.assetId = "", this.count = 0});

  // Convert ComponentDetails to a Map
  Map<String, dynamic> toJson() {
    return {
      'component_name': componentName,
      'assetId': assetId,
    };
  }
}

Map<String, ComponentDetails> mapCompnentList = {};
Map<String, ComponentDetails> mapSelectedCompnentList = {};
