import 'dart:async';
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gobank/home/home_ctrl.dart';
import 'package:gobank/utils/media.dart';
import 'package:google_fonts/google_fonts.dart';

class CouponSliders extends StatefulWidget {
  const CouponSliders({Key? key}) : super(key: key);

  @override
  _CouponSlidersState createState() => _CouponSlidersState();
}

class _CouponSlidersState extends State<CouponSliders> {
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

  List<String> _imageUrls = [];

  final homeCtrl = Get.find<HomeCtrl>();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: homeCtrl.database.ref().child("offers").onValue,
        builder: (context, snapshot) {
          if (snapshot.hasData &&
              snapshot.data != null &&
              (snapshot.data! as DatabaseEvent).snapshot.value != null) {
            _imageUrls.clear();
            log((snapshot.data as DatabaseEvent).snapshot.value.toString());

            final myMessages = Map<dynamic, dynamic>.from(
                (snapshot.data! as DatabaseEvent).snapshot.value
                    as Map<dynamic, dynamic>); //typecasting
            myMessages.forEach((key, value) {
              final data = Map<String, dynamic>.from(value);
              _imageUrls.add(
                  // "title": data['title'],
                  // "time": data['time'],
                  // "imageUrl":
                  data['imageUrl']);
            });
            log(_imageUrls.toString());
            return ListView.builder(
              controller: _controller,
              scrollDirection: Axis.horizontal,
              itemExtent: MediaQuery.of(context).size.width - width / 10,
              itemCount: _imageUrls.length, //_colors.length
              itemBuilder: (context, index) {
                // A container with some padding and a color from the list
                return Padding(
                  padding: const EdgeInsets.only(left: 3.0),
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.fill, image: NetworkImage(_imageUrls[0])),
                      // color: Colors.yellow[300],
                      color: _colors[index],

                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    // A text widget with some style and the index of the container
                    child: Center(
                        // child: Text(
                        //   'Container ${index + 1}',
                        //   style: TextStyle(
                        //     color: Colors.white,
                        //     fontSize: 32.0,
                        //     fontWeight: FontWeight.bold,
                        //   ),
                        // ),
                        ),
                  ),
                );
              },
            );
          } else {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Container(
                height: 250,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5.0, horizontal: 6),
                  child: Column(children: [
                    Expanded(
                        flex: 4,
                        child: Container(
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.contain,
                                  image:
                                      AssetImage("assets/icons/discount.png"))),
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
            );
          }
        });
  }
}
