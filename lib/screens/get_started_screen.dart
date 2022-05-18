import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:window_shopper/business/business_signup.dart';
import 'package:window_shopper/screens/signup_screen.dart';


String? email;

class GetStartedScreen extends StatefulWidget {
  const GetStartedScreen({Key? key}) : super(key: key);

  @override
  _GetStartedScreenState createState() => _GetStartedScreenState();
}

class _GetStartedScreenState extends State<GetStartedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        //constraints: const BoxConstraints.expand(),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: NetworkImage("https://www.pexels.com/photo/person-standing-infront-of-a-display-window-3056059/"),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(35.0),
            child: Form(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const Text(
                      'Window',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 36, color: Colors.black, fontWeight: FontWeight.bold)),
                  const Text(
                          'Shopper',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 36, color: Colors.black, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 100),

                  Material(
                    elevation: 5,
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.redAccent,
                    child: MaterialButton(
                      padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                      minWidth: MediaQuery.of(context).size.width,
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const SignUpScreen()));
                      },
                      child: const Text(
                          'Customer Signup',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),

                  Material(
                    elevation: 5,
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.redAccent,
                    child: MaterialButton(
                      padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                      minWidth: MediaQuery.of(context).size.width,
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const BusinessSignUpScreen()));
                      },
                      child: const Text(
                          'Business Signup',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const <Widget>[
                       Flexible(
                        child: Text("By signing in, you confirm that you have read the Terms & Conditions, and that you understand them and that you agree to be bound by them",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
