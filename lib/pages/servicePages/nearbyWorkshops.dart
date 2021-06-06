import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mechonwheelz/services/models.dart';
import 'package:mechonwheelz/services/providerClass.dart';
import 'package:provider/provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class FindNearby extends StatelessWidget {
  const FindNearby({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("Rebuild fetch");
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        body: CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 150,
          floating: true,
          backgroundColor: Color(0xff232323),
          // centerTitle: true,
          flexibleSpace: FlexibleSpaceBar(
            centerTitle: true,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Nearby Workshops",
                  style: GoogleFonts.poppins(
                      fontSize: 15, fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  width: 10,
                ),
                Icon(
                  CupertinoIcons.location_circle_fill,
                  color: Colors.white,
                )
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Container(
              height: 200,
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(35),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey, offset: Offset(0, 1), blurRadius: 5),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(35),
                child: Consumer<StateProvider>(
                    builder: (context, value, child) => value.refetch
                        ? SizedBox(
                            height: 50,
                            width: 50,
                            child: CircularProgressIndicator())
                        : GoogleMap(
                            markers: value.markers,
                            zoomGesturesEnabled: true,
                            myLocationButtonEnabled: true,
                            scrollGesturesEnabled: true,
                            zoomControlsEnabled: true,
                            initialCameraPosition: CameraPosition(
                              zoom: 15,
                              target: LatLng(value.lat, value.lon),
                            ))),
              )),
        ),
        Consumer<StateProvider>(builder: (context, value, child) {
          value.fetchWorkshops();
          return value.workshops.isEmpty
              ? showLoading()
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
                                    value.workshops[index].name,
                                    style: GoogleFonts.lato(
                                        color: Color(0xff293b5f),
                                        fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text(value
                                          .workshops[index].address +
                                      " " +
                                      value.workshops[index].phone.toString()),
                                  trailing: SizedBox(
                                    width: 100,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        IconButton(
                                            onPressed: null,
                                            icon: Icon(
                                              CupertinoIcons.phone_fill,
                                              color: Colors.blue,
                                            )),
                                        IconButton(
                                            onPressed: () => MapUtils.openMap(
                                                value.workshops[index].lat,
                                                value.workshops[index].lon),
                                            icon: Icon(
                                              CupertinoIcons.location_fill,
                                              color: Colors.blue,
                                            )),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                      childCount: value.workshops.length));
        })
      ],
    ));
  }

  SliverToBoxAdapter showLoading() {
    return SliverToBoxAdapter(
        child: Container(
            height: 300,
            alignment: Alignment.center,
            child: CircularProgressIndicator()));
  }
}
