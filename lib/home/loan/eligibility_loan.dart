

import 'package:flutter/material.dart';
import 'package:gobank/utils/colornotifire.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
class eligibility_loan extends StatefulWidget {
  const eligibility_loan({Key? key}) : super(key: key);

  @override
  State<eligibility_loan> createState() => _eligibility_loanState();
}

class _eligibility_loanState extends State<eligibility_loan> {
  late ColorNotifire notifire;

  getdarkmodepreviousstate() async {
    final prefs = await SharedPreferences.getInstance();
    bool? previusstate = prefs.getBool("setIsDark");
    if (previusstate == null) {
      notifire.setIsDark = false;
    } else {
      notifire.setIsDark = previusstate;
    }
  }

  @override
  Widget build(BuildContext context) {
    notifire = Provider.of<ColorNotifire>(context, listen: true);
    final mediaQuery = MediaQuery.of(context);
    final height = mediaQuery.size.height;
    final width = mediaQuery.size.width;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(color: Color.fromARGB(255, 238, 233, 233)),
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                child: Padding(
                  padding: EdgeInsets.only(top: height * 0.05, bottom: height * 0.01),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: width * 0.05, right: width * 0.05),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: const Icon(Icons.arrow_back),
                            ),
                            SizedBox(
                              child: Row(
                                children: [
                                  const CircleAvatar(
                                    radius: 20,
                                    backgroundColor: Colors.blue,
                                    child: CircleAvatar(
                                      radius: 16,
                                      backgroundColor: Color.fromARGB(255, 3, 17, 91),
                                      child: Icon(
                                        Icons.currency_rupee,
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 5,),
                                  Text(
                                    "Personal\nLoan",
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: notifire.getdarkscolor,
                                        fontSize: height / 40,
                                        fontFamily: 'Gilroy bold'),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              "Help",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: const Color(0xff4287E3),
                                  fontSize: height / 40,
                                  fontFamily: 'Gilroy bold'),
                            ),
                          ],
                        ),
                      ),
       


                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: SingleChildScrollView(
                child: Container(
                  decoration: const BoxDecoration(color: Colors.white),
                  child: Padding(
                    padding: EdgeInsets.only(top: height * 0.01, left: width * 0.05, right: width * 0.05),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Sorry, we cannot Proceed\nwith your application",
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: notifire.getdarkscolor,
                                    fontSize: height / 35,
                                    fontFamily: 'Gilroy bold'),
                              ),
                              SizedBox(
                                child: CircleAvatar(
                                  radius: 35,
                                  backgroundColor: const Color.fromARGB(255, 238, 233, 233),
                                  child: Image.asset("images/eligible.png"),
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: height * 0.03),
                        SizedBox(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Your Application could not clear our lender partner,",
                                overflow: TextOverflow.clip,
                                style: TextStyle(
                                    color: notifire.getdarkscolor,
                                    fontSize: height / 50,
                                    fontFamily: 'Gilroy medium'),
                              ),
                              Text(
                                "Aditya Birla Finance Limited internal loan approval policy.",
                                overflow: TextOverflow.clip,
                                style: TextStyle(
                                    color: notifire.getdarkscolor,
                                    fontSize: height / 50,
                                    fontFamily: 'Gilroy medium'),
                              ),
                              Text(
                                "You may please try after 90 days to check your eligibility.",
                                overflow: TextOverflow.clip,
                                style: TextStyle(
                                    color: notifire.getdarkscolor,
                                    fontSize: height / 50,
                                    fontFamily: 'Gilroy medium'),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: height * 0.02),
                        Text(
                          "Why was my application not approved?",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: const Color(0xff4287E3),
                              fontSize: height / 52,
                              fontFamily: 'Gilroy bold'),
                        ),
                        SizedBox(height: height * 0.02),
                        Container(
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [
                                Color(0xff3A9EEA),
                                Color(0xff2359D7),
                              ],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Stack(
                            children: [
                              Container(
                                height: 100, // Adjust the height as needed
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20.0),
                                    topRight: Radius.circular(20.0),
                                  ),
                                ),
                              ),
                              Container(
                                child: Stack(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(left: width * 0.04),
                                      child: const CircleAvatar(
                                        backgroundColor: Color(0xff4CA2EB),
                                        radius: 60,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: height * 0.04, left: width * 0.25),
                                      child: Align(
                                       // alignment: Alignment.centerRight,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              " ₹75,000 ke benefits\nkhaas aapke liye",
                                              overflow: TextOverflow.clip,
                                              style: TextStyle(
                                                  color: notifire.getdarkwhitecolor,
                                                  fontSize: height / 40,
                                                  fontFamily: 'Gilroy bold'),
                                            ),
                                            SizedBox(
                                              height: 25,
                                              width: 120,
                                              child: OutlinedButton(
                                                onPressed: () {},
                                                child: Text(
                                                  "Apply Now",
                                                  style: TextStyle(
                                                      color: notifire.getdarkscolor,
                                                      fontSize: height / 50,
                                                      fontFamily: 'Gilroy bold'),
                                                ),
                                                style: ButtonStyle(
                                                  backgroundColor: MaterialStateProperty.all<Color>(const Color(0xff2BEEDC)),
                                                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                    RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(20),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 15),
                                            Text(
                                              "*Credit card facility is provided in partnership with our banking partners",
                                              overflow: TextOverflow.clip,
                                              style: TextStyle(
                                                  color: notifire.getdarkwhitecolor,
                                                  fontSize: height / 130,
                                                  fontFamily: 'Gilroy medium'),
                                            ),
                                            const SizedBox(height: 10),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: height * 0.015),
                        Text(
                          "Improve Your Chances",
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                              color: notifire.getdarkscolor,
                              fontSize: height / 45,
                              fontFamily: 'Gilroy bold'),
                        ),
                        SizedBox(height: height * 0.02),
                        listtype(
                          const Color(0xffF1F0F8),
                          "images/money-bag.png",
                          "Repay your current dues",
                          "Timely repayment of loans and dues helps build your credit profile",
                        ),
                        SizedBox(height: height * 0.02),
                        listtype(
                          const Color(0xffE9F9F9),
                          "images/payment.png",
                          "Increase your activity on Paytm",
                          "This will help increase your chances to get a Personal Loan from Paytm",
                        ),
                        SizedBox(height: height * 0.02),
                        listtype(
                          const Color(0xffFBF0F6),
                          "images/speedometer.png",
                          "Maintain a good credit score",
                          "Higher the credit score, higher the chances of getting credit",
                        ),
                        SizedBox(height: height * 0.03),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              child: Row(
                                children: [
                                  const Icon(Icons.messenger_outline),
                                  const SizedBox(width: 10),
                                  SizedBox(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "View FAQ",
                                          overflow: TextOverflow.clip,
                                          style: TextStyle(
                                              color: notifire.getdarkscolor,
                                              fontSize: height / 50,
                                              fontFamily: 'Gilroy bold'),
                                        ),
                                        Text(
                                          "FAQs about Personal Loan",
                                          overflow: TextOverflow.clip,
                                          style: TextStyle(
                                              color: notifire.getdarkgreycolor,
                                              fontSize: height / 55,
                                              fontFamily: 'Gilroy bold'),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {},
                              child: const Icon(
                                Icons.arrow_forward_ios,
                                size: 20,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            
            ),
          ],
        ),
      ),
    );
  }

  Widget listtype(Color color, String imgpath, String title, String subtitle) {
    return Row(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: Colors.black54,
          child: CircleAvatar(
            radius: 29,
            backgroundColor: Colors.white,
            child: CircleAvatar(
              backgroundColor: color,
              child: SizedBox(child: Image.asset(imgpath, height: 25)),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: SizedBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  overflow: TextOverflow.clip,
                  style: TextStyle(
                      color: notifire.getdarkscolor,
                      fontSize: MediaQuery.of(context).size.height / 50,
                      fontFamily: 'Gilroy bold'),
                ),
                Text(
                  subtitle,
                  overflow: TextOverflow.clip,
                  style: TextStyle(
                      color: notifire.getdarkgreycolor,
                      fontSize: MediaQuery.of(context).size.height / 55,
                      fontFamily: 'Gilroy medium'),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

