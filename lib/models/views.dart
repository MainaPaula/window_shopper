class ProfileViews {
  late DateTime createdOn;
  String? clickID;

  ProfileViews.fromMap(Map<String, dynamic> data) {
    createdOn = data['createdOn'];
    clickID = data['clickId'];
  }


}