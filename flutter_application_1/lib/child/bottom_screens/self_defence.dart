import 'package:flutter/material.dart';
import 'package:flutter_application_1/child/bottom_page.dart';
import 'package:url_launcher/url_launcher.dart';

class SelfDefence extends StatefulWidget {
  @override
  State<SelfDefence> createState() => _SelfDefenceState();
}

class _SelfDefenceState extends State<SelfDefence> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Self Defence'),
        backgroundColor: Colors.red.shade300,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () async {
            bool result = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BottomPage(),
              ),
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(2),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Image.asset(
                          "assets/selfdefence1.webp",
                          height: 200,
                          width: 150,
                          fit: BoxFit.cover,
                        ),
                        Container(width: 20),
                        Expanded(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(height: 5),
                                Text(
                                  "When to use it:",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.black),
                                ),
                                Container(height: 5),
                                Text(
                                  "Use this from a distance as a way of setting a strong body-language boundary (like if somebody's following you) or when you're engaged in sending physical strikes, Arthur says.",
                                ),
                                Text(
                                  "How to do it:",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.black),
                                ),
                                Text(
                                  "Stand with your feet shoulder-width apart and your hands by your sides. Keeping your toes pointed forward, take a natural step forward with your non-dominant leg, so your feet are staggered. Bend both knees slightly, elevate the back heel, bring your hands up with your hands about 12 inches from your face and your palms facing forward, tuck your chin, and shrug your shoulders slightly. Distribute your body weight between both feet, placing it more in the balls versus heels.",
                                ),
                                Container(height: 10),
                                GestureDetector(
                                  onTap: () {
                                    launch(
                                        "https://youtu.be/Gx3_x6RH1J4?si=tz-x6N193Nx6Kcb9");
                                  },
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        'assets/yt.png', // Change to your YouTube logo image asset
                                        height: 24, // Adjust size as needed
                                        width: 24,
                                      ),
                                      SizedBox(
                                          width:
                                              5), // Add some space between the logo and the text
                                      Text(
                                        "Watch Tutorial",
                                        style: TextStyle(
                                          color: Colors.blue,
                                          decoration: TextDecoration.underline,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ]),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(2),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(height: 5),
                              Text(
                                "When to use it:",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                ),
                              ),
                              Container(height: 5),
                              Text(
                                "This is a last-resort move to create escape opportunities. It's best used when the face of the attacker isn't blocked or covered, and you can reach the face with your arms outstretched, Arthur says.",
                              ),
                              Text(
                                "How to do it:",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                  "Start in Ready Stance and keep your hands up. Rotating your left hip and shoulder, explosively extend your left palm straight out, with your fingertips straight up and elbow down. Keep your right hand up to protect your face. Immediately recoil your left arm, returning your shoulder and hip to the square ready stance.With your feet in the same position, send a palm strike with your right hand (be sure to rotate right hip), then try a left-right combination. If you are left-handed, practice a right-left combination. Your hand should stay open (i.e., don't make a fist) and the heel of your palm should make contact with the attacker's nose."),
                              Container(height: 10),
                              GestureDetector(
                                onTap: () {
                                  launch(
                                      "https://youtu.be/k9Jn0eP-ZVg?si=zC0VwDfENrex1a5Q");
                                },
                                child: Row(
                                  children: [
                                    Image.asset(
                                      'assets/yt.png', // Change to your YouTube logo image asset
                                      height: 24, // Adjust size as needed
                                      width: 24,
                                    ),
                                    SizedBox(
                                        width:
                                            5), // Add some space between the logo and the text
                                    Text(
                                      "Watch Tutorial",
                                      style: TextStyle(
                                        color: Colors.blue,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(width: 20),
                        Image.asset(
                          "assets/selfdefence2.webp",
                          height: 200,
                          width: 150,
                          fit: BoxFit.cover,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(2),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Image.asset(
                          "assets/selfdefence3.webp",
                          height: 200,
                          width: 150,
                          fit: BoxFit.cover,
                        ),
                        Container(width: 20),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(height: 5),
                              Text(
                                "When to use it:",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.black),
                              ),
                              Container(height: 5),
                              Text(
                                  "This is another last-resort move to create escape opportunities. It's particularly beneficial against somebody who's tall, Arthur says, especially if you can't reach their face for Palm-Heel Strikes."),
                              Text(
                                "How to do it:",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.black),
                              ),
                              Text(
                                  "Start in Ready Stance, keeping hands up. Bend your right leg and drive your right knee straight up. As soon as the right knee is above your waistline, extend your hips (almost bend backward to generate power in the left leg/your loading leg) and kick your right shin directly to the attacker's groin, making sure to keep your toes pointed downward and out of the way. Immediately release your right foot behind you and return to Ready Stance."),
                              Container(height: 10),
                              GestureDetector(
                                onTap: () {
                                  launch(
                                      "https://youtu.be/9XaoUlRDLBg?si=5FYBOt0C8nnCY8kx");
                                },
                                child: Row(
                                  children: [
                                    Image.asset(
                                      'assets/yt.png', // Change to your YouTube logo image asset
                                      height: 24, // Adjust size as needed
                                      width: 24,
                                    ),
                                    SizedBox(
                                        width:
                                            5), // Add some space between the logo and the text
                                    Text(
                                      "Watch Tutorial",
                                      style: TextStyle(
                                        color: Colors.blue,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(2),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(height: 5),
                              Text(
                                "When to use it:",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                ),
                              ),
                              Container(height: 5),
                              Text(
                                  "Rely on the Hammerfist Punch move in almost any situation where you find yourself in danger, Jory says. It's most effective, though, when used to hit the attacker directly in the face, particularly the nose, jaw, or temple."),
                              Text(
                                "How to do it:",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                  "Start in Ready Stance. Raise your dominant hand up, bending at the elbow (like you're preparing to throw a ball). Rotate your hips toward attacker and bring your dominant arm down, smacking the attacker in face (aim for the nose) with the meaty bottom part of fist. If you're practicing this move, recoil to Ready Stance and repeat. In a real-world scenario, strike the punch and run while the attacker is incapacitated."),
                              Container(height: 10),
                               GestureDetector(
                                onTap: () {
                                  launch(
                                      "https://youtu.be/ORAOkP1h3R0?si=0LdYk38l9ifjbZfj");
                                },
                                child: Row(
                                  children: [
                                    Image.asset(
                                      'assets/yt.png', // Change to your YouTube logo image asset
                                      height: 24, // Adjust size as needed
                                      width: 24,
                                    ),
                                    SizedBox(
                                        width:
                                            5), // Add some space between the logo and the text
                                    Text(
                                      "Watch Tutorial",
                                      style: TextStyle(
                                        color: Colors.blue,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(width: 20),
                        Image.asset(
                          "assets/selfdefence4.webp",
                          height: 200,
                          width: 150,
                          fit: BoxFit.cover,
                        ),
                        
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
