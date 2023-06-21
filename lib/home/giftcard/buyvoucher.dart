import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
        // color: Colors.black,
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  height: 50,
                  color: Colors.black,
                ),
                Expanded(
                  child: Container(
                    color: Colors.black87,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [

                          Padding(
                            padding: const EdgeInsets.only(left: 20,top: 10),
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap: () => navigator!.pop(context),
                                  child: Container(
                                    height: 20,
                                    width: 20,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.white54,
                                      ),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Icon(
                                      Icons.arrow_back_ios_new,
                                      size: 12,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 20),
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
                          // Add other content here
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
