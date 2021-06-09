import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mechonwheelz/pages/register.dart';
import 'package:mechonwheelz/services/providerClass.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Stack(
            children: [
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 100),
                    height: size.height * .35,
                    width: size.width,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 40, horizontal: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Welcome,",
                              style: GoogleFonts.ptSans(
                                textStyle: TextStyle(
                                    color: Colors.pink.shade400,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 40),
                              )),
                          Text("Sign in to continue!",
                              style: GoogleFonts.ptSans(
                                textStyle: TextStyle(
                                    color: Colors.grey.shade600,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 24),
                              ))
                        ],
                      ),
                    ),
                  ),
                  Consumer<StateProvider>(
                    builder: (context, value, child) => Container(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        children: [
                          TextField(
                              controller: value.usernameController,
                              onChanged: (val) {
                                value.usernameText = val;
                                value.validateUsername(val);
                              },
                              decoration: InputDecoration(
                                hintText: "Enter username",
                                labelText: "Username",
                                errorText:
                                    value.usernameValidation.error == "null"
                                        ? null
                                        : value.usernameValidation.error,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide(
                                        color: Colors.grey.shade300)),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide(
                                        color: Colors.grey.shade300)),
                                errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide(color: Colors.red)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide(
                                        color: Colors.pinkAccent.shade200)),
                              )),
                          SizedBox(
                            height: 20,
                          ),
                          TextField(
                              obscureText: true,
                              controller: value.passwordController,
                              onChanged: (val) {
                                value.passwordText = val;
                                value.validatePassword(val);
                              },
                              decoration: InputDecoration(
                                hintText: "********",
                                labelText: "Password",
                                errorText:
                                    value.passwordValidation.error == "null"
                                        ? null
                                        : value.passwordValidation.error,
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide(
                                        color: Colors.grey.shade300)),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide(
                                        color: Colors.grey.shade300)),
                                errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide(color: Colors.red)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide(
                                        color: Colors.pinkAccent.shade200)),
                              )),
                        ],
                      ),
                    ),
                  ),
                  if (Provider.of<StateProvider>(context).authErr == "")
                    SizedBox()
                  else
                    _showErrorCard(context),
                  SizedBox(
                    height: 40,
                  ),
                  Container(
                    constraints: BoxConstraints(maxWidth: size.width * .85),
                    height: 55,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: LinearGradient(
                            colors: [Colors.pink, Colors.pink.shade200])),
                    child: TextButton(
                      onPressed: () =>
                          Provider.of<StateProvider>(context, listen: false)
                              .loginUser(context),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Login",
                            style: GoogleFonts.ubuntu(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.w300),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Icon(Icons.vpn_key, size: 30, color: Colors.white)
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 100,
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Text("I'm a new user. "),
                    TextButton(
                        onPressed: () {
                          Provider.of<StateProvider>(context, listen: false)
                              .authErr = "";
                          Navigator.pushReplacement(
                              context,
                              PageTransition(
                                  child: SignUp(),
                                  type:
                                      PageTransitionType.rightToLeftWithFade));
                        },
                        child: Text(
                          "Sign Up",
                          style: TextStyle(color: Colors.pink, fontSize: 15),
                        ))
                  ])
                ],
              ),
              ClipPath(
                clipper: OuterClippedPart(),
                child: Container(
                  color: Color(0xfff08a5d),
                  width: size.width,
                  height: size.height,
                ),
              ),
              //
              ClipPath(
                clipper: InnerClippedPart(),
                child: Container(
                  color: Color(0xfffc5185),
                  width: size.width,
                  height: size.height,
                ),
              ),
            ],
          )),
    );
  }

  Card _showErrorCard(BuildContext context) {
    Timer(
        Duration(seconds: 3),
        () => Provider.of<StateProvider>(context, listen: false)
            .closeErrorCard());

    return Card(
      color: Colors.red,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text(
          Provider.of<StateProvider>(context).authErr,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

class OuterClippedPart extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    //
    path.moveTo(size.width / 2, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height / 4);
    //
    path.cubicTo(size.width * 0.55, size.height * 0.16, size.width * 0.85,
        size.height * 0.05, size.width / 2, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

class InnerClippedPart extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    //
    path.moveTo(size.width * 0.7, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height * 0.1);
    //
    path.quadraticBezierTo(
        size.width * 0.8, size.height * 0.11, size.width * 0.7, 0);

    //
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
