import 'package:carousel_indicator/carousel_indicator.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:gobank/home/home.dart';
import 'package:gobank/slingsaverclub/slingsaverclubcontainer.dart';
import 'package:gobank/utils/colornotifire.dart';
import 'package:gobank/utils/media.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:lottie/lottie.dart';
late ColorNotifire notifire;
class offer1widget extends StatefulWidget {
  const offer1widget({Key? key}) : super(key: key);

  @override
  State<offer1widget> createState() => _offer1widgetState();
}

class _offer1widgetState extends State<offer1widget> {

   getdarkmodepreviousstate() async {
    final prefs = await SharedPreferences.getInstance();
    bool? previusstate = prefs.getBool("setIsDark");
    if (previusstate == null) {
      notifire.setIsDark = false;
    } else {
      notifire.setIsDark = previusstate;
    }
  }
 
  final FirebaseStorage storage = FirebaseStorage.instance;
  final String folderPath = 'sling_saver_offers'; // Path to your Firebase Storage folder
  List<String> imageUrls = [];
  bool flag=false;

   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchImageUrls();
    
  }
          Future<void> fetchImageUrls() async {
          imageUrls = await getImageUrls(); // Wait for the asynchronous operation to complete
          print(imageUrls.length); 
          setState(() {
            
          });
          } 
          Future<List<String>> getImageUrls() async {

          try {
            final Reference ref = storage.ref().child(folderPath);
            final ListResult result = await ref.listAll();

            if (result.items.isNotEmpty) {
              for (final Reference imageRef in result.items) {
                final String downloadUrl = await imageRef.getDownloadURL();
                imageUrls.add(downloadUrl);
                setState(() {
                  
                });
                print(imageUrls);

              }
              flag=true;
              setState(() {
                
              });
            } else {
              print('No images found in the specified folder.');
            }
          } catch (e) {
            print('Error getting image URLs: $e');
          }

          return imageUrls;
        }

  @override
  Widget build(BuildContext context) {
    notifire = Provider.of<ColorNotifire>(context, listen: true);
    return Scaffold(
      body: Container(
       // decoration: BoxDecoration(color: Colors.black87),
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                 decoration: BoxDecoration(color: Colors.black87),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10,right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                             GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: SizedBox(
                      child: Row(
                        children: [
                          Icon(
                            Icons.arrow_back_ios_new,
                            size: 20,
                            color: notifire.getdarkwhitecolor,
                          ),
                          Text(
                            "Back",
                            style: TextStyle(
                             
                              fontFamily: "Gilroy Bold",
                              color: notifire.getdarkwhitecolor,
                              fontSize: height / 40,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                              
                             Text("Sling Store",
                                       style: TextStyle(
                                                fontFamily: "Gilroy Bold",
                                                color: notifire.getdarkwhitecolor,
                                                fontSize: height / 40,),
                                       ),
                            
                                        Center(
                                          child: Text("My Orders",
                                                                           style: TextStyle(
                                                  fontFamily: "Gilroy Medium",
                                                  color: notifire.getdarkwhitecolor,
                                                  fontSize: height / 40,),
                                                                           ),
                                        ),
                                        
                            ],
                          ),
                ),
              )),
             Expanded(
              flex: 6,
               child: SingleChildScrollView(
                  child: Container(
                    decoration: BoxDecoration(color: Colors.black87),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child:  Column(
                        children: [
                          
                           Column(
                            children: [
                              Padding(
                               padding: const EdgeInsets.only(right: 10),
                               child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    height: 30,
                                    width: 170,
                                    decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 51, 51, 50),
                                      borderRadius: BorderRadius.circular(20),
                                      
                                      ),
                                      child: Center(
                                        child: Text("My Vouchers",
                                               style: TextStyle(
                                                        fontFamily: "Gilroy Medium",
                                                        color: notifire.getdarkwhitecolor,
                                                        fontSize: height / 40,),
                                               ),
                                      ),
                                  )
                                ],
                               ),
                                           ),
                                           SizedBox(
                              
                              height: 150,
                              child:  Lottie.asset('asset/animation/offer1.json'),
                                           ),
                                           Container(
                              height: 100,
                              width: 350,
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 239, 185, 188),
                                borderRadius: BorderRadius.circular(20)
                              ),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("Be Smart with your money",
                                                     style: TextStyle(
                                                              fontFamily: "Gilroy Bold",
                                                              color: notifire.getdarkscolor,
                                                              fontSize: height / 30,),
                                                     ),
                                    Text("Start Saving",
                                                     style: TextStyle(
                                                              fontFamily: "Gilroy Bold",
                                                              color: Color.fromARGB(255, 194, 80, 80),
                                                              fontSize: height / 25,),
                                                     ),
                                  ],
                                ),
                              ),  
                                           ),
                                           SizedBox(height: 20,),
                                          Container(
                              height: 90,
                              //decoration: BoxDecoration(color: Color.fromARGB(255, 51, 51, 50)),
                              child: slingsaverclubcontainer(),),
                                SizedBox(height: 20,),
                                if (containerindicator.isNotEmpty)
                                 Container(
                                    child: CarouselIndicator(
                                      count: containerindicator.length,
                                      index: activecontainerindex,
                                      color: Color.fromARGB(255, 51, 51, 50),
                                      activeColor: notifire.getdarkwhitecolor,
                                      space: 5,
                                      width: 5,
                                      height: 4,
                                    ),
                                  ),
                            SizedBox(height: 20,),
                            Container(
                              height: 50,
                              width: width-40,
                                decoration: BoxDecoration(
                                  border: Border.all(color: notifire.getdarkwhitecolor),
                                  borderRadius: BorderRadius.circular(15)
                                ),
                                child: Center(
                                  child: Text(
                                    'Learn More',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: "Gilroy Bold",
                                      color: notifire.getdarkwhitecolor,
                                      fontSize: height / 45,
                                    ),
                                  ),
                                ),
                               ),
                               SizedBox(height: 30,),
                               SizedBox(
                                height: 50,
                                width: width-40,
                                 child: Text(
                                      'Super Saver Brands 😄',
                                      style: TextStyle(
                                        fontFamily: "Gilroy Bold",
                                        color: notifire.getdarkwhitecolor,
                                        fontSize: height / 35,
                                      ),
                                    ),
                               ),
                               Container(
                              height: 200,
                              child: flag
                                  ? CarouselSlider.builder(
                                      itemCount: imageUrls.length,
                                      itemBuilder: (context, index, realIndex) {
                                        return GestureDetector(
                                          onTap: () {
                                            // Navigate to the offer details page
                                          
                                          },
                                          child: Row(
                                            children: [
                                              SizedBox(width: 10),
                                              Container(
                                                width: 140,
                                                height: 200,
                                                decoration: BoxDecoration(
                                                  color: Colors.yellow,
                                                  borderRadius: BorderRadius.circular(10.0),
                                                ),
                                                child: ClipRRect(
                                                  borderRadius: BorderRadius.circular(10.0),
                                                  child: Image.network(
                                                    imageUrls[index],
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width: 10),
                                            ],
                                          ),
                                        );
                                      },
                                      options: CarouselOptions(
                                        height: 200,
                                        enableInfiniteScroll: true,
                                        autoPlay: true,
                                        autoPlayInterval: Duration(seconds: 3),
                                        autoPlayAnimationDuration: Duration(milliseconds: 800),
                                        autoPlayCurve: Curves.easeInOut,
                                        enlargeCenterPage: true,
                                        viewportFraction: 0.5, // Adjust this value to show 2 or 3 images
                                        aspectRatio: 5, // Adjust this value based on your image aspect ratio
                                        onPageChanged: (index, reason) {
                                          setState(() {
                                            activeindexslideroffers = index;
                                          });
                                        },
                                      ),
                                    )
                                  : Center(child: CircularProgressIndicator()),
                                          ),
                         
                            SizedBox(height: 40),
                  
                      if (flag && imageUrls.isNotEmpty) // Conditionally render the CarouselIndicator
                        Container(
                          child: CarouselIndicator(
                            count: imageUrls.length,
                            index: activeindexslideroffers,
                            color: Color.fromARGB(255, 51, 51, 50),
                            activeColor: notifire.getdarkwhitecolor,
                            space: 5,
                            width: 5,
                            height: 4,
                          ),
                        ),
                  
                      SizedBox(
                        height: 40,
                        ),
                                           ],
                                           )
                        ],
                      ),
                    )
                  ),
                ),
             ),
            
          ],
        ),
      ),
    );
  }
}

class offer2widget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Custom UI for the custom widget
    return Container(
      child: Center(child: Text('image details 2')),
    );
  }
}


class offer3widget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Custom UI for the custom widget
    return Container(
      child: Center(child: Text('image details 3')),
    );
  }
}


class offer4widget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Custom UI for the custom widget
    return Container(
      child: Center(child: Text('image details 4')),
    );
  }
}


class offer5widget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Custom UI for the custom widget
    return Container(
      child: Center(child: Text('image details 5')),
    );
  }
}


class offer6widget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Custom UI for the custom widget
    return Container(
      child: Center(child: Text('image details 6')),
    );
  }
}


class offer7widget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Custom UI for the custom widget
    return Container(
      child: Center(child: Text('image details 7')),
    );
  }
}