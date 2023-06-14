import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class sling_storebannerpage extends StatefulWidget {
  const sling_storebannerpage({Key? key}) : super(key: key);

  @override
  State<sling_storebannerpage> createState() => _sling_storebannerpageState();
}

class _sling_storebannerpageState extends State<sling_storebannerpage> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: SizedBox(
        height: 200,
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('sling_store_banner')
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            List<QueryDocumentSnapshot> documents = snapshot.data!.docs;
            _currentPage = _currentPage.clamp(0, documents.length.toDouble() - 1).toInt();

            return Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: documents.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot document = documents[index];
                      String imageUrl = document['imageUrl'];
                      print(imageUrl);
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        child: Container(
                          //width: 350,
                         // height: 180,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Image.network(
                              imageUrl,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      );
                        //return Padding(
                        //   padding: EdgeInsets.symmetric(horizontal: 20.0),
                        //   child: Container(
                        //     width: 350,
                        //     height: 200,
                        //     decoration: BoxDecoration(
                        //       borderRadius: BorderRadius.circular(10.0),
                        //     ),
                        //     child: ClipRRect(
                        //       borderRadius: BorderRadius.circular(10.0),
                        //       child: CachedNetworkImage(
                        //         imageUrl: imageUrl,
                        //         fit: BoxFit.cover,
                        //         progressIndicatorBuilder: (context, url, downloadProgress) {
                        //           return Center(
                        //             child: CircularProgressIndicator(
                        //               value: downloadProgress.progress,
                        //             ),
                        //           );
                        //         },
                        //         errorWidget: (context, url, error) => Icon(Icons.error),
                        //       ),
                        //     ),
                        //   ),
                        // );

                    },
                    onPageChanged: (int index) {
                      setState(() {
                        _currentPage = index.toInt();
                      });
                    },
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                DotsIndicator(
                  dotsCount: documents.length,
                  position: _currentPage.toInt(),
                  decorator:  DotsDecorator(
                    color: Colors.grey,
                    activeColor: Colors.white ,
                    spacing: EdgeInsets.all(3.0),
                     size:  Size.square(5.0),
                    activeSize: const Size(8.0, 7.0),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
