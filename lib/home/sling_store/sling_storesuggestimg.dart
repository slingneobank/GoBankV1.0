import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gobank/home/sling_store/sling_storewebview.dart';
import 'package:gobank/utils/colornotifire.dart';
import 'package:gobank/utils/media.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';

class sling_storesuggestimg extends StatefulWidget {
  const sling_storesuggestimg({Key? key}) : super(key: key);

  @override
  State<sling_storesuggestimg> createState() => _sling_storesuggestimgState();
}

class _sling_storesuggestimgState extends State<sling_storesuggestimg> {
  late ColorNotifire notifire;
   late ScrollController _scrollController;
  int _currentPage = 0;
   getdarkmodepreviousstate() async {
    final prefs = await SharedPreferences.getInstance();
    bool? previusstate = prefs.getBool("setIsDark");
    if (previusstate == null) {
      notifire.setIsDark = false;
    } else {
      notifire.setIsDark = previusstate;
    }
  }

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
      _currentPage = (_scrollController.offset / 115).round(); //140
    });
  }
  @override
  Widget build(BuildContext context) {
    notifire = Provider.of<ColorNotifire>(context, listen: true);
    return Align(
      alignment: Alignment.topCenter,
      child: SizedBox(
        height: 230,
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('sling_store_suggest')
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
                  child: 
                  documents.length==0?Center(child: CircularProgressIndicator(),):
                  ListView.builder(
                      scrollDirection: Axis.horizontal,
                      controller: _scrollController,
                      itemCount: documents.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot document = documents[index];
                        String imageUrl = document['imageurl'];
                        String icon=document['icon'];
                        String detail=document['detail'];
                        String price=document['price'];
                        String webview=document['webview'];
                        print(imageUrl);
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5.0),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => sling_storewebview(Urllink:webview),));
                            },
                            child: Container(
                              width: 150, // Set the desired width here //170
                              margin: EdgeInsets.only(left: index != 0 ? 10.0 : 0.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: Column(
                                  children: [
                                    Container(
                              decoration:const BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.white,
                                    
                                     Color.fromARGB(255, 233, 212, 150),
                                     ],
                                  begin: Alignment.center,
                                  end: Alignment.bottomCenter,
                                ),
                                borderRadius: BorderRadius.all(Radius.circular(10)
                                ),
                              ),
                              child: Stack(
                                children: [
                                  Container(
                                    height: 180, // Adjust the height as needed
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(10)
                                       ),
                                    ),
                                  ),
                                  Container(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                              height: 20,
                                              width: 30,
                                                child: Image.network(
                                                  icon,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                           Center(
                                             child: Container(
                                              height: 100,
                                              width: 70,
                                                child: Image.network(
                                                  imageUrl,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                           ),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 10,right: 10),
                                            child: Center(
                                              child: SizedBox(
                                                child: Text(
                                                  detail  ,
                                                  overflow: TextOverflow.ellipsis,
                                                  maxLines: 2,
                                                       style: TextStyle(
                                                        fontFamily: "Gilroy medium",
                                                        color: notifire.getdarkscolor,
                                                        fontSize: height / 55,),
                                                        ),
                                              )),
                                          ),
                                        Center(
                                          child: SizedBox(
                                            child: Text(
                                              price,
                                            style: TextStyle(
                                                    fontFamily: "Gilroy Bold",
                                                    color: notifire.getdarkscolor,
                                                    fontSize: height / 50,
                                                  ),
                                              ),
                                          )),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                                    
                                  ],
                                ),
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
