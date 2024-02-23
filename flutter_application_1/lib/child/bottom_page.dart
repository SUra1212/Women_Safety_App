import 'package:flutter/material.dart';
import 'package:flutter_application_1/child/bottom_screens/add_contacts.dart';
import 'package:flutter_application_1/child/bottom_screens/child_home_page.dart';
import 'package:flutter_application_1/child/bottom_screens/councillors.dart';
import 'package:flutter_application_1/child/bottom_screens/profile_page.dart';
import 'package:flutter_application_1/child/bottom_screens/review_page.dart';
import 'package:flutter_application_1/child/bottom_screens/self_defence.dart';

// class BottomPage extends StatefulWidget {
//   BottomPage({Key? key}) : super(key: key);

//   @override
//   State<BottomPage> createState() => _BottomPageState();
// }

// class _BottomPageState extends State<BottomPage> {
//   int currentIndex = 0;
//   List<Widget> pages = [
//     HomeScreen(),
//     AddContactsPage(),
//     CheckUserStatusBeforeChatOnProfile(),
//     CouncillorsPage(),
//     ReviewPage(),
//     SelfDefence(),
//   ];
//   onTapped(int index) {
//     setState(() {
//       currentIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: pages[currentIndex],
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: currentIndex,
//         type: BottomNavigationBarType.fixed,
//         onTap: onTapped,
//         backgroundColor: Colors.red.shade300,
//         selectedItemColor: Colors.white,
//         unselectedItemColor: Colors.black,
//         items: [
//           BottomNavigationBarItem(
//               label: 'home',
//               icon: Icon(
//                 Icons.home,
//               )),
//           BottomNavigationBarItem(
//               label: 'contacts',
//               icon: Icon(
//                 Icons.contacts,
//               )),
//           BottomNavigationBarItem(
//               label: 'Profile',
//               icon: Icon(
//                 Icons.person,
//               )),
//           BottomNavigationBarItem(
//               label: 'Councillors',
//               icon: Icon(
//                 Icons.person_add_alt_1,
//               )),
//           BottomNavigationBarItem(
//               label: 'Community',
//               icon: Icon(
//                 Icons.reviews,
//               )),
//           BottomNavigationBarItem(
//               label: 'Self',
//               icon: Icon(
//                 Icons.girl,
//               ))
//         ],
//       ),
//     );
//   }
// }

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
            SizedBox(width: 5.0), // Adjust the width as needed
            Container(
              margin: EdgeInsets.only(
                  right: 2.0), // Adjust the left margin as needed
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
              margin: EdgeInsets.only(
                  right: 1.0), // Adjust the left margin as needed
              child: Tooltip(
                message: 'Profile', // Tooltip message
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

            SizedBox(width: 40.0),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            currentIndex = 0;
          });
        },
        tooltip: 'Home',
        child: Icon(Icons.home),
        // elevation: 2.0,
        backgroundColor: Colors.red.shade300,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
