import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mechonwheelz/services/models.dart';
import 'package:mechonwheelz/services/providerClass.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<StateProvider>(context, listen: false);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xfffff5fd),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: size.height * .33,
            floating: true,
            collapsedHeight: 100,
          stretch: true,
            backgroundColor: Colors.transparent,
            flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      color: Color(0xff232323),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey,
                            blurRadius: 8,
                            spreadRadius: 3,
                            offset: Offset(0, 1.5))
                      ]),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Find",
                        style:
                            GoogleFonts.lato(color: Colors.white, fontSize: 25),
                      ),
                      Text(
                        "Workshops",
                        style: GoogleFonts.lato(color: Colors.grey.shade500),
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
                          style: TextStyle(
                              color: Colors.grey.shade200, fontSize: 14),
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              CupertinoIcons.search_circle_fill,
                              color: Colors.teal.shade300,
                            ),
                            hintText: "Search you're looking for..",
                            hintStyle:
                                TextStyle(color: Colors.grey, fontSize: 12),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.blue.shade300),
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )),
          ),
          Consumer<StateProvider>(builder: (context, value, child) {
            // value.fetchWorkshops();
            return value.findWorkshopList.isEmpty
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
                                                  value.findWorkshopList[index]
                                                      .lat,
                                                  value.findWorkshopList[index]
                                                      .lon),
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
                        childCount: value.findWorkshopList.length),
                  );
          })
        ],
      ),
    );
  }
}
