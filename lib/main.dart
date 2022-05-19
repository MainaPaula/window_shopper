import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:window_shopper/location/location_controller.dart';
import 'package:window_shopper/notifier/media_notifier.dart';
import 'package:window_shopper/screens/splash_screen.dart';
import 'notifier/biz_notifier.dart';
import 'package:get/get.dart';

import 'notifier/profile_views_model.dart';
import 'notifier/review_notifier.dart';
import 'notifier/search_notifier.dart';


late SharedPreferences sharedPreferences;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => BusinessNotifier(),
      ),
      ChangeNotifierProvider(
        create: (context) => ReviewNotifier(),
      ),
      ChangeNotifierProvider(
        create: (context) => SearchNotifier(),
      ),
      ChangeNotifierProvider(
        create: (context) => ProfileViewsNotifier(),
      ),
      ChangeNotifierProvider(
        create: (context) => TwitterNotifier(),
      ),
      ChangeNotifierProvider(
        create: (context) => InstagramNotifier(),
      ),
      ChangeNotifierProvider(
        create: (context) => FacebookNotifier(),
      ),
      ChangeNotifierProvider(
        create: (context) => PinterestNotifier(),
      ),
    ],
    child: const MyApp()),
  );

}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(LocationController());
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Welcome',
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.red,
        fontFamily: 'Montserrat'
      ),
      home: SplashScreen(),
    );
  }
}
