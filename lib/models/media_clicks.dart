class FacebookModel {
  late DateTime createdOn;
  String? clickID;

  FacebookModel({this.clickID, required this.createdOn});

  Map<String, dynamic> toMap() {
    return {
      "createdOn": createdOn,
      "clickID": clickID,
    };
  }

  FacebookModel.fromMap(Map<String, dynamic> data) {
    createdOn = data['createdOn'];
    clickID = data['clickId'];
  }
}

class TwitterModel {
  late DateTime createdOn;
  String? clickID;

  TwitterModel({this.clickID, required this.createdOn});

  Map<String, dynamic> toMap() {
    return {
      "createdOn": createdOn,
      "clickID": clickID,
    };
  }

  TwitterModel.fromMap(Map<String, dynamic> data) {
    createdOn = data['createdOn'];
    clickID = data['clickId'];
  }
}

class InstagramModel {
  late DateTime createdOn;
  String? clickID;

  InstagramModel({this.clickID, required this.createdOn});

  Map<String, dynamic> toMap() {
    return {
      "createdOn": createdOn,
      "clickID": clickID,
    };
  }

  InstagramModel.fromMap(Map<String, dynamic> data) {
    createdOn = data['createdOn'];
    clickID = data['clickId'];
  }
}

class PinterestModel {
  late DateTime createdOn;
  String? clickID;

  PinterestModel({this.clickID, required this.createdOn});

  Map<String, dynamic> toMap() {
    return {
      "createdOn": createdOn,
      "clickID": clickID,
    };
  }

  PinterestModel.fromMap(Map<String, dynamic> data) {
    createdOn = data['createdOn'];
    clickID = data['clickId'];
  }
}

class ProfileViewsModel {
  late DateTime createdOn;
  String? clickID;

  ProfileViewsModel({this.clickID, required this.createdOn});

  ProfileViewsModel.fromMap(Map<String, dynamic> data) {
    createdOn = data['createdOn'];
    clickID = data['clickId'];
  }

  Map<String, dynamic> toMap() {
    return {
      "createdOn": createdOn,
      "clickID": clickID,
    };
  }
}