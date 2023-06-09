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
              print(snapshot.data!.docs.length);
              return Text('No data available');
               // Show a message when there is no data
            }

            final slides = snapshot.data!.docs; // Retrieve the documents from the snapshot

            // Rest of your code to display the slides

          print(slides.length);
          return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: slides.length,
              itemBuilder: (context, index) {
                final slide = slides[index].data() as Map<String, dynamic>?;

                if (slide == null) {
                  return SizedBox.shrink(
                    child: Text("data null"),
                  );
                }

                final title = slide['title'] as String?;
                final description = slide['description'] as String?;
                final description2 = slide['description2'] as String?;
                final imageURL = slide['imageURL'] as String?;

                if (title == null || description == null || description2 == null ||imageURL == null) {
                  return SizedBox.shrink(
                    child: Text("null"),
                  );
                }

                return Container(
                height: 170,
                width: width-30,
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
                            padding: const EdgeInsets.only(top: 15,left: 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                  Text(
                                    title,
                                    style: TextStyle(
                                        fontFamily: "Gilroy Medium",
                                        color: Colors.purple[100],
                                        fontSize: height / 50),
                                  ),
                                  SizedBox(height:height/60,),
                                  Text(
                                    description,
                                    style: TextStyle(
                                        fontFamily: "Gilroy Bold",
                                        color: Colors.purple[50],
                                        fontSize: height / 35),
                                  ),
                                  Text(
                                    description2,
                                    style: TextStyle(
                                        fontFamily: "Gilroy Bold",
                                        color: Colors.purple[50],
                                        fontSize: height / 35),
                                  ),
                                  SizedBox(height:height/40,),
                                  OutlinedButton(
                                    onPressed: () {
                                    
                                  }, 
                                  style: OutlinedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      ),
                                    backgroundColor: Colors.amber[700],
                                    padding: EdgeInsets.symmetric(vertical: 13,horizontal: 18),
                                    ),
                                  child: Text(
                                    'Start Learning',
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
                          padding: const EdgeInsets.only(top: 5,bottom: 5),
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