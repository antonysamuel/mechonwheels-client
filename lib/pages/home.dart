import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:mechonwheelz/pages/login.dart';
import 'package:mechonwheelz/pages/servicePages/bookService.dart';
import 'package:mechonwheelz/pages/servicePages/nearbyWorkshops.dart';
import 'package:mechonwheelz/pages/servicePages/serchPage.dart';
import 'package:mechonwheelz/services/providerClass.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final provider = Provider.of<StateProvider>(context);
    return Scaffold(
        backgroundColor: Color(0xffdbedf3),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                height: size.height * .3,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(100),
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(.5),
                          offset: Offset(0.0, 1.0), //(x,y)
                          blurRadius: 8.0,
                          spreadRadius: 3),
                    ],
                    gradient: LinearGradient(
                        colors: [Colors.pink, Colors.blue.withOpacity(.8)],
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight)),
                child: ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Image.network(
                      'https://pbs.twimg.com/profile_images/944457774460735488/3bIT0-tv_400x400.jpg',
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                  ),
                  title: Text(
                    "Hi ${provider.fetchedName},",
                    style: GoogleFonts.notoSans(
                        textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 35,
                            fontWeight: FontWeight.bold)),
                  ),
                  subtitle: Text(
                    "Welcome back!",
                    style: GoogleFonts.poppins(
                        color: Colors.grey.shade300, fontSize: 20),
                  ),
                  trailing: TextButton(
                    onPressed: () async {
                      var hive = Hive.box('tokenBox');
                      hive.put('token', "0");

                      Navigator.pushReplacement(
                          context,
                          PageTransition(
                              child: LoginPage(),
                              type: PageTransitionType.fade));
                      print("Clicked");
                    },
                    child: Icon(
                      Icons.logout_rounded,
                      color: Colors.white,
                      size: 38,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 45,
              ),
              SizedBox(
                width: size.width * .9,
                child: Text(
                  "Services",
                  style: GoogleFonts.montserrat(
                      fontSize: 28,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                padding: EdgeInsets.symmetric(horizontal: 18),
                constraints: BoxConstraints(maxHeight: size.height * .7),
                child: GridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 18,
                  children: [
                    buildServiceCard(
                        "Find Nearby\nWorkshops",
                        'https://pics.freeicons.io/uploads/icons/png/14152045821620745695-512.png',
                        context,
                        FindNearby()),
                    buildServiceCard(
                        "Book Service",
                        'https://pics.freeicons.io/uploads/icons/png/8893889031595988887-512.png',
                        context,
                        BookService()),
                    buildServiceCard(
                        "Roadside\nAssistance",
                        'https://pics.freeicons.io/uploads/icons/png/143590661582779206-512.png',
                        context,
                        FindNearby()),
                    buildServiceCard(
                        "Search\nWorkshop",
                        'https://pics.freeicons.io/uploads/icons/png/10428975741620713519-512.png',
                        context,
                        SearchPage()),
                  ],
                ),
              )
            ],
          ),
        ));
  }

  GestureDetector buildServiceCard(
      String txt, String imgUrl, BuildContext context, StatelessWidget page) {
    return GestureDetector(
      onTap: () => Navigator.push(context,
          PageTransition(child: page, type: PageTransitionType.bottomToTop)),
      child: Container(
        width: 180,
        height: 220,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
                color: Colors.grey,
                offset: Offset(.1, 0),
                spreadRadius: .5,
                blurRadius: 8)
          ],
          gradient: LinearGradient(
              colors: [Colors.blue.shade400, Colors.pink.shade500],
              stops: [0.0, 0.8]),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.network(
              imgUrl,
              color: Colors.white,
              height: 80,
            ),
            Text(
              txt,
              style: GoogleFonts.lato(color: Colors.white, fontSize: 17),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
