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

<<<<<<< HEAD
  ComponentDetails({
    this.componentName = "",
    required this.availableAssetIds,
    required this.selectedAssetIds,
    this.count = 0,
    this.status = '',
  });
=======
  ComponentDetails(
      {this.componentName = "",
      required this.availableAssetIds,
      required this.selectedAssetIds,
      this.count = 0});
>>>>>>> 587d79c00cfe457d94835930f2b983955462bdfa

  // Convert ComponentDetails to a Map
  Map<String, dynamic> toJson() {
    return {
      'component_name': componentName,      
<<<<<<< HEAD
      'asset_id': selectedAssetIds,
=======
      'asset_id_list': selectedAssetIds,
>>>>>>> 587d79c00cfe457d94835930f2b983955462bdfa
    };
  }
}

Map<String, ComponentDetails> mapCompnentList = {};
Map<String, ComponentDetails> mapSelectedCompnentList = {};
