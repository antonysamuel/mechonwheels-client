import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mechonwheelz/services/models.dart';
import 'package:mechonwheelz/services/providerClass.dart';
import 'package:provider/provider.dart';

class BookService extends StatelessWidget {
  const BookService({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final provider = Provider.of<StateProvider>(context);
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: size.height * .3,
          floating: true,
          collapsedHeight: 120,
          stretch: true,
          centerTitle: true,
          backgroundColor: Colors.transparent,
          flexibleSpace: FlexibleSpaceBar(
            collapseMode: CollapseMode.parallax,
            centerTitle: true,
            title: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(left: 15, bottom: 20),
              constraints: BoxConstraints(maxHeight: size.height * .3),
              decoration: BoxDecoration(
                  color: Color(0xff222831),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  )),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Book a Service",
                    style:
                        GoogleFonts.ubuntu(color: Colors.white, fontSize: 25),
                    overflow: TextOverflow.fade,
                  ),
                  Text(
                    "Pick a workshop to continue..",
                    style: GoogleFonts.lato(
                        color: Colors.grey.shade500, fontSize: 12),
                    overflow: TextOverflow.fade,
                  ),
                  SizedBox(height: 12),
                  Container(
                    width: double.infinity,
                    height: 40,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    alignment: Alignment.center,
                    child: TextField(
                      onChanged: (value) {
                        if (value.length == 0) {
                          provider.clearWorkshopList();
                          return;
                        }
                        provider.searchWorkshop(value);
                      },
                      style:
                          TextStyle(color: Colors.grey.shade200, fontSize: 14),
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          CupertinoIcons.search_circle_fill,
                          color: Colors.teal.shade300,
                        ),
                        hintText: "Search you're looking for..",
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 12),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue.shade300),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        Consumer<StateProvider>(
          builder: (context, value, child) => value.findWorkshopList.isEmpty
              ? SliverToBoxAdapter(
                  child: Container(
                    height: size.height * .30,
                    alignment: Alignment.center,
                    child: Text("Nothing to show"),
                  ),
                )
              : SliverList(
                  delegate: SliverChildBuilderDelegate(
                      (ctx, index) => Column(
                            children: [
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey,
                                          offset: Offset(0, 1),
                                          blurRadius: 8)
                                    ]),
                                child: ListTile(
                                    shape: StadiumBorder(),
                                    title: Text(
                                      value.findWorkshopList[index].name,
                                      style: GoogleFonts.lato(
                                          color: Color(0xff293b5f),
                                          fontWeight: FontWeight.bold),
                                    ),
                                    subtitle: Text(
                                        value.findWorkshopList[index].address +
                                            " " +
                                            value.findWorkshopList[index].phone
                                                .toString()),
                                    trailing: value
                                            .findWorkshopList[index].isBooked
                                        ? Container(
                                            alignment: Alignment.center,
                                            height: 40,
                                            width: 85,
                                            decoration: BoxDecoration(
                                                color: Colors.orange,
                                                borderRadius:
                                                    BorderRadius.circular(30)),
                                            child: Text(
                                              "Booked",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          )
                                        : TextButton(
                                            onPressed: () =>
                                                _addBookingDetialPage(
                                                    context,
                                                    value.findWorkshopList[
                                                        index],
                                                    index),
                                            child: Text(
                                              "Book Now",
                                              style: GoogleFonts.arvo(
                                                  color: Colors.white),
                                            ),
                                            style: TextButton.styleFrom(
                                                backgroundColor: Colors.teal,
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 20,
                                                    vertical: 10),
                                                elevation: 2,
                                                shape: StadiumBorder(
                                                    side: BorderSide(
                                                        color: Colors.teal))),
                                          )),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                      childCount: value.findWorkshopList.length)),
        )
      ],
    ));
  }

  void _addBookingDetialPage(
      BuildContext context, Workshops workshop, int index) async {
    final provider = Provider.of<StateProvider>(context, listen: false);
    TextEditingController _msgTxt = TextEditingController();
    Position loc = await provider.fetchLocation();
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        context: context,
        builder: (bCtx) {
          print(workshop.uid);
          return Container(
            padding: EdgeInsets.all(12),
            height: MediaQuery.of(context).size.height * .65,
            decoration: BoxDecoration(
                color: Color(0xff393e46),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "Confirm Booking",
                  style: GoogleFonts.ubuntu(color: Colors.white, fontSize: 30),
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "Workshop name:\t",
                      style: GoogleFonts.ubuntu(
                          color: Colors.grey.shade400, fontSize: 22),
                    ),
                    Flexible(
                      child: Text(
                        workshop.name,
                        style: GoogleFonts.ubuntu(
                            color: Colors.white, fontSize: 22),
                      ),
                    )
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Your Location",
                      style: GoogleFonts.ubuntu(
                          color: Colors.grey.shade400, fontSize: 22),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Latitude: ${loc.latitude}\nLongitude: ${loc.longitude}",
                      style: GoogleFonts.ubuntuCondensed(
                          color: Colors.blue, fontSize: 18),
                    )
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Leave a message",
                      style: GoogleFonts.ubuntu(
                          color: Colors.grey.shade400, fontSize: 22),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                      child: TextField(
                        controller: _msgTxt,
                        maxLines: 5,
                        decoration: InputDecoration(
                          hintText: "Leave a message to mechanic....",
                          fillColor: Color(0xffe1e5ea),
                          filled: true,
                        ),
                      ),
                    )
                  ],
                ),
                TextButton(
                  onPressed: () {
                    provider.bookService(
                        loc, workshop.uid, _msgTxt.text, index);

                    Navigator.pop(context);
                  },
                  child: Text(
                    "Book Service",
                    style:
                        GoogleFonts.ubuntu(color: Colors.white, fontSize: 22),
                  ),
                  style: TextButton.styleFrom(
                      backgroundColor: Colors.blue,
                      minimumSize: Size(100, 50),
                      elevation: 2,
                      padding: EdgeInsets.symmetric(horizontal: 18),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15))),
                )
              ],
            ),
          );
        });
  }
}
