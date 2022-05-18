class BusinessOwners {
  String? uid;
  String? email;
  String? username;
  String? phoneNumber;
  String? password;

  BusinessOwners({this.uid, this.email, this.username, this.phoneNumber,this.password});

  //receive data from server
  factory BusinessOwners.fromMap(map){
    return BusinessOwners(
      uid: map['uid'],
      email: map['email'],
      username: map['username'],
      phoneNumber: map['phoneNumber'],
      password: map['password'],
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
    };
  }

}