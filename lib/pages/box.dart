import 'package:flutter/material.dart';
import 'package:gobank/utils/media.dart';

class box extends StatelessWidget {
  const box({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color.fromARGB(255, 0, 0, 0),
          boxShadow: [
            const BoxShadow(
              color: Colors.white,
              blurRadius: 10,
              offset: Offset(0, 0),
            ),
          ],
          border: Border.all(
            color: Colors.black,
            width: 1,
          ),
        ),
        height: 123,
        width: MediaQuery.of(context).size.width * 0.9,
        // color: Colors.black,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 1,
              child: Container(
                  height: 100,
                  width: 100,
                  // color: Colors.grey,
                  child: Center(
                    child: Image.asset(
                      'asset/images/card.png',
                      fit: BoxFit.cover,
                      
                      // width: 100,
                      // height: 100,
                    ),
                  ),
                ),
            ),
              //  const Text("Physical Card"),
               Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    //mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                       Text("Physical Card",
                      style: TextStyle(fontFamily: "Gilroy Bold",
                               color: Colors.white,
                               fontSize: height / 45)),
                       Text("Price - \u{20B9}199",
                       style: TextStyle(fontFamily: "Gilroy Bold",
                               color: Colors.white,
                               fontSize: height / 50)),
                      TextButton(
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: const Size(0, 0),
                          alignment: Alignment.centerLeft,
                        ),
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return Container(
                                height: 400,
                                color: Colors.black,
                                width: double.infinity,
                                padding: const EdgeInsets.all(16),
                                child:  Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      'Price Breakdown',
                                      style: TextStyle(fontFamily: "Gilroy Bold",
                                      color: Colors.white,
                                      fontSize: height / 35)
                                    ),
                                    SizedBox(height: 16),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Physical Card',
                                              style: TextStyle(fontFamily: "Gilroy Bold",
                                                color: Colors.white,
                                                fontSize: height / 45),
                                            ),
                                        Text(
                                          '399.0',
                                          style: TextStyle(fontFamily: "Gilroy Bold",
                                                  color: Colors.white,
                                                  fontSize: height / 40)
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Discount',
                                         style: TextStyle(fontFamily: "Gilroy Bold",
                                                  color: Colors.white,
                                                  fontSize: height / 45),
                                                  ),
                                        Text(
                                          '200.0',
                                           style: TextStyle(fontFamily: "Gilroy Bold",
                                                  color: Colors.white,
                                                  fontSize: height / 40),
                                        ),
                                      ],
                                    ),
                                    Divider(
                                      height: 1,
                                      thickness: 1,
                                      color: Colors.white,
                                    ),
                                    // SizedBox(width: double.infinity,child:,),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Net payable',
                                         style: TextStyle(fontFamily: "Gilroy Bold",
                                                  color: Colors.white,
                                                  fontSize: height / 45),
                                                  ),
                                        Text(
                                          '199.0',
                                           style: TextStyle(fontFamily: "Gilroy Bold",
                                                  color: Colors.white,
                                                  fontSize: height / 40),
                                        ),
                                      ],
                                    ),
                                    Text('Taxes (3036)',
                                     style: TextStyle(fontFamily: "Gilroy Bold",
                                                  color: Colors.white,
                                                  fontSize: height / 45)
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                        child:  Text(
                          'View price breakdown',
                          style: TextStyle(fontFamily: "Gilroy Bold",
                                                  color: Colors.white,
                                                  fontSize: height / 55,
                                                  decoration: TextDecoration.underline,
                                  ),
                        ),
                      )
                    ],
                  ),
                ),
              ),

              
          ],
        ));
  }
}
