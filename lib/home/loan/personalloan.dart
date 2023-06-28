import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gobank/home/loan/personalloan_form.dart';
import 'package:gobank/utils/colornotifire.dart';
import 'package:gobank/utils/media.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class personalloan extends StatefulWidget {
  const personalloan({Key? key}) : super(key: key);

  @override
  State<personalloan> createState() => _personalloanState();
}

class _personalloanState extends State<personalloan> {
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
  List loanicon=[
    "images/paperless.png",
    "images/smiling-face.png",
    "images/paymentsuccess.png",
    "images/calendar_loan.png"
  ];
  List loandetails=[
    "100%\nPaperless",
    "Collateral\nFree",
    "Affordable\nEMIs",
    "Flexible\nTenure"
  ];
  @override
  Widget build(BuildContext context) {
    notifire = Provider.of<ColorNotifire>(context, listen: true);
    return Scaffold(
     body: Column(
      children: [
        Expanded(
          flex: 1,
          child: Container(
            child: Padding(
              padding: const EdgeInsets.only(top: 25,bottom: 5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(Icons.arrow_back)),
                        SizedBox(
                        
                          child: Row(
                            children: [
                             const CircleAvatar(
                                radius: 20,
                                backgroundColor: Colors.blue,
                                child: CircleAvatar(
                                  radius: 16,
                                  backgroundColor: Color.fromARGB(255, 3, 17, 91),
                                  child: Icon(Icons.currency_rupee,color: Colors.white,size: 20,),
                                ),
                              ),
                              SizedBox(width: 5,),
                              Text("Personal\nLoan",
                              overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: notifire.getdarkscolor,
                                  fontSize: height / 40,
                                  fontFamily: 'Gilroy bold'),
                               ),
                            ],
                          ),
                        ),
                        SizedBox()
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Text("Fulfill all your wishes with an Instant",
                          style: TextStyle(
                                    color: notifire.getdarkscolor,
                                    fontSize: height / 42,
                                    fontFamily: 'Gilroy bold'),
                          ),
                          Text("Loan",
                           style: TextStyle(
                                color: notifire.getdarkscolor,
                                fontSize: height / 42,
                                fontFamily: 'Gilroy bold'),
                             ),
                    ],
                  ),
                  
                ],
              ),
            ),
             )
            ),
        Expanded(
          flex: 2,
          child: Container(
            color: Colors.grey[100],
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xff2C62DC),
                  borderRadius: BorderRadius.circular(15)
                  ),
                  child:  Stack(
                      children: [
                         const Padding(
                          padding:  EdgeInsets.only(top: 50,left: 40),
                          child:  CircleAvatar(
                            radius: 30,
                            backgroundImage: AssetImage("images/rupee_loan.png")
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Column(
                            
                            children: [
                              Center(
                                child: Text("Get up to",
                                                           style: TextStyle(
                                    color: notifire.getdarkwhitecolor,
                                    fontSize: height / 35,
                                    fontFamily: 'Gilroy bold'),
                                 ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color.fromARGB(255, 26, 128, 171).withOpacity(0.2),
                                      offset: Offset(0, 2),
                                      blurRadius: 4,
                                    ),
                                  ],
                                ),
                                child: Text(
                                  "45 Lakh",
                                  style: TextStyle(
                                    color: notifire.getdarkwhitecolor,
                                    fontSize: height / 10,
                                    fontFamily: 'Gilroy bold',
                                  ),
                                ),
                              ),
                               Text("in just 2 Minutes",
                                                          style: TextStyle(
                                   color: notifire.getdarkwhitecolor,
                                   fontSize: height / 35,
                                   fontFamily: 'Gilroy bold'),
                                ),
                            
                            Padding(
                                padding: const EdgeInsets.only(left: 20, right: 20),
                                child: Center(
                                  child: GridView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: loanicon.length,
                                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      childAspectRatio: 4,
                                      mainAxisSpacing: 10,
                                    ),
                                    itemBuilder: (context, index) {
                                      return loaniondetail(loanicon[index], loandetails[index]);
                                    },
                                  ),
                                ),
                              ),
                            ],
                            
                          ),
                        )
                      ],
                    ),
                  ),
                 ),
               )
            ),
        Expanded(
          flex: 1,
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(),
                  SizedBox(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10,right: 10),
                          child: Container(
                            height: 50,
                            width: width-20,
                            child: OutlinedButton(
                                onPressed: () {
                                  // Add your onPressed logic here
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => personalloan_form(),));
                                },
                                child: Text(
                                  'Get It Now',
                                  style: TextStyle(
                                    color: notifire.getdarkwhitecolor,
                                    fontSize: height / 35,
                                    fontFamily: 'Gilroy bold',
                                  ),
                                ),
                                style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10), // Set a circular border radius
                                        ),
                                      ),
                                    ),
                              ),
                          ),
                        ),
                        SizedBox(height: 5,),
                        SizedBox(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20,right: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                'Loan Provided by',
                                style: TextStyle(
                                  color: notifire.getdarkgreycolor,
                                  fontSize: height / 50,
                                  fontFamily: 'Gilroy medium',
                                ),
                                    ),
                                  
                                SizedBox(
                                  height: 20,
                                  width: 100,
                                  child: Image.asset("asset/images/absli.png"),
                                )
                              ],
                            ),
                          ),
                        ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20,right: 20),
                            child: SizedBox(
                              child: Text(
                                    'Aditya Birla Finance Limited(ABFL)',
                                    style: TextStyle(
                                      color: notifire.getdarkscolor,
                                      fontSize: height / 45,
                                      fontFamily: 'Gilroy bold',
                                    ),
                                        ),
                            ),
                          ),
                        SizedBox(height: 20,),
                      ],
                    ),
                  ),
            
        
                ],
              ),
            ),
          ),
      ],
     ),
    );
  }
  Widget loaniondetail(String loanicon,String loandetails)
  {
    return SizedBox(
                                        child: Row(
                                          children: [
                                            CircleAvatar(
                                              radius: 25,
                                              backgroundColor: Color.fromARGB(255, 195, 239, 237),
                                              child: Image.asset(
                                                loanicon,
                                                height: 30,
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                            SizedBox(width: 10),
                                            Text(
                                              loandetails,
                                              style: TextStyle(
                                                color: notifire.getdarkwhitecolor,
                                                fontSize: height / 45,
                                                fontFamily: 'Gilroy bold',
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
  }
}