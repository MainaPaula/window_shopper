import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:window_shopper/business/business_login.dart';
import 'package:window_shopper/models/user_model.dart';
import '../screens/verify_screen.dart';

class BusinessSignUpScreen extends StatefulWidget {
  const BusinessSignUpScreen({Key? key}) : super(key: key);

  @override
  _BusinessSignUpScreenState createState() => _BusinessSignUpScreenState();
}

class _BusinessSignUpScreenState extends State<BusinessSignUpScreen> {
  final _auth = FirebaseAuth.instance;

  //form key for validation
  final _formKey = GlobalKey<FormState>();

  //Editing controller
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController _phoneNoController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //username field
    final usernameField = TextFormField(
      autofocus: false,
      controller: usernameController,
      validator: (value){
        RegExp regex = RegExp(r'^.{3,}$');

        if(value!.isEmpty) {
          return ('Please enter a username');
        }
        if(!regex.hasMatch(value)){
          return ('Enter a valid username(Minimum of 3 characters');
        }
        return null;
      },
      onSaved: (value) {
        usernameController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.person),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: 'Username',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )
      ),
    );


    //email field
    final emailField = TextFormField(
      autofocus: false,
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if(value!.isEmpty) {
          return ('Please enter your email');
        }
        //regex expression for email validation
        if(!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)) {
          return ('Please enter a valid email');
        }
        return null;
      },
      onSaved: (value) {
        emailController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.mail),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: 'Email',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )
      ),
    );

    final phoneNoField = TextFormField(
      autofocus: false,
      controller: _phoneNoController,
      keyboardType: TextInputType.phone,
      validator: (value) {
        if(value!.isEmpty) {
          return ('Please enter your phone number');
        }
        //regex expression for phone number validation
        /*if(!RegExp('^([0|+[0-9]{1,5})?([0-9]{10})').hasMatch(value)) {
          return ('Please enter a valid phone number');
        }*/
        return null;
      },
      onSaved: (value) {
        _phoneNoController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.phone_android),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: 'Phone Number',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )
      ),
    );


    //password field
    final passwordField = TextFormField(
      autofocus: false,
      controller: passwordController,
      obscureText: true,
      validator: (value) {
        RegExp regex = RegExp(r'^.{8,}$');

        if(value!.isEmpty) {
          return ('Please enter your password');
        }
        if(!regex.hasMatch(value)){
          return ('Password should have a minimum of 8 characters');
        }
      },
      onSaved: (value) {
        passwordController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.vpn_key),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: 'Password',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )
      ),
    );

    //password field
    final confirmPasswordField = TextFormField(
      autofocus: false,
      controller: confirmPasswordController,
      obscureText: true,
      validator: (value) {
        RegExp regex = RegExp(r'^.{8,}$');

        if(value!.isEmpty) {
          return ('Please enter to confirm your password');
        }
        if(!regex.hasMatch(value)){
          return ('Password should have a minimum of 8 characters');
        }
        if( passwordController.text != value){
          return ("Passwords do not match");
        }
        return null;
      },
      onSaved: (value) {
        confirmPasswordController.text = value!;
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.vpn_key),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: 'Confirm Password',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )
      ),
    );

    final registerButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(25),
      color: Colors.redAccent,
      child: MaterialButton(
        padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          register(emailController.text, passwordController.text);
        },
        child: const Text(
            'Register',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)
        ),
      ),
    );
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.redAccent),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(35.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      const Text(
                          'Hello There Business',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 36, color: Colors.black, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10),

                      usernameField,
                      const SizedBox(height: 10),

                      emailField,
                      const SizedBox(height: 10),

                      phoneNoField,
                      const SizedBox(height: 10),

                      passwordField,
                      const SizedBox(height: 10),

                      confirmPasswordField,
                      const SizedBox(height: 10),

                      registerButton,
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Text("Already have an account? "),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const BusinessLoginScreen()));
                            },
                            child: const Text(
                              'Login',
                              style: TextStyle(
                                  color: Colors.redAccent,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        )
    );
  }

  //register function
  void register(String email, String password) async {
    if(_formKey.currentState!.validate()){
      await _auth.createUserWithEmailAndPassword(email: email, password: password)
          .then((value)=> {
        postDetailsToFirestore()
      }).catchError((error)=> {
        Fluttertoast.showToast(msg: error!.message)
      });
    }
  }

  postDetailsToFirestore() async {
    //calling Firestore
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    //calling userModel
    User? user = _auth.currentUser;
    UserModel userModel = UserModel();

    //writing the values
    userModel.email = user!.email;
    userModel.uid = user.uid;
    userModel.username = usernameController.text;
    userModel.phoneNumber = _phoneNoController.text;
    userModel.password = passwordController.text;
    userModel.accountType = 'Business';
    

    //sending the values
    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap());
    Fluttertoast.showToast(msg: 'Account created successfully',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        fontSize: 16.0);
   // Navigator.push(context, MaterialPageRoute(builder: (context) => const BusinessLoginScreen()));
    Navigator.push(context, MaterialPageRoute(builder: (context) => VerificationScreen(_phoneNoController.text)));
  }
}
