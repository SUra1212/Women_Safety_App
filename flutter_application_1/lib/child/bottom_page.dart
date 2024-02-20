import 'package:flutter/material.dart';
import 'package:flutter_application_1/child/bottom_screens/add_contacts.dart';
import 'package:flutter_application_1/child/bottom_screens/child_home_page.dart';
import 'package:flutter_application_1/child/bottom_screens/councillors.dart';
import 'package:flutter_application_1/child/bottom_screens/profile_page.dart';
import 'package:flutter_application_1/child/bottom_screens/review_page.dart';
import 'package:flutter_application_1/child/bottom_screens/self_defence.dart';

class BottomPage extends StatefulWidget {
  BottomPage({Key? key}) : super(key: key);

  @override
  State<BottomPage> createState() => _BottomPageState();
}

class _BottomPageState extends State<BottomPage> {
  int currentIndex = 0;
  List<Widget> pages = [
    HomeScreen(),
    AddContactsPage(),
    CheckUserStatusBeforeChatOnProfile(),
    CouncillorsPage(),
    ReviewPage(),
    SelfDefence(),
  ];
  onTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
        onTap: onTapped,
        backgroundColor: Colors.red.shade300, // Change bottom bar color
        selectedItemColor: Colors.white, // Change selected item color
        unselectedItemColor: Colors.black,
        items: [
          BottomNavigationBarItem(
              label: 'home',
              icon: Icon(
                Icons.home,
              )),
          BottomNavigationBarItem(
              label: 'contacts',
              icon: Icon(
                Icons.contacts,
              )),
          BottomNavigationBarItem(
              label: 'Profile',
              icon: Icon(
                Icons.person,
              )),
          BottomNavigationBarItem(
              label: 'Councillors',
              icon: Icon(
                Icons.person_add_alt_1,
              )),
          BottomNavigationBarItem(
              label: 'Community',
              icon: Icon(
                Icons.reviews,
              )),
          BottomNavigationBarItem(
              label: 'Self',
              icon: Icon(
                Icons.girl,
              ))
        ],
      ),
    );
  }
}
