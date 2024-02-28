import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/child/bottom_screens/self_defence.dart';
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
  bool _isMounted = false;

  String? id;
  String? profilePic;

  _getPermission() async => await [Permission.sms].request();
  _isPermissionGranted() async => await Permission.sms.status.isGranted;

  void _navigateToSelfDefensePage() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              SelfDefence()), // Navigate to the SelfDefence page
    );
  }

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
          style: TextStyle(fontSize: 40),
        ),
      ),
    );
  }

  Widget _displayImages() {
    if (selectedEmoji == '😊') {
      return Column(
        children: [
          SizedBox(height: 10),
          _buildImageWithDescription(
            topic: 'Self-Care and Wellness',
            imagePath: 'assets/h1.png',
            description:
                'Happiness starts from within. Discover self-care practices that nourish your mind, body, and soul. Engage in activities like meditation, yoga, or a leisurely walk in nature. Prioritize your well-being and make time for activities that bring you joy and rejuvenation.',
          ),
          SizedBox(height: 10),
          _buildImageWithDescription(
            topic: 'Positive Affirmations and Self-Reflection',
            imagePath: 'assets/h2.jpg',
            description:
                ' Embrace the power of positive affirmations to nurture a happy mindset. Practice self-reflection and cultivate a deep sense of self-acceptance and appreciation. Affirm your worthiness, strengths, and capabilities daily. Remember, you are deserving of happiness and all the good things life has to offer.',
          ),
        ],
      );
    } else if (selectedEmoji == '😢') {
      return Column(
        children: [
          SizedBox(height: 10),
          _buildImageWithDescription(
            topic: 'Seeking Support and Connection',
            imagePath: 'assets/s1.png',
            description:
                ' You\'re not alone in your struggles! Reach out to trusted friends, family members, or support networks for comfort and companionship. Sharing your feelings with others can provide validation and a sense of relief. Don\'t hesitate to lean on your support system during difficult times. ',
          ),
          SizedBox(height: 10),
          _buildImageWithDescription(
            topic: 'Engaging in Activities that Bring Joy',
            imagePath: 'assets/s2.jpg',
            description:
                ' Rediscover activities that bring a smile to your face and lift your spirits. Whether it\'s listening to uplifting music, watching a favorite movie, or engaging in a hobby you love, make time for things that nourish your soul. Even small moments of joy can help alleviate sadness.',
          ),
        ],
      );
    } else if (selectedEmoji == '🥰') {
      return Column(
        children: [
          SizedBox(height: 10),
          _buildImageWithDescription(
            topic: 'Building Healthy Relationships',
            imagePath: 'assets/l1.jpg',
            description:
                ' Cultivate and cherish healthy relationships in your life. Invest time and effort in fostering meaningful connections with friends, family, and loved ones. Communicate openly, listen with empathy, and show appreciation for the people who bring love and joy into your life. Healthy relationships are a source of strength and happiness.',
          ),
          SizedBox(height: 10),
          _buildImageWithDescription(
            topic: 'Practicing Forgiveness and Letting Go',
            imagePath: 'assets/l2.jpg',
            description:
                'Love thrives in an environment of forgiveness and acceptance. Practice letting go of grudges, resentment, and past hurts that weigh you down. Extend compassion and forgiveness to yourself and others, recognizing that we are all imperfect beings on a journey of growth and learning. ',
          ),
        ],
      );
    } else if (selectedEmoji == '😡') {
      return Column(
        children: [
          SizedBox(height: 10),
          _buildImageWithDescription(
            topic: 'Anger Management Techniques',
            imagePath: 'assets/a1.png',
            description:
                ' Explore effective strategies for managing anger and diffusing intense emotions. Practice deep breathing exercises, progressive muscle relaxation, or mindfulness meditation to calm your mind and body.',
          ),
          SizedBox(height: 10),
          _buildImageWithDescription(
            topic: 'Understanding Anger Triggers',
            imagePath: 'assets/a2.png',
            description:
                'Gain insight into the underlying triggers and root causes of your anger. Explore past experiences, beliefs, and patterns that contribute to feelings of frustration and resentment. By identifying and addressing the source of your anger, you can develop proactive strategies for managing triggers and preventing escalation in the future. ',
          ),
        ],
      );
    } else {
      return Container();
    }
  }

  Widget _buildImageWithDescription({
    required String topic,
    required String description,
    required String imagePath,
  }) {
    return Column(
      children: [
        Text(
          topic,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        SizedBox(height: 5),
        Image.asset(
          imagePath,
          width: 200,
          height: 150,
          fit: BoxFit.cover,
        ),
        SizedBox(height: 10),
        Text(
          description,
          textAlign: TextAlign.center,
        ),
      ],
    );
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
      if (_isMounted) {
        setState(() {
          _currentPosition = position;
          _getAddressFromLatLon();
        });
      }
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
    _isMounted = true;
  }

  @override
  void dispose() {
    _isMounted = false;
    super.dispose();
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
                    margin: EdgeInsets.only(right: 10),
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey[200],
                    ),
                    child: profilePic == null
                        ? CircleAvatar(
                            backgroundColor: Colors.transparent,
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
                                radius: 30,
                                backgroundImage: NetworkImage(profilePic!),
                                backgroundColor: Colors.transparent,
                              )
                            : CircleAvatar(
                                radius: 30,
                                backgroundImage: FileImage(File(profilePic!)),
                                backgroundColor: Colors.transparent,
                              ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 5),
                      Row(
                        children: [
                          Text(
                            "Hi,",
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.black87,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 150),
                          ElevatedButton(
                            onPressed: _navigateToSelfDefensePage,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text(
                              'Safety Tips',
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 1), // Add margin top here
                        child: Text(
                          nameC.text,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 20,
                child: Container(
                  color: Colors.white,
                ),
              ),
              Expanded(
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    SafeHome(),
                    SizedBox(height: 40),
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
                        _buildEmojiButton('🥰', []),
                        _buildEmojiButton('😡', []),
                      ],
                    ),
                    SizedBox(height: 5),
                    _displayImages(),
                    if (_currentPosition != null) SizedBox(height: 40),
                    CustomCarouel(),
                    SizedBox(height: 40),
                    Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Emergency services",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'sans-serif',
                          ),
                        ),
                      ),
                    ),
                    Emergency(),
                    SizedBox(height: 30),
                    Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Explore Locations",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'sans-serif',
                          ),
                        ),
                      ),
                    ),
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
