class Searches {
  String? searchID;
  late DateTime createdOn;
  String? searchText;

  Searches({required this.createdOn, this.searchID, this.searchText});

  Map<String, dynamic> toMap() {
    return{
      "searchID": searchID,
      "createdOn": createdOn,
      "searchText": searchText,
    };
  }

  Searches.fromMap(Map<String, dynamic> data) {
    searchID = data["searchID"];
    searchText = data["searchText"];
    createdOn = data["createdOn"];
  }
}