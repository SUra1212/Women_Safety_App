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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 8.0,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            SizedBox(width: 5.0),
            Container(
              margin: EdgeInsets.only(right: 2.0),
              child: Tooltip(
                message: 'Contacts', // Tooltip message
                child: IconButton(
                  icon: Icon(
                    Icons.contact_phone,
                    color: currentIndex == 1 ? Colors.white : Colors.black,
                  ),
                  onPressed: () {
                    setState(() {
                      currentIndex = 1;
                    });
                  },
                ),
              ),
            ),
            SizedBox(width: 1.0),

            Container(
              margin: EdgeInsets.only(right: 1.0),
              child: Tooltip(
                message: 'Profile',
                child: IconButton(
                  icon: Icon(
                    Icons.person,
                    color: currentIndex == 2 ? Colors.white : Colors.black,
                  ),
                  onPressed: () {
                    setState(() {
                      currentIndex = 2;
                    });
                  },
                ),
              ),
            ),

            SizedBox(width: 20.0),
            FloatingActionButton(
              onPressed: () {
                setState(() {
                  currentIndex = 0;
                });
              },
              tooltip: 'Home',
              child: Icon(Icons.home, color: Colors.black),
              // elevation: 2.0,
              backgroundColor: Colors.red.shade300,
            ),
            SizedBox(width: 20.0),
            IconButton(
              icon: Icon(
                Icons.psychology_alt,
                color: currentIndex == 3 ? Colors.white : Colors.black,
              ),
              onPressed: () {
                setState(() {
                  currentIndex = 3;
                });
              },
            ),
            SizedBox(width: 10.0),
            IconButton(
              icon: Icon(
                Icons.groups,
                color: currentIndex == 4 ? Colors.white : Colors.black,
              ),
              onPressed: () {
                setState(() {
                  currentIndex = 4;
                });
              },
            ),
            // IconButton(
            //   icon: Icon(
            //     Icons.girl,
            //     color: currentIndex == 5 ? Colors.white : Colors.black,
            //   ),
            //   onPressed: () {
            //     setState(() {
            //       currentIndex = 5;
            //     });
            //   },
            // ),
          ],
        ),
        color: Colors.red.shade300,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
