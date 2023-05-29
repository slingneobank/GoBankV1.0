import 'package:flutter/material.dart';
import 'package:gobank/home/topup/topupphone/topphoneamount.dart';
import 'package:gobank/utils/colornotifire.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/media.dart';
import '../../../utils/string.dart';

class TopPhone extends StatefulWidget {
  const TopPhone({Key? key}) : super(key: key);

  @override
  State<TopPhone> createState() => _TopPhoneState();
}

class _TopPhoneState extends State<TopPhone> {
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

  final int _numPages = 4;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(microseconds: 150),
      margin: const EdgeInsets.symmetric(horizontal: 3.0),
      height: 7.0,
      width: isActive ? 30.0 : 7.0,
      decoration: BoxDecoration(
        color: isActive
            ? notifire.getbluecolor
            : notifire.getbluecolor.withOpacity(0.4),
        borderRadius: const BorderRadius.all(
          Radius.circular(12),
        ),
      ),
    );
  }

  List recentcontactimg = [
    "images/contact1.png",
    "images/contact2.png",
    "images/contact3.png",
  ];
  List recentcname = [
    CustomStrings.alex,
    CustomStrings.niara,
    CustomStrings.mavin
  ];
  List mycColor = [
    const Color(0xffFF7426),
    const Color(0xff6C56F9),
    Colors.green,
  ];
  List mycname = [CustomStrings.aby, CustomStrings.nikcson, CustomStrings.jems];
  List myname = [
    "AH",
    "AN",
    "AJ",
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdarkmodepreviousstate();
  }

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
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: width / 20),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(
                              Icons.arrow_back,
                              color: notifire.getdarkscolor,
                            ),
                          ),
                          SizedBox(
                            width: width / 4,
                          ),
                          Text(
                            CustomStrings.topphone,
                            style: TextStyle(
                                color: notifire.getdarkscolor,
                                fontSize: height / 40,
                                fontFamily: 'Gilroy Bold'),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: height / 50,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: width / 20,
                        ),
                        Text(
                          CustomStrings.selectcard,
                          style: TextStyle(
                              color: notifire.getdarkscolor,
                              fontFamily: 'Gilroy Bold',
                              fontSize: height / 45),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height / 50,
                    ),
                    Container(
                      color: Colors.transparent,
                      height: height / 5,
                      width: width,
                      child: PageView(
                        physics: const ClampingScrollPhysics(),
                        controller: _pageController,
                        onPageChanged: (int page) {
                          setState(() {
                            _currentPage = page;
                          });
                        },
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: width / 20,
                            ),
                            child: Container(
                              height: height / 4,
                              decoration: const BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.all(Radius.circular(15),),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Image.asset(
                                  "images/visa1.png",
                                  height: height / 25,fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: width / 20,
                            ),
                            child: Container(
                              height: height / 4,
                              decoration: const BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.all(Radius.circular(15),),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Image.asset(
                                  "images/visa2.png",
                                  height: height / 25,fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: width / 20,
                            ),
                            child: Container(
                              height: height / 4,
                              decoration: const BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.all(Radius.circular(15),),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Image.asset(
                                  "images/visa3.png",
                                  height: height / 25,fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: width / 20,
                            ),
                            child: Container(
                              height: height / 4,
                              decoration: const BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.all(Radius.circular(15),),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Image.asset(
                                  "images/visa1.png",
                                  height: height / 25,fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: height / 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: _buildPageIndicator(),
                    ),
                    SizedBox(
                      height: height / 30,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: width / 20,
                        ),
                        Text(
                          CustomStrings.recentcontacts,
                          style: TextStyle(
                              color: notifire.getdarkscolor,
                              fontFamily: 'Gilroy Bold',
                              fontSize: height / 45),
                        ),
                        const Spacer(),
                        Image.asset(
                          "images/arrowright.png",
                          height: height / 30,
                          color: notifire.getdarkscolor,
                        ),
                        SizedBox(
                          width: width / 20,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height / 50,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: width / 20),
                      child: Container(
                        height: height / 4.1,
                        width: width,
                        decoration:  BoxDecoration(
                          color: notifire.gettabwhitecolor,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(15),
                          ),
                        ),
                        child: ListView.builder(
                          itemCount: recentcontactimg.length,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.only(top: height / 100),
                          itemBuilder: (context, index) => Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: width / 30),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const TopPhoneAmount(),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    color: Colors.transparent,
                                    child: Row(
                                      children: [
                                        Container(
                                          height: height / 16,
                                          width: width / 7,
                                          decoration: const BoxDecoration(
                                            color: Colors.transparent,
                                            shape: BoxShape.circle,
                                          ),
                                          child: Image.asset(
                                            recentcontactimg[index],
                                          ),
                                        ),
                                        SizedBox(
                                          width: width / 100,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              recentcname[index],
                                              style: TextStyle(
                                                  color: notifire.getdarkscolor,
                                                  fontFamily: 'Gilroy Medium',
                                                  fontSize: height / 50),
                                            ),
                                            SizedBox(
                                              height: height / 200,
                                            ),
                                            Text(
                                              "+1 4549 49746 487",
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontFamily: 'Gilroy Medium',
                                                  fontSize: height / 60),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const Divider(
                                thickness: 0.2,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height / 30,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: width / 20,
                        ),
                        Text(
                          CustomStrings.fromcontacts,
                          style: TextStyle(
                              color: notifire.getdarkscolor,
                              fontFamily: 'Gilroy Bold',
                              fontSize: height / 45),
                        ),
                        const Spacer(),
                        Image.asset(
                          "images/search.png",
                          height: height / 30,color: notifire.getdarkscolor,
                        ),
                        SizedBox(
                          width: width / 20,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height / 50,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: width / 20),
                      child: Container(
                        height: height / 4.1,
                        width: width,
                        decoration: BoxDecoration(
                          color: notifire.gettabwhitecolor,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(15),
                          ),
                        ),
                        child: ListView.builder(
                          itemCount: recentcontactimg.length,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.only(top: height / 100),
                          itemBuilder: (context, index) => Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: width / 30),
                                child: Container(
                                  color: Colors.transparent,
                                  child: Row(
                                    children: [
                                      Container(
                                        height: height / 16,
                                        width: width / 7,
                                        decoration: BoxDecoration(
                                          color: mycColor[index],
                                          shape: BoxShape.circle,
                                        ),
                                        child: Center(
                                          child: Text(
                                            myname[index],
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: height / 50),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: width / 100,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            mycname[index],
                                            style: TextStyle(
                                                color: notifire.getdarkscolor,
                                                fontFamily: 'Gilroy Medium',
                                                fontSize: height / 50),
                                          ),
                                          SizedBox(
                                            height: height / 200,
                                          ),
                                          Text(
                                            "+1 4549 49746 487",
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontFamily: 'Gilroy Medium',
                                                fontSize: height / 60),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const Divider(
                                thickness: 0.2,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height / 40,
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
}
