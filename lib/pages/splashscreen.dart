import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mechonwheelz/pages/login.dart';
import 'package:mechonwheelz/pages/register.dart';
import 'package:page_transition/page_transition.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(
        Duration(seconds: 3),
        () => Navigator.pushReplacement(
            context,
            PageTransition(
                child: SignUp(),
                type: PageTransitionType.fade,
                duration: Duration(seconds: 1))));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF17141A),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "MechonWheelz",
              style: GoogleFonts.ubuntu(
                  textStyle: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 24)),
            ),
            SizedBox(
              width: 10,
            ),
            // Image.network(
            //   'https://pics.freeicons.io/uploads/icons/png/15932977261620307334-512.png',
            //   color: Colors.white,
            //   height: 50,
            // )
          ],
        ),
      ),
    );
  }
}
