import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/media.dart';
import 'benefit.dart';
import 'priceDiscountedbar.dart';

class physicalcard extends StatelessWidget {
  

  const physicalcard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    const appBarHeight = kToolbarHeight;

    return Scaffold(
      appBar: AppBar(
        backgroundColor:Colors.black87,
        centerTitle: true,
        title: const Text("SlingCard"),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Container(
        color: Colors.black,
        child: Column(
          children: [
            SizedBox(
              height: h * 0.55 - appBarHeight,
              //color: Colors.red, // Replace with your desired color
              
              child: Image.asset("asset/images/card.png",fit: BoxFit.fill,),
            ),
            SizedBox(
              height: h * 0.34,
              child: Column(
                children: [
                  SizedBox(
                    height: (h * 0.34) * 0.5,
                    width: double.infinity,
                    child: const DiscountedBar(),
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: (h * 0.34) * 0.5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: h * 0.06,
                          width: 250,
                          child: OutlinedButton(
                            onPressed: () {
                              //Navigator.pushNamed(context, '/benefit');
                              Navigator.pop(context);
                              navigator!.push(MaterialPageRoute(builder: (context) => const benefit(),));
                            },
                             style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(Colors.amber),
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30), // Set a circular border radius
                                ),
                              ),
                            ),
                          child:  Text(
                              "Order Card",
                              style: TextStyle(fontFamily: "Gilroy medium",
                                      color: Colors.black,
                                      fontSize: height / 45),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10,),
                        TextButton(
                          onPressed: () {},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.label_off,color: Colors.amber),
                              Text(
                                "Have a promo code? Click here",
                                style: TextStyle(fontFamily: "Gilroy Bold",
                                      color: Colors.white,
                                      fontSize: height / 45),
                              ),
                            ],
                          ),
                        ),
                        
                        Text("Already have a Physical Card?",
                        style: TextStyle(fontFamily: "Gilroy medium",
                                      color: Colors.white,
                                      fontSize: height / 55),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
