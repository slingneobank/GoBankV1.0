import 'package:carousel_indicator/carousel_indicator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gobank/slingsaverclub/offerwidgets.dart';
import 'package:gobank/utils/media.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SliderPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('slider').snapshots(),
        builder: (context, snapshot) {
          // if (snapshot.connectionState == ConnectionState.waiting) {
          //   return CircularProgressIndicator(); // Show a loading indicator while waiting for data
          // }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            // print(snapshot.data!.docs.length);
            return Text('No data available');
            // Show a message when there is no data
          }

          final slides =
              snapshot.data!.docs; // Retrieve the documents from the snapshot

          // Rest of your code to display the slides

          //print(slides.length);
          indicator.clear();
          indicator.addAll(slides);

          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: slides.length,
            itemBuilder: (context, index) {
              final slide = slides[index].data() as Map<String, dynamic>?;
              activeindexslideroffers = index;
              print(activeindexslideroffers);
              if (slide == null) {
                return SizedBox.shrink(
                  child: Text("data null"),
                );
              }

              final title = slide['title'] as String?;
              final description = slide['description'] as String?;
              final description2 = slide['description2'] as String?;
              final imageURL = slide['imageURL'] as String?;
              final button = slide['button'] as String?;

              if (title == null ||
                  description == null ||
                  description2 == null ||
                  imageURL == null) {
                return SizedBox.shrink(
                  child: Text("null"),
                );
              }

              return Container(
                height: 160,
                width: width - 50,
                child: Card(
                  color: Color.fromARGB(255, 59, 8, 68),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 15, left: 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  title,
                                  style: TextStyle(
                                      fontFamily: "Gilroy Medium",
                                      color: const Color.fromARGB(
                                          255, 112, 91, 116),
                                      fontSize: height / 50),
                                ),
                                SizedBox(
                                  height: height / 60,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        description,
                                        style: TextStyle(
                                          fontFamily: "Gilroy Bold",
                                          color: Colors.purple[50],
                                          fontSize: height / 35,
                                        ),
                                      ),
                                      Text(
                                        description2,
                                        style: TextStyle(
                                          fontFamily: "Gilroy Bold",
                                          color: Colors.purple[50],
                                          fontSize: height / 35,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                //SizedBox(height:height/30,),
                                OutlinedButton(
                                  onPressed: () {},
                                  style: OutlinedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    backgroundColor: Colors.amber[700],
                                    padding: EdgeInsets.symmetric(
                                        vertical: height * 0.015,
                                        horizontal: width * 0.04),
                                  ),
                                  child: Text(
                                    button!,
                                    style: TextStyle(
                                        fontFamily: "Gilroy Medium",
                                        color: Colors.black,
                                        fontSize: height / 40),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 5, bottom: 5),
                          child: SizedBox(
                            child: Image.network(imageURL),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
