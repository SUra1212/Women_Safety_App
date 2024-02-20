import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/quotes.dart';

class CustomAppBar extends StatelessWidget {
  // const CustomAppBar({super.key});
  Function? onTap;
  // int? quoteIndex;
  // CustomAppBar({this.onTap, this.quoteIndex});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap!();
      },
      // child: Container(
      //   child: Text(
      //     sweetSayings[quoteIndex!],
      //     textAlign: TextAlign.center,
      //     style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
      //   ),
      // ),
    );
  }
}
