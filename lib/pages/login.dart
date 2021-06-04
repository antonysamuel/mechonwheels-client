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
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 100),
                height: size.height * .35,
                width: size.width,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Welcome,",
                          style: GoogleFonts.ptSans(
                            textStyle: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 40),
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
                            errorText: value.usernameValidation.error == "null"
                                ? null
                                : value.usernameValidation.error,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide:
                                    BorderSide(color: Colors.grey.shade500)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide:
                                    BorderSide(color: Colors.grey.shade500)),
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
                          controller: value.passwordController,
                          onChanged: (val) {
                            value.passwordText = val;
                            value.validatePassword(val);
                          },
                          decoration: InputDecoration(
                            hintText: "********",
                            labelText: "Password",
                            errorText: value.passwordValidation.error == "null"
                                ? null
                                : value.passwordValidation.error,
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide:
                                    BorderSide(color: Colors.grey.shade500)),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide:
                                    BorderSide(color: Colors.grey.shade500)),
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
              SizedBox(
                height: 50,
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
                          .loginUser(),
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
                    onPressed: () => Navigator.pushReplacement(
                        context,
                        PageTransition(
                            child: SignUp(),
                            type: PageTransitionType.rightToLeftWithFade)),
                    child: Text(
                      "Sign Up",
                      style: TextStyle(color: Colors.pink, fontSize: 15),
                    ))
              ])
            ],
          )),
    );
  }
}
