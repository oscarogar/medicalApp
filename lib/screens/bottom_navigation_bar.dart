import 'package:firstaidpatient/screens/accounts_screen.dart';
import 'package:firstaidpatient/screens/profile_page.dart';
import 'package:firstaidpatient/screens/services_page.dart';
import 'package:flutter/material.dart';

class MyBottomNavigationBar extends StatefulWidget {
  static const String id = 'bottom_navigation';
  @override
  _MyBottomNavigationBarState createState() => _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
  int _currentIndex = 0;
  List<Widget> _children = [ServicesPage(), ProfilePage(), AccountsPage()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.black,
        unselectedFontSize: 15,
        backgroundColor: Color(0xFFC21A26),
        selectedItemColor: Colors.white,
        selectedFontSize: 20,
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.account_balance_wallet,
            ),
            title: Text('Account'),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.help,
            ),
            title: Text('Help'),
          ),
        ],
      ),
    );
  }
}
