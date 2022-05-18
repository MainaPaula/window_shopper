class Facebook {
  late DateTime createdOn;
  String? clickID;

  Facebook({this.clickID, required this.createdOn});

  Map<String, dynamic> toMap() {
    return {
      "createdOn": createdOn,
      "clickID": clickID,
    };
  }

  Facebook.fromMap(Map<String, dynamic> data) {
    createdOn = data['createdOn'];
    clickID = data['clickId'];
  }
}

class Twitter {
  late DateTime createdOn;
  String? clickID;

  Twitter({this.clickID, required this.createdOn});

  Map<String, dynamic> toMap() {
    return {
      "createdOn": createdOn,
      "clickID": clickID,
    };
  }

  Twitter.fromMap(Map<String, dynamic> data) {
    createdOn = data['createdOn'];
    clickID = data['clickId'];
  }
}

class Instagram {
  late DateTime createdOn;
  String? clickID;

  Instagram({this.clickID, required this.createdOn});

  Map<String, dynamic> toMap() {
    return {
      "createdOn": createdOn,
      "clickID": clickID,
    };
  }

  Instagram.fromMap(Map<String, dynamic> data) {
    createdOn = data['createdOn'];
    clickID = data['clickId'];
  }
}

class Pinterest {
  late DateTime createdOn;
  String? clickID;

  Pinterest({this.clickID, required this.createdOn});

  Map<String, dynamic> toMap() {
    return {
      "createdOn": createdOn,
      "clickID": clickID,
    };
  }

  Pinterest.fromMap(Map<String, dynamic> data) {
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