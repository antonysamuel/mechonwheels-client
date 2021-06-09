import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mechonwheelz/pages/login.dart';
import 'package:mechonwheelz/services/providerClass.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class SignUp extends StatelessWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              constraints: BoxConstraints(
                  maxHeight: size.height + 200, maxWidth: size.width),
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Colors.blue.shade800, Colors.blue.shade500],
                      begin: Alignment.topLeft,
                      end: Alignment.centerRight)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      flex: 1,
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 36, horizontal: 24),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Welcome",
                              style: GoogleFonts.notoSans(
                                  textStyle: TextStyle(
                                      color: Colors.white,
                                      fontSize: 46,
                                      fontWeight: FontWeight.w700)),
                            ),
                            Text("Register to begin....",
                                style: GoogleFonts.notoSans(
                                    textStyle: TextStyle(
                                        color: Colors.grey.shade200,
                                        fontSize: 22,
                                        fontWeight: FontWeight.w200)))
                          ],
                        ),
                      )),
                  Expanded(
                    flex: 4,
                    child: Consumer<StateProvider>(
                      builder: (context, value, child) => Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(40),
                                topRight: Radius.circular(40))),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 100, left: 18, right: 18),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              TextField(
                                onChanged: (val) {
                                  value.nameText = val;
                                  value.validatename(val);
                                },
                                decoration: InputDecoration(
                                    hintText: 'Enter your name',
                                    labelText: "Name",
                                    errorText:
                                        value.nameValidation.error == "null"
                                            ? null
                                            : value.nameValidation.error,
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: BorderSide.none),
                                    errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide:
                                            BorderSide(color: Colors.red)),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                            color: Colors.deepOrange)),
                                    filled: true,
                                    fillColor: Color(0xffe7edeb),
                                    prefixIcon: Icon(Icons.person)),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              TextField(
                                onChanged: (val) {
                                  value.usernameText = val;
                                  value.validateUsername(val);
                                },
                                decoration: InputDecoration(
                                    hintText: 'Choose a username',
                                    labelText: "Username",
                                    errorText:
                                        value.usernameValidation.error == "null"
                                            ? null
                                            : value.usernameValidation.error,
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: BorderSide.none),
                                    errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide:
                                            BorderSide(color: Colors.red)),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                            color: Colors.deepOrange)),
                                    filled: true,
                                    fillColor: Color(0xffe7edeb),
                                    prefixIcon: Icon(Icons.person)),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              TextField(
                                onChanged: (val) {
                                  value.emailText = val;
                                  value.validateEmail(val);
                                },
                                decoration: InputDecoration(
                                    hintText: 'someone@mail.com',
                                    labelText: "Email",
                                    errorText:
                                        value.emailValidation.error == "null"
                                            ? null
                                            : value.emailValidation.error,
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: BorderSide.none),
                                    errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide:
                                            BorderSide(color: Colors.red)),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                            color: Colors.deepOrange)),
                                    filled: true,
                                    fillColor: Color(0xffe7edeb),
                                    prefixIcon: Icon(Icons.email)),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              TextField(
                                obscureText: true,
                                onChanged: (val) {
                                  value.passwordText = val;
                                  value.validatePassword(val);
                                },
                                decoration: InputDecoration(
                                    hintText: '******',
                                    labelText: "Password",
                                    errorText:
                                        value.passwordValidation.error == "null"
                                            ? null
                                            : value.passwordValidation.error,
                                    errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide:
                                            BorderSide(color: Colors.red)),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: BorderSide.none),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                            color: Colors.deepOrange)),
                                    filled: true,
                                    fillColor: Color(0xffe7edeb),
                                    prefixIcon: Icon(Icons.password_rounded)),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              TextField(
                                onChanged: (val) {
                                  value.password2Text = val;
                                  value.validatePassword2(val);
                                },
                                obscureText: true,
                                decoration: InputDecoration(
                                    hintText: '******',
                                    labelText: "Verify Password",
                                    errorText:
                                        value.password2Validation.error ==
                                                "null"
                                            ? null
                                            : value.password2Validation.error,
                                    errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide:
                                            BorderSide(color: Colors.red)),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: BorderSide.none),
                                    filled: true,
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                            color: Colors.deepOrange)),
                                    fillColor: Color(0xffe7edeb),
                                    prefixIcon: Icon(Icons.password)),
                              ),
                              value.authErr == ""
                                  ? SizedBox()
                                  : showErrorCard(value),
                              SizedBox(
                                height: 40,
                              ),
                              Container(
                                height: 70,
                                width: 250,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    gradient: LinearGradient(colors: [
                                      Colors.blue,
                                      Colors.blue.shade200
                                    ])),
                                alignment: Alignment.center,
                                child: TextButton(
                                    onPressed: () =>
                                        value.registerUser(context),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Sign Up",
                                          style: GoogleFonts.ubuntu(
                                              textStyle: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w200)),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Icon(
                                          Icons.vpn_key_rounded,
                                          size: 40,
                                          color: Colors.white,
                                        )
                                      ],
                                    )),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("I'm already a member."),
                                  TextButton(
                                      onPressed: () {
                                        Provider.of<StateProvider>(context,
                                                listen: false)
                                            .authErr = "";
                                        Navigator.pushReplacement(
                                            context,
                                            PageTransition(
                                                child: LoginPage(),
                                                type: PageTransitionType
                                                    .rightToLeft));
                                      },
                                      child: Text(
                                        "Sign In",
                                        style: TextStyle(
                                            color: Colors.blue, fontSize: 15),
                                      ))
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )));
  }

  Card showErrorCard(StateProvider value) {
    Timer(Duration(seconds: 3), () => value.closeErrorCard());
    return Card(
      color: Colors.red,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text(
          value.authErr,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
