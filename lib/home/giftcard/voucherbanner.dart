import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gobank/home/giftcard/giftofferform.dart';
import 'package:gobank/utils/media.dart';

class voucherbanner extends StatefulWidget {
  const voucherbanner({Key? key}) : super(key: key);

  @override
  State<voucherbanner> createState() => _voucherbannerState();
}

class _voucherbannerState extends State<voucherbanner> {
 late ScrollController _scrollController;
  int _currentPage = 0;
  List color=[
    const Color.fromARGB(255, 108, 226, 155),
    const Color.fromARGB(255, 120, 185, 238),
    const Color.fromARGB(255, 236, 201, 96),
  ];
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    setState(() {
      _currentPage = (_scrollController.offset / 270).round();  //140  // below width when put then less -30 here
    });
  }
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: SizedBox(
       
        height: 190,
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('buying_voucher_banner')
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            List<QueryDocumentSnapshot> documents = snapshot.data!.docs;
           // _currentPage = _currentPage.clamp(0, documents.length.toDouble() - 1).toInt();

            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      controller: _scrollController,
                      itemCount: documents.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot document = documents[index];
                        String bannerimgurl = document['bannerimgurl'];
                        String description =document['description'];
                        String discountdescription =document['discountdescription'];
                        String discountpercent=document['discountpercent'];
                        String imgurl=document['imgurl'];
                        String storename=document['storename'];
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child:  GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => giftofferform(
                                icon:imgurl,storename:storename,discount:discountpercent
                              ),));
                            },
                            child: Container(
                            width: 300,
                                                   // height: 160,
                            decoration: BoxDecoration(
                              color: color[index],
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15.0),
                              child: Stack(
                                children: [
                                    Positioned(
                                    bottom: 0,
                                    right: 0,
                                    child: Container(
                                      height: 120,
                                      width: 120,
                                      decoration:const BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(15.0),
                                        ),
                                      ),
                                      child: Image.network(bannerimgurl),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 20,left: 20,right: 10,bottom: 20),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            SizedBox(
                                              height: 30,
                                              child: Image.network(
                                                imgurl,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            Text(
                                              storename,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: height / 40,
                                                fontFamily: 'Gilroy bold'),
                                            ),
                                          ],
                                        ),
                                       // SizedBox(height: 3,),
                                         Text(
                                              '$discountpercent%',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: height / 25,
                                                fontFamily: 'Gilroy bold'),
                                            ),
                                           // SizedBox(height: 2,),
                                         Text(
                                              discountdescription,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: height / 25,
                                                fontFamily: 'Gilroy bold'),
                                            ),
                                            Text(
                                              description,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: height / 45,
                                                fontFamily: 'Gilroy bold'),
                                            ),
                                      ],
                                    ),
                                  )
                                ],
                              )
                            ),
                                                  ),
                          ),
                        );
                      },
                    )
                ),
                const SizedBox(
                  height: 20,
                ),
                
                Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List<Widget>.generate(documents.length, (int index) {
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 3.0),
                    height: 7.0,
                    width: _currentPage == index ? 7.0 : 7.0,
                    decoration: BoxDecoration(
                      color: _currentPage == index ? Colors.white : Colors.grey,
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  );
                }
                ),
                )
              ],
            );
          },
        ),
      ),
    );
  }

}

 //   Container(
                        //   width: 320,
                        //   height: 160,
                        //   decoration: BoxDecoration(
                        //     color: Colors.blue[200],
                        //     borderRadius: BorderRadius.circular(15.0),
                        //   ),
                        //   child: ClipRRect(
                        //     borderRadius: BorderRadius.circular(15.0),
                        //     child: Stack(
                        //       children: [
                        //           Positioned(
                        //           bottom: 0,
                        //           right: 0,
                        //           child: Container(
                        //             height: 120,
                        //             width: 120,
                        //             decoration:const BoxDecoration(
                        //               borderRadius: BorderRadius.only(
                        //                 topLeft: Radius.circular(15.0),
                        //               ),
                        //             ),
                        //             child: Image.asset("asset/images/pizza.png"),
                        //           ),
                        //         ),
                        //         Padding(
                        //           padding: const EdgeInsets.only(top: 20,left: 20,right: 10,bottom: 20),
                        //           child: Column(
                        //             crossAxisAlignment: CrossAxisAlignment.start,
                        //             children: [
                        //               Row(
                        //                 children: [
                        //                   SizedBox(
                        //                     height: 30,
                        //                     child: Image.asset(
                        //                       "asset/images/dominos-pizza.png",
                        //                       fit: BoxFit.cover,
                        //                     ),
                        //                   ),
                        //                   Text(
                        //                     "Domino's",
                        //                   style: TextStyle(
                        //                       color: Colors.white,
                        //                       fontSize: height / 40,
                        //                       fontFamily: 'Gilroy bold'),
                        //                   ),
                        //                 ],
                        //               ),
                        //              // SizedBox(height: 3,),
                        //                Text(
                        //                     "10%",
                        //                   style: TextStyle(
                        //                       color: Colors.white,
                        //                       fontSize: height / 25,
                        //                       fontFamily: 'Gilroy bold'),
                        //                   ),
                        //                  // SizedBox(height: 2,),
                        //                Text(
                        //                     "Discount",
                        //                   style: TextStyle(
                        //                       color: Colors.white,
                        //                       fontSize: height / 25,
                        //                       fontFamily: 'Gilroy bold'),
                        //                   ),
                        //                   Text(
                        //                     "pizza party is on us!",
                        //                   style: TextStyle(
                        //                       color: Colors.black,
                        //                       fontSize: height / 45,
                        //                       fontFamily: 'Gilroy bold'),
                        //                   ),
                        //             ],
                        //           ),
                        //         )
                        //       ],
                        //     )
                        //   ),
                        // ),