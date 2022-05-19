import 'package:cloud_firestore/cloud_firestore.dart';

class Instagram{
  late Timestamp createdOn;
  String? clickID;

  Instagram.fromMap(Map<String, dynamic> data) {
    createdOn = data['createdOn'];
    clickID = data['clickId'];
  }

}

class Facebook{
  late Timestamp createdOn;
  String? clickID;

  Facebook.fromMap(Map<String, dynamic> data) {
    createdOn = data['createdOn'];
    clickID = data['clickId'];
  }

}class Twitter{
  late Timestamp createdOn;
  String? clickID;

  Twitter.fromMap(Map<String, dynamic> data) {
    createdOn = data['createdOn'];
    clickID = data['clickId'];
  }

}class Pinterest{
  late Timestamp createdOn;
  String? clickID;

  Pinterest.fromMap(Map<String, dynamic> data) {
    createdOn = data['createdOn'];
    clickID = data['clickId'];
  }

}