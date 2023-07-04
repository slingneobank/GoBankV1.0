
import 'package:flutter/material.dart';
import 'package:gobank/home/giftcard/voucher_finger.dart';
import 'package:gobank/home/giftcard/voucher_grocery.dart';
import 'package:gobank/home/giftcard/voucher_mall.dart';
import 'package:gobank/home/giftcard/voucher_movie.dart';
import 'package:gobank/home/giftcard/voucher_offers.dart';
import 'package:gobank/home/giftcard/voucher_shopdrop.dart';
import 'package:gobank/home/giftcard/voucherbanner.dart';
import 'package:gobank/utils/media.dart';

class buyvoucher extends StatefulWidget {
  const buyvoucher({Key? key}) : super(key: key);

  @override
  State<buyvoucher> createState() => _buyvoucherState();
}

class _buyvoucherState extends State<buyvoucher> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Container(
              height: 120,
              color: Colors.black,
              child: Column(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, top: 10),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Container(
                            height: 20,
                            width: 20,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.white54,
                              ),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: const Icon(
                              Icons.arrow_back_ios_new,
                              size: 12,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Text(
                          "Buy Saving Vouchers!",
                          style: TextStyle(
                            fontFamily: "Gilroy Bold",
                            color: Colors.white,
                            fontSize: height / 35,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 10),
                    child: Row(
                      children: [
                        Text(
                          "₹0.0",
                          style: TextStyle(
                            fontFamily: "Gilroy medium",
                            color: Colors.white,
                            fontSize: height / 40,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          "Saved till now",
                          style: TextStyle(
                            fontFamily: "Gilroy medium",
                            color: Colors.white54,
                            fontSize: height / 45,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          "My Vouchers",
                          style: TextStyle(
                            fontFamily: "Gilroy medium",
                            color: Colors.amber[300],
                            fontSize: height / 45,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Stack(
                  children: [
                    Container(
                      color: Colors.black,
                      height: 2500,
                    ),
                    Column(
                      children: [
                       const Padding(
                          padding: EdgeInsets.only(top: 20),
                          child: SizedBox(
                            child: voucherbanner(),
                            ),
                        ),
                        const SizedBox(height: 20,),
                        Container(
                            decoration:const BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Color.fromARGB(255, 203, 199, 185),
                                  
                                   Colors.black,
                                   ],
                                begin: Alignment.topCenter,
                                end: Alignment.center,
                              ),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20.0),
                                topRight: Radius.circular(20.0),
                              ),
                            ),
                            child: Stack(
                              children: [
                                Container(
                                  height: 400, // Adjust the height as needed
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20.0),
                                      topRight: Radius.circular(20.0),
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 25,left: 20),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Shop till you drop 🛍️",
                                        style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: height / 45,
                                                    fontFamily: 'Gilroy bold'),
                                        ),
                                        const SizedBox(height: 10,),
                                        const voucher_shopdrop()
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                       // SizedBox(height: 20,),
                        Container(
                            decoration:const BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Color.fromARGB(255, 91, 82, 110),
                                  
                                   Colors.black,
                                   ],
                                begin: Alignment.topCenter,
                                end: Alignment.center,
                              ),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20.0),
                                topRight: Radius.circular(20.0),
                              ),
                            ),
                            child: Stack(
                              children: [
                                Container(
                                  height: 400, // Adjust the height as needed
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20.0),
                                      topRight: Radius.circular(20.0),
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 25,left: 20),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Finger-lickin'Discounts 🙂",
                                        style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: height / 45,
                                                    fontFamily: 'Gilroy bold'),
                                        ),
                                        const SizedBox(height: 10,),
                                        const voucher_finger()
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            decoration:const BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Color.fromARGB(255, 187, 155, 160),
                                  
                                   Colors.black,
                                   ],
                                begin: Alignment.topCenter,
                                end: Alignment.center,
                              ),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20.0),
                                topRight: Radius.circular(20.0),
                              ),
                            ),
                            child: Stack(
                              children: [
                                Container(
                                  height: 400, // Adjust the height as needed
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20.0),
                                      topRight: Radius.circular(20.0),
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 25,left: 20),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Daily Grocery",
                                        style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: height / 45,
                                                    fontFamily: 'Gilroy bold'),
                                        ),
                                        const SizedBox(height: 10,),
                                        const voucher_grocery()
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            decoration:const BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Color.fromARGB(255, 185, 212, 177),
                                  
                                   Colors.black,
                                   ],
                                begin: Alignment.topCenter,
                                end: Alignment.center,
                              ),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20.0),
                                topRight: Radius.circular(20.0),
                              ),
                            ),
                            child: Stack(
                              children: [
                                Container(
                                  height: 400, // Adjust the height as needed
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20.0),
                                      topRight: Radius.circular(20.0),
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 25,left: 20),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Movies and OTT 🎞️",
                                        style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: height / 45,
                                                    fontFamily: 'Gilroy bold'),
                                        ),
                                        const SizedBox(height: 10,),
                                        const voucher_movie()
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            decoration:const BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Color.fromARGB(255, 241, 229, 184),
                                  
                                   Colors.black,
                                   ],
                                begin: Alignment.topCenter,
                                end: Alignment.center,
                              ),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20.0),
                                topRight: Radius.circular(20.0),
                              ),
                            ),
                            child: Stack(
                              children: [
                                Container(
                                  height: 400, // Adjust the height as needed
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20.0),
                                      topRight: Radius.circular(20.0),
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 25,left: 20),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Let's Go To The Mall 🏬",
                                        style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: height / 45,
                                                    fontFamily: 'Gilroy bold'),
                                        ),
                                        const SizedBox(height: 10,),
                                        const voucher_mall()
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            decoration:const BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Color.fromARGB(255, 114, 112, 153),
                                  
                                   Colors.black,
                                   ],
                                begin: Alignment.topCenter,
                                end: Alignment.center,
                              ),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20.0),
                                topRight: Radius.circular(20.0),
                              ),
                            ),
                            child: Stack(
                              children: [
                                Container(
                                  height: 400, // Adjust the height as needed
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20.0),
                                      topRight: Radius.circular(20.0),
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 25,left: 20),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "More Offers 😃",
                                        style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: height / 45,
                                                    fontFamily: 'Gilroy bold'),
                                        ),
                                        const SizedBox(height: 10,),
                                        const voucher_offfers()
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


