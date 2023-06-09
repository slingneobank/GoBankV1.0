import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gobank/slingsaverclub/offerwidgets.dart';

import '../utils/media.dart';
class slingsaverclubcontainer extends StatefulWidget {
  const slingsaverclubcontainer({Key? key}) : super(key: key);

  @override
  State<slingsaverclubcontainer> createState() => _slingsaverclubcontainerState();
}

class _slingsaverclubcontainerState extends State<slingsaverclubcontainer> {
  @override
  Widget build(BuildContext context) {
    
   return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('sling_saver').snapshots(),
        builder: (context, snapshot) {
            // if (snapshot.connectionState == ConnectionState.waiting) {
            //   return CircularProgressIndicator(); // Show a loading indicator while waiting for data
            // }

            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
             // print(snapshot.data!.docs.length);
              return Text('No data available');
               // Show a message when there is no data
            }

            final slides = snapshot.data!.docs; // Retrieve the documents from the snapshot

            // Rest of your code to display the slides
          containerindicator.clear();
          containerindicator.addAll(slides);
          print(slides.length);
          
          
          return Container(
            color: Colors.black87,
           
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: slides.length,
                itemBuilder: (context, index) {
                  final slide = slides[index].data() as Map<String, dynamic>?;
                  activecontainerindex=index;
                  if (slide == null) {
                    
                    return SizedBox.shrink(
                      child: Text("data null"),
                    );
                  }
            
                  final title = slide['title'] as String?;
                  final description = slide['description'] as String?;
            
                  if (title == null || description == null ) {
                    return SizedBox.shrink(
                      child: Text("null"),
                    );
                  }
            
                  return Row(
                    children: [
                      Container(
                      
                      width: 180,
                      
                      child: Card(
                          color: Color.fromARGB(255, 51, 51, 50),
                         shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                          ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(title,
                              style: TextStyle(
                                                      fontFamily: "Gilroy Bold",
                                                      color: const Color.fromARGB(255, 234, 174, 71),
                                                      fontSize: height / 35,),
                              ),
                              Flexible(
                                child: Text(
                                  description,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: "Gilroy Bold",
                                    color: notifire.getdarkwhitecolor,
                                    fontSize: height / 45,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                ),
                SizedBox(width: 20,)
                    ],
                  );
                },
                
              ),
          );
        },
        
      ),
    );
  }
}