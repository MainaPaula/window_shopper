import 'package:flutter/material.dart';
import 'package:window_shopper/business/analytics_screen.dart';
import 'package:window_shopper/business/explore_screen.dart';
import 'package:window_shopper/business/listing_screen.dart';
import 'package:window_shopper/business/profile.dart';



class BusinessMainScreen extends StatefulWidget {
  const BusinessMainScreen({Key? key}) : super(key: key);

  @override
  _BusinessMainScreenState createState() => _BusinessMainScreenState();
}

class _BusinessMainScreenState extends State<BusinessMainScreen> {
  List screens= [
    AnalyticsScreen(),
    ExploreScreen(),
    ListingScreen(),
    ProfileScreen(),
  ];

  int currentIndex = 0;

  void onTap(int index){
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        onTap: onTap,
        currentIndex: currentIndex,
        selectedItemColor: Colors.redAccent,
        unselectedItemColor: Colors.black,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        elevation: 0,
        items: const [
          BottomNavigationBarItem(label: 'Home', icon: Icon(Icons.home_outlined)),
          BottomNavigationBarItem(label: 'Explore', icon: Icon(Icons.location_on_outlined)),
          BottomNavigationBarItem(label: 'Create', icon: Icon(Icons.add_box_outlined)),
          BottomNavigationBarItem(label: 'Account', icon: Icon(Icons.person_outline_outlined)),
        ],
      ),
    );
  }
}



