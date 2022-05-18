import 'package:flutter/material.dart';
import 'package:window_shopper/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

 class ForgotPasswordScreen extends StatefulWidget {
   const ForgotPasswordScreen({Key? key}) : super(key: key);

   @override
   _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
 }

 class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
   final _formKey = GlobalKey<FormState>();
   final _auth = FirebaseAuth.instance;
   final TextEditingController _forgotPasswordController = TextEditingController();

   @override
   Widget build(BuildContext context) {
     final forgotPasswordField = TextFormField(
       autofocus: false,
       controller: _forgotPasswordController,
       keyboardType: TextInputType.emailAddress,
       onSaved: (value) {
         _forgotPasswordController.text = value!;
       },
       textInputAction: TextInputAction.done,
       decoration: InputDecoration(
           contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
           hintText: 'Enter Email',
           border: OutlineInputBorder(
             borderRadius: BorderRadius.circular(10),
           )
       ),
     );

     final continueButton = Material(
       elevation: 5,
       borderRadius: BorderRadius.circular(25),
       color: Colors.redAccent,
       child: MaterialButton(
         padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
         minWidth: MediaQuery.of(context).size.width,
         onPressed: () {
           _auth.sendPasswordResetEmail(email: _forgotPasswordController.text);
           Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
         },
         child: const Text(
             'Continue',
             textAlign: TextAlign.center,
             style: TextStyle(
                 fontSize: 18,
                 color: Colors.white,
                 fontWeight: FontWeight.bold)
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
                         'Forgot Password',
                         textAlign: TextAlign.center,
                         style: TextStyle(
                             fontSize: 36, color: Colors.black, fontWeight: FontWeight.bold)),
                     const SizedBox(height: 15),

                     Row(
                       mainAxisAlignment: MainAxisAlignment.center,
                       crossAxisAlignment: CrossAxisAlignment.center,
                       children: const <Widget>[
                         Flexible(
                           child: Text("Please enter your email to receive a link to reset your password ",
                             textAlign: TextAlign.center,
                             style: TextStyle(
                               fontSize: 18,
                               color: Colors.black,
                               fontWeight: FontWeight.normal,
                             ),
                           ),
                         ),
                       ],
                     ),
                     const SizedBox(height: 30),

                     forgotPasswordField,
                     const SizedBox(height: 75),

                     continueButton,
                   ],
                 ),
               ),
             ),
           ),
         ),
       ),
     );
   }
 }
