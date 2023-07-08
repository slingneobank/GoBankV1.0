import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:gobank/utils/media.dart';
import 'package:google_fonts/google_fonts.dart';

class AddMoneyToGoal extends StatefulWidget {
  const AddMoneyToGoal({Key? key}) : super(key: key);

  @override
  State<AddMoneyToGoal> createState() => _AddMoneyToGoalState();
}

class _AddMoneyToGoalState extends State<AddMoneyToGoal> {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
            SizedBox(
              height: height / 60,
            ),
            Row(
              children: [
                InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: const Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  "Add Money To Goal",
                  textAlign: TextAlign.left,
                  style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(
              height: height / 60,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  "Keep the savings going! Add money now to\nincrease your general savings",
                  style: GoogleFonts.poppins(
                      color: Colors.grey.shade400,
                      fontSize: 10,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(
              height: height / 30,
            ),
            Container(
              height: height / 1.2,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20), topRight: Radius.circular(20)),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Stack(
                  children: [
                    ListView(
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        SizedBox(
                          height: height / 30,
                        ),
                        Container(
                          height: height / 15,
                          decoration: BoxDecoration(
                            color: Colors.deepPurple.shade50,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                              child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      height: height / 20,
                                      width: height / 20,
                                      decoration: BoxDecoration(
                                        image: const DecorationImage(
                                            image: AssetImage(
                                                "images/onbonding1.png")),
                                        color: Colors.deepPurple.shade100,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "General Savings",
                                      style: GoogleFonts.poppins(
                                          color: Colors.black,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                                Text(
                                  "\u{20B9}0.00",
                                  style: GoogleFonts.poppins(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          )),
                        ),
                        SizedBox(
                          height: height / 40,
                        ),
                        Text(
                          "Add Money To Goal:",
                          textAlign: TextAlign.left,
                          style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: height / 40,
                        ),
                        Container(
                          width: 300,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  width: 1,
                                  color: Colors.grey.shade200,
                                  style: BorderStyle.solid)),
                          child: TextField(
                            controller: controller,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            decoration: const InputDecoration(
                                hintText: 'Enter amount',
                                contentPadding: EdgeInsets.all(15),
                                border: InputBorder.none,
                                prefixText: '₹ ',
                                prefixStyle: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold)),
                            onChanged: (value) {
                              // Do something
                            },
                          ),
                        )
                      ],
                    ),
                    Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: 15, right: 15, bottom: height / 40),
                          child: InkWell(
                            onTap: () {},
                            child: Container(
                              // width: width / 1.2,
                              height: height / 17,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.orange.shade300),
                              child: Center(
                                child: Text(
                                  "Add Money",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.poppins(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                          ),
                        ))
                  ],
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
