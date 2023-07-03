import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gobank/pages/personalise.dart';
import 'package:gobank/pages/priceDiscountedbar.dart';
import 'package:gobank/utils/media.dart';


// ignore: must_be_immutable
class benefit extends StatelessWidget {
 // benefit(this.myColorScheme);
 const benefit({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        // centerTitle: true,
        // title: const Text("Fyp Card"),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios_new_sharp)),
      ),
      body: Container(
        height: h,
        color: Colors.black,
        width: w,
        // padding: EdgeInsets.fromLTRB(w * 0.05, h * 0.05, w * 0.05, h * 0.05),
        child: Column(children: [
          // // ShrinkWrappingViewport(offset: offset)
          // ShrinkWrappingViewport(
          //   offset: ViewportOffset.fixed(1),
          //   slivers: [
          //     disbar(),
          //   ],
          // ),
          const DiscountedBar(),
           Text(
            "Your SlingCard comes with ",
            style: TextStyle(fontFamily: "Gilroy bold",
               color: Colors.white70,
               fontSize: height / 30),
          ),
           Text(
            "great benefits ",
            style: TextStyle(fontFamily: "Gilroy bold",
               color: Colors.white70,
               fontSize: height / 30),
          ),
          SizedBox(
            height: h * 0.5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ListTile(
                  leading: CircleAvatar(
                      backgroundColor: Colors.black87,
                      radius: 50,
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 40,
                        child: CircleAvatar(
                          backgroundColor: Colors.black87,
                          radius: 30,
                          child: Container(
                            width: 50,
                            height: 50,
                            decoration:const  BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: AssetImage('asset/images/card.png'),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  title: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Earn ',
                          style: TextStyle(fontFamily: "Gilroy medium",
                          color: Colors.white70,
                          fontSize: height / 40),
                        ),
                        TextSpan(
                          text: '5X mynts',
                          style: TextStyle(fontFamily: "Gilroy medium",
                          color: Colors.amber,
                          fontSize: height / 40),
                        ),
                        TextSpan(
                          text: ' on both online and offline transactions',
                          style: TextStyle(fontFamily: "Gilroy medium",
                          color: Colors.white70,
                          fontSize: height / 40),
                        ),
                      ],
                    ),
                  ),
                ),
                ListTile(
                  leading: CircleAvatar(
                      backgroundColor: Colors.black87,
                      radius: 50,
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 40,
                        child: CircleAvatar(
                          backgroundColor: Colors.black87,
                          radius: 30,
                          child: Container(
                            width: 50,
                            height: 50,
                            decoration:const  BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: AssetImage('asset/images/card.png'),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  title: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: '10% instant cashback',
                          style: TextStyle(fontFamily: "Gilroy medium",
                          color: Colors.amber,
                          fontSize: height / 40),
                        ),
                        TextSpan(
                          text: ' on top brands',
                          style: TextStyle(fontFamily: "Gilroy medium",
                          color: Colors.white70,
                          fontSize: height / 40),
                        ),
                      ],
                    ),
                  ),
                ),
                ListTile(
                  leading: CircleAvatar(
                      backgroundColor: Colors.black87,
                      radius: 50,
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 40,
                        child: CircleAvatar(
                          backgroundColor: Colors.black87,
                          radius: 30,
                          child: Container(
                            width: 50,
                            height: 50,
                            decoration:const  BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: AssetImage('asset/images/card.png'),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  title: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Get one airport lounge access worth ',
                         style: TextStyle(fontFamily: "Gilroy medium",
                          color: Colors.white70,
                          fontSize: height / 40),
                        ),
                        TextSpan(
                          text: '\u{20B9}1500',
                         style: TextStyle(fontFamily: "Gilroy medium",
                          color: Colors.amber,
                          fontSize: height / 40),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20,),
          SizedBox(
            height: 40,
            width: 320,
            child: OutlinedButton(
              child: Text(
                "continue",
                 style: TextStyle(fontFamily: "Gilroy bold",
                            color: Colors.black,
                            fontSize: height / 40)
              ),
              onPressed: () {
               // Navigator.pushNamed(context, '/per');
               navigator!.push(MaterialPageRoute(builder: (context) => const Personalise(),));
              },
              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all<Color>(Colors.amber),
                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30), // Set a circular border radius
                                  ),
                                ),
                              ),
            ),
          ),
        ]),
      ),
      // body: ,
    );
  }
}
