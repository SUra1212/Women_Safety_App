import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/components/custom_textfield.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_application_1/db/db_services.dart';
import 'package:flutter_application_1/model/contactsm.dart';
import 'package:flutter_application_1/widgets/home_widgets/CustomCarouel.dart';
import 'package:flutter_application_1/widgets/home_widgets/custom_appBar.dart';
import 'package:flutter_application_1/widgets/home_widgets/emergency.dart';
import 'package:flutter_application_1/widgets/home_widgets/safehome/SafeHome.dart';
import 'package:flutter_application_1/widgets/live_safe.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int qIndex = 0;
  Position? _currentPosition;
  String? _currentAddress;
  LocationPermission? permission;
  TextEditingController nameC = TextEditingController();
  String selectedEmoji = '';

  String? id;
  String? profilePic;

  _getPermission() async => await [Permission.sms].request();
  _isPermissionGranted() async => await Permission.sms.status.isGranted;

  Widget _buildEmojiButton(String emoji, List<String> images) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedEmoji = emoji;
        });
      },
      child: Container(
        padding: EdgeInsets.all(10),
        child: Text(
          emoji,
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }

  Widget _displayImages() {
    if (selectedEmoji == '😊') {
      return Column(
        children: [
          Text('Happy Images:'),
          // Add your happy images here
        ],
      );
    } else if (selectedEmoji == '😢') {
      return Column(
        children: [
          Text('Sad Images:'),
          // Add your sad images here
        ],
      );
    } else if (selectedEmoji == '❤️') {
      return Column(
        children: [
          Text('Love Images:'),
          // Add your love images here
        ],
      );
    } else if (selectedEmoji == '😡') {
      return Column(
        children: [
          Text('Angry Images:'),
          // Add your angry images here
        ],
      );
    } else {
      return Container(); // Return empty container if no emoji is selected
    }
  }

  getDate() async {
    await FirebaseFirestore.instance
        .collection('users')
        .where('id', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      setState(() {
        nameC.text = value.docs.first['name'];

        id = value.docs.first.id;
        profilePic = value.docs.first['profilePic'];
        print(nameC);
        print(profilePic);
      });
    });
  }

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  _getCurrentLocation() async {
    final hasPermission = await _handleLocationPermission();
    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high,
            forceAndroidLocationManager: true)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
        _getAddressFromLatLon();
      });
    }).catchError((e) {
      Fluttertoast.showToast(msg: e.toString());
    });
  }

  _getAddressFromLatLon() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          _currentPosition!.latitude, _currentPosition!.longitude);

      Placemark place = placemarks[0];
      setState(() {
        _currentAddress =
            "${place.locality},${place.postalCode},${place.street},";
      });
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  getRandomQuote() {
    Random random = Random();
    setState(() {
      qIndex = random.nextInt(6);
    });
  }

  getAndSendSms() async {
    List<TContact> contactList = await DatabaseHelper().getContactList();

    String messageBody =
        "https://maps.google.com/?daddr=${_currentPosition!.latitude},${_currentPosition!.longitude}";
    if (await _isPermissionGranted()) {
      contactList.forEach((element) {
        // _sendSms("${element.number}", "i am in trouble $messageBody");
      });
    } else {
      Fluttertoast.showToast(msg: "something wrong");
    }
  }

  @override
  void initState() {
    _getCurrentLocation();
    getRandomQuote();
    super.initState();
    _getPermission();
    getDate();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
           actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.comment),
            tooltip: 'Comment Icon',
            onPressed: () {},
          ), //IconButton
          IconButton(
            icon: const Icon(Icons.settings),
            tooltip: 'Setting Icon',
            onPressed: () {},
          ), //IconButton
        ],
        
        titleSpacing: 00.0,
        centerTitle: true,
        toolbarHeight: 60.2,
        toolbarOpacity: 0.8,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(25),
              bottomLeft: Radius.circular(25)),
        ),
        elevation: 0.00,
        backgroundColor: Colors.red.shade300,
        leading: IconButton(
          icon: const Icon(Icons.menu),
          tooltip: 'Menu Icon',
          onPressed: () {},
        ),

        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin:
                        EdgeInsets.only(right: 10), // Adjust margin as needed
                    child: profilePic == null
                        ? CircleAvatar(
                            backgroundColor: Colors.deepPurple,
                            radius: 30,
                            child: Center(
                              child: Image.asset(
                                'assets/add_pic.png',
                                height: 30,
                                width: 30,
                              ),
                            ),
                          )
                        : profilePic!.contains('http')
                            ? CircleAvatar(
                                backgroundColor: Colors.deepPurple,
                                radius: 30,
                                backgroundImage: NetworkImage(profilePic!),
                              )
                            : CircleAvatar(
                                backgroundColor: Colors.deepPurple,
                                radius: 30,
                                backgroundImage: FileImage(File(profilePic!)),
                              ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hi",
                        style: TextStyle(
                          fontSize: 16,
                          // Adjust font size and style as needed
                        ),
                      ),
                      Text(
                        nameC.text,
                        style: TextStyle(
                          fontSize: 20,
                          // Adjust font size and style as needed
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 20,
                child: Container(
                  color: Colors.white,
                ),
              ),
              // SizedBox(height: 5),
              // SizedBox(
              //   height: 10,
              //   child: Container(
              //     color: Colors.grey.shade100,
              //   ),
              // ),
              Expanded(
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    SafeHome(),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Text(
                          "How do you feel today?",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'sans-serif',
                          ),
                        ),
                      ],
                    ),
                    Row(
                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildEmojiButton('😊', []),
                        _buildEmojiButton('😢', []),
                        _buildEmojiButton('❤️', []),
                        _buildEmojiButton('😡', []),
                      ],
                       
                    ),
                    SizedBox(height: 20),
                    _displayImages(),
                    if (_currentPosition != null)
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 20),
                        child: Column(
                          children: [
                            Text(
                              "Your Current Address:",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(_currentAddress ?? "Loading address..."),
                          ],
                        ),
                      ),
                    SizedBox(height: 10),
                    CustomCarouel(),
                    SizedBox(height: 10),
                    Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "In case of emergency, dial me",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'sans-serif',
                          ),
                        ),
                      ),
                    ),
                    Emergency(),
                    SizedBox(height: 10),
                    Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Explore LiveSafe",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'sans-serif',
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    LiveSafe(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
