import 'package:flutter/material.dart';
import 'package:window_shopper/screens/customers/account.dart';
import 'package:window_shopper/screens/customers/home.dart';
import 'package:window_shopper/screens/customers/maps.dart';
import 'package:window_shopper/screens/customers/search.dart';


class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List screens= [
    HomeScreen(),
    MapScreen(),
    AccountScreen(),
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
          BottomNavigationBarItem(label: 'Account', icon: Icon(Icons.person_outline_outlined)),
        ],
      ),
    );
  }
}



