import 'package:flutter/material.dart';
import 'package:gobank/utils/media.dart';

class DiscountedBar extends StatelessWidget {
  const DiscountedBar({Key? key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      padding: const EdgeInsets.all(10),
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.all(10),
            child: Container(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 62, 64, 64),
                borderRadius: BorderRadius.circular(9),
              ),
              height: screenWidth * 0.22,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(60),
                      bottomRight: Radius.circular(60),
                    ),
                    child: Container(
                      width: screenWidth * 0.14,
                      color: Color.fromARGB(255, 106, 113, 119),
                      child: Center(
                        child: Image.asset(
                          'card.png',
                          width: screenWidth * 0.1,
                          height: screenWidth * 0.1,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.only(top: 0, right: 100),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "SlingCard for just",
                                style: TextStyle(
                                  fontFamily: "Gilroy medium",
                                    color: Colors.white,
                                    fontSize: height / 45),
                              ),
                              Text(
                                "\u{20B9}199",
                                style: TextStyle(
                                  fontFamily: "Gilroy medium",
                                    color: Colors.amber,
                                    fontSize: height / 40),
                                
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: Text(
                              "\u{20B9}399",
                              style: TextStyle(
                                  fontFamily: "Gilroy medium",
                                    color: Colors.white,
                                    fontSize: height / 40,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 0,
            right: 10,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(6),
              ),
              width: screenWidth * 0.25,
              height: screenWidth * 0.05,
              child:  Center(
                child: Text("Limited Period",style: TextStyle(
                                  fontFamily: "Gilroy medium",
                                    color: Colors.black,
                                    fontSize: height / 50,),
                        ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
