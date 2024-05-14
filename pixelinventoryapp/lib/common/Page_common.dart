enum ComponentCategory { programmable, nonprogrammable, allcomponents }

class GeneralSettings {
  String email = "";

  GeneralSettings();
}

class ComponentDetails {
  String componentName = "";
  List<String> availableAssetIds = [];
  List<String> selectedAssetIds = [];
  int count = 0;
  String status;

  ComponentDetails({
    this.componentName = "",
    required this.availableAssetIds,
    required this.selectedAssetIds,
    this.count = 0,
    this.status = '',
  });

  // Convert ComponentDetails to a Map
  Map<String, dynamic> toJson() {
    return {
      'component_name': componentName,      
      'asset_id': selectedAssetIds,
    };
  }
}

Map<String, ComponentDetails> mapCompnentList = {};
Map<String, ComponentDetails> mapSelectedCompnentList = {};
