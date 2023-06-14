import 'package:carousel_indicator/carousel_indicator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gobank/slingsaverclub/offerwidgets.dart';
import 'package:gobank/utils/media.dart';
import 'package:shared_preferences/shared_preferences.dart';



class SliderPage extends StatefulWidget {
  @override
  _SliderPageState createState() => _SliderPageState();
}

class _SliderPageState extends State<SliderPage> {
   late ScrollController _scrollController;
  int _currentPage = 0;
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
      _currentPage = (_scrollController.offset / 295).round(); //140
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('slider').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No data available'));
          }

          final slides = snapshot.data!.docs;

          return Column(
            children: [
              Expanded(
                flex: 1,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  controller: _scrollController,
                  itemCount: slides.length,
                  itemBuilder: (context, index) {
                    final slide = slides[index].data() as Map<String, dynamic>?;
                    activeindexslideroffers = index;

                    if (slide == null) {
                      return SizedBox.shrink();
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
                      return SizedBox.shrink();
                    }

                    return Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 3.0),
                      child: Container(
                       // height: 170,
                        width: 320,
                        margin: EdgeInsets.only(left: index != 0 ? 10.0 : 0.0),
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
                                            color: const Color.fromARGB(255, 112, 91, 116),
                                            fontSize: height / 50,
                                          ),
                                        ),
                                        SizedBox(height: height / 60),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
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
                                        OutlinedButton(
                                          onPressed: () {},
                                          style: OutlinedButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                            backgroundColor: Colors.amber[700],
                                            padding: EdgeInsets.symmetric(
                                              vertical: height * 0.015,
                                              horizontal: width * 0.04,
                                            ),
                                          ),
                                          child: Text(
                                            button!,
                                            style: TextStyle(
                                              fontFamily: "Gilroy Medium",
                                              color: Colors.black,
                                              fontSize: height / 40,
                                            ),
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
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List<Widget>.generate(slides.length, (int index) {
                  return AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    margin: EdgeInsets.symmetric(horizontal: 3.0),
                    height: 7.0,
                    width: _currentPage == index ? 7.0 : 7.0,
                    decoration: BoxDecoration(
                      color: _currentPage == index ? Colors.blue  : Colors.grey,
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  );
                }),
              ),
            ],
          );
        },
      ),
    );
  }
}
