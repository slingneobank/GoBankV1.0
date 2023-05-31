import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:gobank/home/home.dart';
import 'package:gobank/home/home_ctrl.dart';
import 'package:gobank/home/savings/savings.dart';
import 'package:gobank/home/savings/unor_list.dart';
import 'package:gobank/utils/media.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toggle_switch/toggle_switch.dart';

class UpgradePlan extends StatefulWidget {
  const UpgradePlan({Key? key}) : super(key: key);

  @override
  State<UpgradePlan> createState() => _UpgradePlanState();
}

class _UpgradePlanState extends State<UpgradePlan> {
  int toggle_value = 0;
  final homeCtrl = Get.find<HomeCtrl>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    toggle_value = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: InkWell(
            onTap: () => Get.back(),
            child: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.black,
            ),
          ),
        ),
        title: Text(
          "Upgrade Your Plan",
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
              color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500),
        ),
      ),
      body: Stack(
        children: [
          ListView(
            children: [
              SizedBox(
                height: height / 40,
              ),
              Center(
                child: ToggleSwitch(
                  minWidth: width - 100,
                  minHeight: 50.0,
                  initialLabelIndex: 0,
                  cornerRadius: 10.0,
                  activeFgColor: Colors.white,
                  inactiveBgColor: Colors.grey.shade300,
                  inactiveFgColor: Colors.grey.shade600,
                  totalSwitches: 2,
                  labels: ['Lite', 'Premium'],
                  icons: [Icons.light_mode, Icons.star],
                  iconSize: 30.0,
                  // borderWidth: 5.0,
                  borderColor: [Colors.grey.shade400],
                  activeBgColors: [
                    [Colors.blue.shade200],
                    [Colors.orange.shade200]
                  ],
                  onToggle: (index) {
                    debugPrint('switched to: $index');
                    toggle_value = index ?? 0;
                    homeCtrl.update(['upgradePlanDataId']);
                  },
                ),
              ),
              SizedBox(
                height: height / 40,
              ),
              GetBuilder<HomeCtrl>(
                  id: 'upgradePlanDataId',
                  builder: (_) {
                    return Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Container(
                        height: height / 1.4,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  toggle_value == 0 ? "Lite" : "Premium",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.poppins(
                                      color: Colors.black,
                                      fontSize: 24,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  toggle_value == 0 ? "Free" : "\u{20B9}100",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.poppins(
                                      color: Colors.black,
                                      fontSize: 24,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                            Divider(
                              color: Colors.black,
                            ),
                            toggle_value == 0
                                ? UnorderedList([
                                    "Virtual Debit Card on the App",
                                    "Order Physical Debit Card",
                                    "Core Financial Tools to save, spend and manage money",
                                    "Monthly Spend Limit: 1000",
                                    "Annual Spend Limit: 1,00,000",
                                    "Finance concepts made fun with interactive learning modules",
                                    "Insights into all your spends",
                                    "Annual Interest from parents to reward your savings"
                                  ])
                                : UnorderedList([
                                    "Investment Feature to invest in 1500+ stocks and ETFs independently",
                                    "Annual Interest Rewards of 6% on your saving balance paid on monthly ",
                                    "Get 1% cashback on all spends using Fyp card upto † 100 monthly",
                                    "Free Full KYC Upgrade with doorstep agent verification",
                                    "Advanced Financial Education interactive modules ",
                                    "Finance concepts made fun with interactive learning modules",
                                    "Monthly Cost is less than 1/4th of your favourite pizza! "
                                  ])
                          ]),
                        ),
                        // A text widget with some style and the index of the container
                      ),
                    );
                  }),
            ],
          ),
          GetBuilder<HomeCtrl>(
              id: "upgradePlanDataId",
              builder: (_) {
                if (true) {
                  return Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: 15, right: 15, bottom: height / 40),
                        child: InkWell(
                          onTap: () async {
                            if (toggle_value == 0) {
                              Get.to(() => Savings());
                            } else {
                              await homeCtrl.razorpayCheckout(
                                  context, 100, "Upgrading To Premium Plan");
                            }
                          },
                          child: Container(
                            // width: width / 1.2,
                            height: height / 17,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: toggle_value == 1
                                    ? Colors.orange.shade300
                                    : Colors.blue.shade200),
                            child: Center(
                              child: Text(
                                toggle_value == 1 ? "Upgrade Plan" : "Continue",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        ),
                      ));
                } else {
                  return SizedBox();
                }
              })
        ],
      ),
    );
  }
}
