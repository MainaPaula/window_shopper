class SearchModel {
  String? searchID;
  late DateTime createdOn;
  String? searchText;

  SearchModel.fromMap(Map<String, dynamic> data) {
    searchID = data["searchID"];
    searchText = data["searchText"];
    createdOn = data["createdOn"];
  }
}