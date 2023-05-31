import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:gobank/home/sling_store/slider.dart';

import '../../utils/media.dart';
import '../savers_club_sliders.dart';
import '../sliders.dart';

class SlingStore extends StatefulWidget {
  const SlingStore({Key? key}) : super(key: key);

  @override
  State<SlingStore> createState() => _SlingStoreState();
}

class _SlingStoreState extends State<SlingStore> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            "Sling Store",
            style: TextStyle(
                fontFamily: "Gilroy Bold",
                color: Colors.white,
                fontSize: height / 40),
          ),
        ),
        body: ListView(
          children: [
            SizedBox(
              height: height / 30,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width / 30),
              child: Container(
                  height: height / 7,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: CouponSliders()),
            ),
            SizedBox(
              height: height / 30,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width / 18),
              child: Row(
                children: [
                  Text(
                    "Sling Suggests😁",
                    style: TextStyle(
                        fontFamily: "Gilroy Bold",
                        color: Colors.white,
                        fontSize: height / 40),
                  ),
                  const Spacer(),
                ],
              ),
            ),
            SizedBox(
              height: height / 50,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width / 30),
              child: Container(
                  height: height / 4.5,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: SlingStoreSlider("sling_suggests")),
            ),
            SizedBox(
              height: height / 20,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width / 18),
              child: Row(
                children: [
                  Text(
                    "Shop Essentials",
                    style: TextStyle(
                        fontFamily: "Gilroy Bold",
                        color: Colors.white,
                        fontSize: height / 40),
                  ),
                  const Spacer(),
                ],
              ),
            ),
            SizedBox(
              height: height / 50,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width / 30),
              child: Container(
                  height: height / 4.5,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: SlingStoreSlider("shop_essentials")),
            ),
            SizedBox(
              height: height / 20,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width / 18),
              child: Row(
                children: [
                  Text(
                    "Find your Style",
                    style: TextStyle(
                        fontFamily: "Gilroy Bold",
                        color: Colors.white,
                        fontSize: height / 40),
                  ),
                  const Spacer(),
                ],
              ),
            ),
            SizedBox(
              height: height / 50,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width / 30),
              child: Container(
                  height: height / 4.5,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: SlingStoreSlider("find_your_style")),
            ),
            SizedBox(
              height: height / 20,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width / 18),
              child: Row(
                children: [
                  Text(
                    "For Geeks and Gamers",
                    style: TextStyle(
                        fontFamily: "Gilroy Bold",
                        color: Colors.white,
                        fontSize: height / 40),
                  ),
                  const Spacer(),
                ],
              ),
            ),
            SizedBox(
              height: height / 50,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width / 30),
              child: Container(
                  height: height / 4.5,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: SlingStoreSlider("geeks_and_gamers")),
            ),
            SizedBox(
              height: height / 20,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width / 18),
              child: Row(
                children: [
                  Text(
                    "Let's Start Packing",
                    style: TextStyle(
                        fontFamily: "Gilroy Bold",
                        color: Colors.white,
                        fontSize: height / 40),
                  ),
                  const Spacer(),
                ],
              ),
            ),
            SizedBox(
              height: height / 50,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width / 30),
              child: Container(
                  height: height / 4.5,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: SlingStoreSlider("lets_start_packing")),
            ),
            SizedBox(
              height: height / 20,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width / 18),
              child: Row(
                children: [
                  Text(
                    "Sling Must Haves",
                    style: TextStyle(
                        fontFamily: "Gilroy Bold",
                        color: Colors.white,
                        fontSize: height / 40),
                  ),
                  const Spacer(),
                ],
              ),
            ),
            SizedBox(
              height: height / 50,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width / 30),
              child: Container(
                  height: height / 4.5,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: SlingStoreSlider("sling_must_haves")),
            ),
            SizedBox(
              height: height / 50,
            ),
          ],
        ),
      ),
    );
  }
}
