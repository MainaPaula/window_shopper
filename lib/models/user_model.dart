class UserModel {
  String? uid;
  String? email;
  String? username;
  String? phoneNumber;
  String? accountType;
  String? password;

  UserModel({this.uid, this.email, this.username, this.phoneNumber,this.accountType, this.password});

  //receive data from server
  factory UserModel.fromMap(map){
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      username: map['username'],
      phoneNumber: map['phoneNumber'],
      password: map['password'],
      accountType: map['accountType'],
    );
  }

  //sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'userName': username,
      'phoneNumber': phoneNumber,
      'password': password,
      'accountType': accountType,
    };
  }

}