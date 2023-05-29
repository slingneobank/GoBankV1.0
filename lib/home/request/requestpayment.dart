import 'package:flutter/material.dart';
import 'package:gobank/card/inoutpayment.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../bottombar/bottombar.dart';
import '../../utils/colornotifire.dart';
import '../../utils/media.dart';
import '../../utils/string.dart';

class RequestPayment extends StatefulWidget {
  const RequestPayment({Key? key}) : super(key: key);

  @override
  State<RequestPayment> createState() => _RequestPaymentState();
}

class _RequestPaymentState extends State<RequestPayment> {
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

  final List<Map> _myjson = [
    {
      'id': '1',
      'image': 'images/dollar.png',
      'Text': "USD",
    },
    {
      'id': '2',
      'image': 'images/dollar.png',
      'Text': "USD",
    },
    {
      'id': '3',
      'image': 'images/dollar.png',
      'Text': "USD",
    },
    {
      'id': '4',
      'image': 'images/dollar.png',
      'Text': "USD",
    },
    {
      'id': '5',
      'image': 'images/dollar.png',
      'Text': "USD",
    }
  ];
  var items = [
    CustomStrings.salary,
  ];

  String dropdownvalue = CustomStrings.salary;
  String? _selectedindex;

  @override
  Widget build(BuildContext context) {
    notifire = Provider.of<ColorNotifire>(context, listen: true);
    return Scaffold(
      backgroundColor: notifire.getprimerycolor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: height,
                  width: width,
                  color: Colors.transparent,
                  child: Image.asset(
                    "images/background.png",
                    fit: BoxFit.cover,
                  ),
                ),
                Column(
                  children: [
                    SizedBox(
                      height: height / 20,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: width / 20,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.arrow_back,
                            color: notifire.getdarkscolor,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          CustomStrings.requestpayment,
                          style: TextStyle(
                              color: notifire.getdarkscolor,
                              fontSize: height / 40,
                              fontFamily: 'Gilroy Bold'),
                        ),
                        const Spacer(),
                        Image.asset(
                          "images/fillstar.png",
                          height: height / 35,
                        ),
                        SizedBox(
                          width: width / 20,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height / 40,
                    ),
                    Container(
                      height: height / 10,
                      width: width / 5,
                      decoration: const BoxDecoration(
                        color: Colors.transparent,
                        shape: BoxShape.circle,
                      ),
                      child: Image.asset("images/man4.png"),
                    ),
                    SizedBox(
                      height: height / 50,
                    ),
                    Text(
                      CustomStrings.aileen,
                      style: TextStyle(
                        color: notifire.getdarkscolor,
                        fontFamily: 'Gilroy Bold',
                        fontSize: height / 40,
                      ),
                    ),
                    SizedBox(
                      height: height / 200,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          CustomStrings.bank,
                          style: TextStyle(
                            color: Colors.grey,
                            fontFamily: 'Gilroy Medium',
                            fontSize: height / 50,
                          ),
                        ),
                        SizedBox(
                          width: width / 100,
                        ),
                        Text(
                          "|",
                          style: TextStyle(
                            color: Colors.grey,
                            fontFamily: 'Gilroy Medium',
                            fontSize: height / 50,
                          ),
                        ),
                        SizedBox(
                          width: width / 100,
                        ),
                        Text(
                          "47896321",
                          style: TextStyle(
                            color: Colors.grey,
                            fontFamily: 'Gilroy Medium',
                            fontSize: height / 50,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height / 30,
                    ),
                    const Divider(
                      thickness: 0.6,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      height: height / 50,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: width / 20),
                      child: Container(
                        height: height / 10,
                        width: width,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          border: Border.all(color: notifire.getbluecolor),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(15),
                          ),
                        ),
                        child: Row(
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: width / 20,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color:
                                        notifire.getbluecolor.withOpacity(0.4),
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(30),
                                    ),
                                  ),
                                  height: height / 20,
                                  child: DropdownButtonHideUnderline(
                                    child: ButtonTheme(
                                      buttonColor: notifire.getdarkscolor,
                                      child: DropdownButton<String>(
                                        dropdownColor: notifire.getprimerycolor,
                                        icon: Padding(
                                          padding: EdgeInsets.only(
                                              right: width / 50),
                                          child: Image.asset(
                                            "images/dropdwnicon.png",
                                          ),
                                        ),
                                        hint: Row(
                                          children: [
                                            SizedBox(
                                              width: width / 40,
                                            ),
                                            Image.asset(
                                              "images/dollar.png",
                                              height: height / 28,
                                              color: notifire.getbluecolor,
                                            ),
                                            SizedBox(
                                              width: width / 80,
                                            ),
                                            const Text(
                                              "USD",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontFamily: 'Gilroy Bold'),
                                            ),
                                          ],
                                        ),
                                        value: _selectedindex,
                                        onChanged: (newValue) {
                                          setState(() {
                                            _selectedindex = newValue;
                                          });
                                        },
                                        items: _myjson.map(
                                          (Map map) {
                                            return DropdownMenuItem<String>(
                                              value: map["id"].toString(),
                                              child: Row(
                                                children: <Widget>[
                                                  SizedBox(
                                                    width: width / 40,
                                                  ),
                                                  Image.asset(
                                                    map["image"].toString(),
                                                    width: width / 15,
                                                    color:
                                                        notifire.getbluecolor,
                                                  ),
                                                  SizedBox(
                                                    width: width / 80,
                                                  ),
                                                  Text(
                                                    map["Text"].toString(),
                                                    style: const TextStyle(
                                                        color: Colors.black,
                                                        fontFamily:
                                                            'Gilroy Bold'),
                                                  ),
                                                  SizedBox(
                                                    width: width / 50,
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        ).toList(),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: width / 20),
                              child: Container(
                                width: width / 2,
                                color: Colors.transparent,
                                child: TextFormField(
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                      color: notifire.getdarkscolor,
                                      fontSize: height / 30,
                                      fontFamily: 'Gilroy Bold'),
                                  cursorColor: Colors.black,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      errorBorder: InputBorder.none,
                                      disabledBorder: InputBorder.none,
                                      hintText: "\$.125",
                                      hintStyle: TextStyle(
                                          fontSize: height / 30,
                                          color: notifire.getdarkgreycolor
                                              .withOpacity(0.4),
                                          fontFamily: 'Gilroy Bold')),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height / 50,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: width / 20),
                      child: Row(
                        children: [
                          Text(
                            CustomStrings.selectcategory,
                            style: TextStyle(
                                color: notifire.getdarkscolor,
                                fontSize: height / 50,
                                fontFamily: 'Gilroy Bold'),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: height / 50,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: width / 20),
                      child: Container(
                        height: height / 17,
                        width: width,
                        decoration: BoxDecoration(
                          color: notifire.getdarkwhitecolor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: DropdownButton(
                          underline: const SizedBox(),
                          value: dropdownvalue,
                          icon: Row(
                            children: [
                              SizedBox(
                                width: width / 1.4,
                              ),
                              Image.asset(
                                "images/dropdwnicon.png",
                                color: notifire.getdarkscolor,
                              ),
                            ],
                          ),
                          items: items.map((String items) {
                            return DropdownMenuItem(
                              value: items,
                              child: Row(
                                children: [
                                  SizedBox(width: width / 50),
                                  Text(
                                    items,
                                    style: TextStyle(fontSize: height / 60),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                          // After selecting the desired option,it will
                          // change button value to selected value
                          onChanged: (String? newValue) {
                            setState(() {
                              dropdownvalue = newValue!;
                            });
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height / 50,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: width / 20),
                      child: Row(
                        children: [
                          Text(
                            CustomStrings.notes,
                            style: TextStyle(
                                color: notifire.getdarkscolor,
                                fontSize: height / 50,
                                fontFamily: 'Gilroy Bold'),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: height / 50,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: width / 20),
                      child: Container(
                        color: Colors.transparent,
                        width: width,
                        height: height / 17,
                        child: TextField(
                          autofocus: false,
                          style: TextStyle(
                            fontSize: height / 50,
                            color: notifire.getdarkscolor,
                          ),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: notifire.getdarkwhitecolor,
                            hintText: "Notes",
                            hintStyle: TextStyle(
                                color: Colors.grey, fontSize: height / 60),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                   BorderSide(color: Colors.grey.withOpacity(0.3),),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                   BorderSide(color: Colors.grey.withOpacity(0.3),),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height / 6,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: width / 20),
                      child: GestureDetector(
                        onTap: (){
                          _showMyDialog();
                        },
                        child: Container(
                          height: height / 17,
                          width: width,
                          decoration: BoxDecoration(
                            color: notifire.getbluecolor,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(30),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              CustomStrings.sendrequest,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Gilroy Bold',
                                  fontSize: height / 50),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(32.0),
            ),
          ),
          child: Container(
            decoration:  BoxDecoration(
              color: notifire.getprimerycolor,
              borderRadius: const BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            height: height / 2,
            child: Column(
              children: [
                SizedBox(
                  height: height / 40,
                ),
                Image.asset(
                  "images/paymentsuccess.png",
                  height: height / 5,
                ),
                SizedBox(
                  height: height / 40,
                ),
                Text(
                  CustomStrings.requestsent,
                  style: TextStyle(
                    color: notifire.getbluecolor,
                    fontFamily: 'Gilroy Bold',
                    fontSize: height / 40,
                  ),
                ),
                SizedBox(
                  height: height / 100,
                ),
                Text(
                  CustomStrings.paymentbeen,
                  style: TextStyle(
                    color: notifire.getdarkgreycolor,
                    fontFamily: 'Gilroy Bold',
                    fontSize: height / 60,
                  ),
                ),
                SizedBox(
                  height: height / 30,
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const InOutPayment(),),);
                  },
                  child: buttons(notifire.getbluecolor, CustomStrings.viewreceipt,
                      Colors.white),
                ),
                SizedBox(
                  height: height / 60,
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Bottombar(),),);
                  },
                  child: buttons(const Color(0xffd3d3d3), CustomStrings.home,
                      notifire.getbluecolor),),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buttons(clr, txt, clr2) {
    return Container(
      height: height / 20,
      width: width / 2,
      decoration: BoxDecoration(
        color: clr,
        borderRadius: const BorderRadius.all(
          Radius.circular(30),
        ),
      ),
      child: Center(
        child: Text(
          txt,
          style: TextStyle(
              color: clr2, fontSize: height / 60, fontFamily: 'Gilroy Bold'),
        ),
      ),
    );
  }

}
