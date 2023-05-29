import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../utils/colornotifire.dart';
import '../utils/media.dart';
import '../utils/string.dart';

class ChatRound extends StatefulWidget {
  const ChatRound({Key? key}) : super(key: key);

  @override
  State<ChatRound> createState() => _ChatRoundState();
}

class _ChatRoundState extends State<ChatRound> {
  late List<GDPData> _chartData;
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

  List historyimg = [
    "images/starbuckscoffee.png",
    "images/spotify.png",
    "images/netflix.png"
  ];
  List recentcolor = [
    Colors.green,
    Colors.red,
    Colors.red,
  ];
  List recentamount = [
    "+\$24.000","-\$64.000","-\$21.000"
  ];
  List recentname = [CustomStrings.starbuckscoffee,CustomStrings.spotifypremium,CustomStrings.spotifypremium];
  @override
  void initState() {
    _chartData = getChartData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    notifire = Provider.of<ColorNotifire>(context, listen: true);
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: height / 40,
            ),
            Row(
              children: [
                Container(
                  height: height / 12,
                  width: width / 2.5,
                  decoration: BoxDecoration(
                    color: notifire.getpurplcolor,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: width / 40),
                    child: Row(
                      children: [
                        Image.asset(
                          "images/income.png",
                          height: height / 20,
                        ),
                        SizedBox(
                          width: width / 80,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: height / 80,
                            ),
                            Text(
                              CustomStrings.income,
                              style: TextStyle(
                                  color: notifire.getdarkgreycolor,
                                  fontSize: height / 60,
                                  fontFamily: 'Gilroy Medium'),
                            ),
                            SizedBox(
                              height: height / 100,
                            ),
                            Text(
                              "\$1.000.000",
                              style: TextStyle(
                                  color: notifire.getdarkscolor,
                                  fontSize: height / 60,
                                  fontFamily: 'Gilroy Bold'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const Spacer(),
                Container(
                  height: height / 12,
                  width: width / 2.5,
                  decoration: BoxDecoration(
                    color: notifire.getpurplcolor,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: width / 40),
                    child: Row(
                      children: [
                        Image.asset(
                          "images/outcome.png",
                          height: height / 20,
                        ),
                        SizedBox(
                          width: width / 80,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: height / 80,
                            ),
                            Text(
                              CustomStrings.outcome,
                              style: TextStyle(
                                  color: notifire.getdarkgreycolor,
                                  fontSize: height / 60,
                                  fontFamily: 'Gilroy Medium'),
                            ),
                            SizedBox(
                              height: height / 100,
                            ),
                            Text(
                              "\$1.000.000",
                              style: TextStyle(
                                  color: notifire.getdarkscolor,
                                  fontSize: height / 60,
                                  fontFamily: 'Gilroy Bold'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            SfCircularChart(
              series: <CircularSeries>[
                DoughnutSeries<GDPData, String>(
                  dataSource: _chartData,
                  xValueMapper: (GDPData data, _) => data.continent,
                  yValueMapper: (GDPData data, _) => data.gdp,
                  pointColorMapper: (GDPData data, _) => data.color,
                  dataLabelSettings: const DataLabelSettings(isVisible: true),
                  enableTooltip: true,
                ),
              ],
            ),
            SizedBox(
              height: height / 60,
            ),
            Row(
              children: [
                Text(
                  CustomStrings.recent,
                  style: TextStyle(
                      color: notifire.getdarkscolor,
                      fontFamily: 'Gilroy Bold',
                      fontSize: height / 50),
                ),
              ],
            ),
            SizedBox(
              height: height / 60,
            ),
            Container(
              height: height / 3.6,
              color: Colors.transparent,
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                itemBuilder: (context, index) => Padding(
                  padding: EdgeInsets.only(bottom: height / 80),
                  child: Container(
                    height: height / 12,
                    width: width,
                    decoration: BoxDecoration(
                      color: notifire.getdarkwhitecolor,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                      border: Border.all(color: Colors.grey.withOpacity(0.3),),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: width / 30),
                      child: Row(
                        children: [
                          Image.asset(
                            historyimg[index],
                            height: height / 25,
                          ),
                          SizedBox(
                            width: width / 30,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: height / 60,
                              ),
                              Text(
                                recentname[index],
                                style: TextStyle(
                                    color: notifire.getdarkscolor,
                                    fontFamily: 'Gilroy Bold',
                                    fontSize: height / 50),
                              ),
                              SizedBox(
                                height: height / 300,
                              ),
                              Text(
                                CustomStrings.octnov,
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontFamily: 'Gilroy Medium',
                                    fontSize: height / 60),
                              ),
                            ],
                          ),
                          const Spacer(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              SizedBox(
                                height: height / 60,
                              ),
                              Text(
                                recentamount[index],
                                style: TextStyle(
                                    color: recentcolor[index],
                                    fontFamily: 'Gilroy Bold',
                                    fontSize: height / 50),
                              ),
                              SizedBox(
                                height: height / 300,
                              ),
                              Text(
                                "Order ID: ***ase21",
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
              ),
            ),
            SizedBox(
              height: height / 10,
            ),
          ],
        ),
      ),
    );
  }

  List<GDPData> getChartData() {
    final List<GDPData> chartData = [
      GDPData(
        'abc',
        24,
        const Color(0xff309EFF),
      ),
      GDPData(
        'abc',
        64,
        const Color(0xff6DC12C),
      ),
      GDPData(
        'abc',
        45,
        const Color(0xffFF4A32),
      ),
    ];
    return chartData;
  }
}

class GDPData {
  GDPData(this.continent, this.gdp, this.color);

  final String continent;
  final int gdp;
  final Color color;
}
