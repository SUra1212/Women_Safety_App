//import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/child/bottom_page.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_application_1/components/PrimaryButton.dart';
//import 'package:flutter_application_1/components/SecondaryButton.dart';
import 'package:flutter_application_1/components/custom_textfield.dart';

class ReviewPage extends StatefulWidget {
  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  TextEditingController viewsC = TextEditingController();
  TextEditingController namecC = TextEditingController();
  bool isSaving = false;

  bool validateFields() {
    if (namecC.text.isEmpty || viewsC.text.isEmpty) {
      Fluttertoast.showToast(msg: 'Please fill all fields');
      return false;
    }
    return true;
  }

  showAlert(BuildContext context) {
    namecC.clear();
    viewsC.clear();
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text("Share Your Story"),
            content: SingleChildScrollView(
              child: Form(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: CustomTextField(
                        hintText: 'Enter Your Name',
                        controller: namecC,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: CustomTextField(
                        controller: viewsC,
                        hintText: 'Description',
                        maxLines: 3,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              PrimaryButton(
                title: "SAVE",
                onPressed: () {
                  if (validateFields()) {
                    saveReview();
                    Navigator.pop(context); // Close the AlertDialog
                  }
                },
              ),
              TextButton(
                child: Text("Cancel"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  saveReview() async {
    if (namecC.text.isEmpty || viewsC.text.isEmpty) {
      Fluttertoast.showToast(msg: 'Please fill all fields');
      return;
    }

    setState(() {
      isSaving = true;
    });
    await FirebaseFirestore.instance
        .collection('reviews')
        .add({'name': namecC.text, 'views': viewsC.text}).then((value) {
      setState(() {
        isSaving = false;
        Fluttertoast.showToast(msg: 'Story Save Successfully');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Community'),
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
      body: isSaving == true
          ? Center(child: CircularProgressIndicator())
          : Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/review.jpg"),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.white
                        .withOpacity(0.5), // Adjust the opacity value as needed
                    BlendMode.srcOver,
                  ),
                ),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('reviews')
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData) {
                          return Center(child: CircularProgressIndicator());
                        }

                        return ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (BuildContext context, int index) {
                            final data = snapshot.data!.docs[index];
                            return Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Card(
                                color: Colors.pink.shade100,
                                elevation: 5,
                                // color: Colors.primaries[Random().nextInt(17)],
                                child: ListTile(
                                  title: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        data['name'],
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.black),
                                      ),
                                    ],
                                  ),
                                  subtitle: Text(data['views']),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.pink,
        onPressed: () {
          showAlert(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
