import 'dart:async';
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gobank/home/home_ctrl.dart';
import 'package:gobank/home/savers_club_detail.dart';
import 'package:gobank/home/sling_store/product_card.dart';
import 'package:gobank/utils/media.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class SlingStoreSlider extends StatefulWidget {
  SlingStoreSlider(this.doc, {Key? key}) : super(key: key);
  String doc;

  @override
  _SlingStoreSliderState createState() => _SlingStoreSliderState();
}

class _SlingStoreSliderState extends State<SlingStoreSlider> {
  // A controller for the list view
  late ScrollController _controller;

  // A timer for the automatic scrolling
  Timer? _timer;

  // The duration for the automatic scrolling
  final Duration _duration = Duration(seconds: 3);

  // The list of colors for the containers
  final List<Color> _colors = [
    Colors.orange,
    Colors.yellow,
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.indigo,
    Colors.purple,
    Colors.pink,
    Colors.brown,
    Colors.grey,
  ];

  @override
  void initState() {
    super.initState();
    // Initialize the controller
    _controller = ScrollController();
    // Start the timer
    _startTimer();
  }

  @override
  void dispose() {
    // Dispose the controller
    _controller.dispose();
    // Cancel the timer
    _timer?.cancel();
    super.dispose();
  }

  // A method to start the timer
  void _startTimer() {
    // Cancel the previous timer if any
    _timer?.cancel();
    // Create a new timer that scrolls the list view every duration
    _timer = Timer.periodic(_duration, (timer) {
      // Get the current scroll position
      double position = _controller.position.pixels;
      // Get the maximum scroll extent
      double max = _controller.position.maxScrollExtent;
      // Get the width of the list view
      double width = MediaQuery.of(context).size.width;
      // Calculate the next scroll position
      double next = position + width;
      // If the next position exceeds the maximum, go back to the start
      if (next > max) {
        next = 0.0;
      }
      // Animate the scrolling to the next position
      _controller.animateTo(
        next,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeOut,
      );
    });
  }

  // List<String> _imageUrls = [];
  List<Map> types = [];

  final homeCtrl = Get.find<HomeCtrl>();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: homeCtrl.database.ref().child(widget.doc).onValue,
        builder: (context, snapshot) {
          if (snapshot.hasData &&
              snapshot.data != null &&
              (snapshot.data! as DatabaseEvent).snapshot.value != null) {
            // _imageUrls.clear();
            types.clear();
            log((snapshot.data as DatabaseEvent).snapshot.value.toString());

            final myMessages = Map<dynamic, dynamic>.from(
                (snapshot.data! as DatabaseEvent).snapshot.value
                    as Map<dynamic, dynamic>); //typecasting
            myMessages.forEach((key, value) {
              final data = Map<String, dynamic>.from(value);
              // _imageUrls.add(
              //     // "title": data['title'],
              //     // "time": data['time'],
              //     // "imageUrl":
              //     data['image']);

              types.add({
                "image": data['image'],
                "price": data["price"],
                "name": data["name"],
                "desc": data["desc"]
              });
            });
            log(types.toString());
            return ListView.builder(
              controller: _controller,
              scrollDirection: Axis.horizontal,
              itemExtent: MediaQuery.of(context).size.width - width / 1.9,
              itemCount: types.length, //_colors.length
              itemBuilder: (context, index) {
                // A container with some padding and a color from the list
                return GestureDetector(
                  onTap: () async {
                    Get.to(() => SaversClubDetail(types[index]));
                  },
                  child:
                      // ProductCard(image: types[index]["image"] ,name: "Product",price: 100,)
                      Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: Stack(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.fill,
                                image: NetworkImage(types[index]["image"])),
                            // color: Colors.yellow[300],
                            color: _colors[index],

                            borderRadius: BorderRadius.circular(12.0),
                          ),

                          // A text widget with some style and the index of the container
                        ),
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Container(
                              height: height / 25,
                              constraints: const BoxConstraints(
                                maxWidth: 60,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.yellow[300]?.withOpacity(0.7),
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              child: Center(
                                  child: Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Text(
                                  types[index]["price"] == ""
                                      ? "Rs.0"
                                      : '\u{20B9}' + types[index]["price"],
                                  style: GoogleFonts.poppins(
                                      color: Colors.black,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 0.8),
                                ),
                              )),
                              // A text widget with some style and the index of the container
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return GestureDetector(
              onTap: () {
                //!temporary
                //3 types - detail , shop , redirect to url
                // Get.to(() => SaversClubDetail());

                // if (types[index] == "detail") {
                //   Get.to(() => SlingStoreSlider());
                // } else if (types[index] == "shop") {
                // } else {}
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: Container(
                  height: 250,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 5.0, horizontal: 6),
                    child: Column(children: [
                      Expanded(
                          flex: 4,
                          child: Container(
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.contain,
                                    image: AssetImage(
                                        "assets/icons/discount.png"))),
                          )),
                      Expanded(
                        flex: 1,
                        child: Text(
                          "We have some exciting Cashback offers\nwaiting for you!",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                              color: Colors.black, fontSize: 12),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          "Start transacting now",
                          style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ]),
                  ),
                ),
              ),
            );
          }
        });
  }
}
