//These are the plugins required for the rendering of this screen
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:window_shopper/business/main_business.dart';
import 'package:window_shopper/screens/customers/main_screen.dart';
import 'package:window_shopper/screens/get_started_screen.dart';

//The email variable is intialized globally and is used for shared preferences
String? email;

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late final user = FirebaseAuth.instance.currentUser?.uid; // Fetch the user ID for the database
  var accType;

// This function is used to redirect user the to different screens based on their account type when they launch the app
  redirect(email) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(user)
        .get()
        .then((value) {
            accType = value.data()!['accountType'];
    });
    if(email == null) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => GetStartedScreen()));
    }else if (accType == "Customer") {
        Navigator.push(context, MaterialPageRoute(builder: (context) => MainScreen()));
      }
    else {
    Navigator.push(context, MaterialPageRoute(builder: (context) => BusinessMainScreen()));
    }
  }

  @override
  void initState() {
    getValidationData().whenComplete(() async {
      Timer(const Duration(seconds: 1), () => Get.to(redirect(email)));
    });
    super.initState();
  }
// This function checks whether the user has been logged into the system before
  Future getValidationData() async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var obtainedEmail = sharedPreferences.getString('email');
    setState(() {
      email = obtainedEmail;
    });
    print(email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.redAccent,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Image(image: AssetImage('assets/windowshopper.png'),
              width: 250,
              height: 250,
            ),
            Padding(
                padding: EdgeInsets.only(top: 8.0)
            )
          ],
        ),
      ),
    );
  }
}
