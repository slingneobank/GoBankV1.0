import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:gobank/utils/colornotifire.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BannerPage extends StatefulWidget {
  const BannerPage({Key? key}) : super(key: key);

  @override
  State<BannerPage> createState() => _BannerPageState();
}

class _BannerPageState extends State<BannerPage> {
  PageController _pageController = PageController();
  late ColorNotifire notifire;
  final FirebaseStorage storage = FirebaseStorage.instance;
  final String folderPath = 'Banner_images'; // Path to your Firebase Storage folder
  List<String> imageUrls = [];
  bool flag = false;
  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    fetchImageUrls();
  }

  Future<void> fetchImageUrls() async {
    imageUrls = await getImageUrls();
    print(imageUrls.length);
    setState(() {
      flag = true;
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
          setState(() {});
          print(imageUrls);
        }
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
    return Container(
      height: 160,
      child: flag
          ? PageView.builder(
              controller: _pageController,
              itemCount: imageUrls.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Stack(
                    children: [
                      Container(
                        width: 350,
                        height: 200,
                        decoration: BoxDecoration(
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
                      Positioned(
                        bottom: 10.0,
                        left: 0,
                        right: 0,
                        child: DotsIndicator(
                          dotsCount: imageUrls.length,
                          position: currentPage.toInt(),
                          decorator: DotsDecorator(
                            color: Colors.grey, // Inactive dot color
                            activeColor: Colors.blue, // Active dot color
                            spacing: EdgeInsets.all(3.0),
                            size: const Size.square(7.0),
                            activeSize: const Size(10.0, 8.0),
                            activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
              onPageChanged: (int index) {
                setState(() {
                  currentPage = index;
                });
              },
            )
          : Center(child: CircularProgressIndicator()),
    );
  }
}

// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:dots_indicator/dots_indicator.dart';
// import 'package:gobank/utils/colornotifire.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class BannerPage extends StatefulWidget {
//   const BannerPage({Key? key}) : super(key: key);

//   @override
//   State<BannerPage> createState() => _BannerPageState();
// }

// class _BannerPageState extends State<BannerPage> {
//   PageController _pageController = PageController();
//   late ColorNotifire notifire;
//   final FirebaseStorage storage = FirebaseStorage.instance;
//   final String folderPath = 'Banner_images'; // Path to your Firebase Storage folder
//   List<String> imageUrls = [];
//   bool flag = false;
//   int currentPage = 0;

//   @override
//   void initState() {
//     super.initState();
//     fetchImageUrls();
//   }

//   Future<void> fetchImageUrls() async {
//     imageUrls = await getImageUrls();
//     print(imageUrls.length);
//     setState(() {
//       flag = true;
//     });
//   }

//   Future<List<String>> getImageUrls() async {
//     try {
//       final Reference ref = storage.ref().child(folderPath);
//       final ListResult result = await ref.listAll();

//       if (result.items.isNotEmpty) {
//         for (final Reference imageRef in result.items) {
//           final String downloadUrl = await imageRef.getDownloadURL();
//           imageUrls.add(downloadUrl);
//           setState(() {});
//           print(imageUrls);
//         }
//       } else {
//         print('No images found in the specified folder.');
//       }
//     } catch (e) {
//       print('Error getting image URLs: $e');
//     }

//     return imageUrls;
//   }

//   @override
//   Widget build(BuildContext context) {
//     notifire = Provider.of<ColorNotifire>(context, listen: true);
//     return Container(
//       height: 160,
//       child: flag
//           ? Column(
//               children: [
//                 Expanded(
//                   child: PageView.builder(
//                     controller: _pageController,
//                     itemCount: imageUrls.length,
//                     itemBuilder: (BuildContext context, int index) {
//                       return Padding(
//                         padding: EdgeInsets.symmetric(horizontal: 20.0),
//                         child: GestureDetector(
//                           onTap: () {
//                             // Navigate to the offer details page
//                           },
//                           child: Container(
//                             width: 350,
//                             //height: 100,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(10.0),
//                             ),
//                             child: ClipRRect(
//                               borderRadius: BorderRadius.circular(10.0),
//                               child: Image.network(
//                                 imageUrls[index],
//                                 fit: BoxFit.cover,
//                               ),
//                             ),
//                           ),
//                         ),
//                       );
//                     },
//                     onPageChanged: (int index) {
//                       setState(() {
//                         currentPage = index;
//                       });
//                     },
//                   ),
//                 ),
//                 DotsIndicator(
//                   dotsCount: imageUrls.length,
//                   position: currentPage.toInt(),
//                   decorator: DotsDecorator(
//                     color: Colors.amber, // Inactive dot color
//                     activeColor: Colors.orange, // Active dot color
//                     spacing: EdgeInsets.all(2.0),
//                     size: const Size.square(5.0),
//                     activeSize: const Size(7.0, 7.0),
//                     activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
//                   ),
//                 ),
//               ],
//             )
//           : Center(child: CircularProgressIndicator()),
//     );
//   }
// }

// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:gobank/utils/colornotifire.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class BannerPage extends StatefulWidget {
//   const BannerPage({Key? key}) : super(key: key);

//   @override
//   State<BannerPage> createState() => _BannerPageState();
// }

// class _BannerPageState extends State<BannerPage> {
//   PageController _pageController = PageController();
//   late ColorNotifire notifire;
//   final FirebaseStorage storage = FirebaseStorage.instance;
//   final String folderPath = 'Banner_images'; // Path to your Firebase Storage folder
//   List<String> imageUrls = [];
//   bool flag = false;

//   @override
//   void initState() {
//     super.initState();
//     fetchImageUrls();
//   }

//   Future<void> fetchImageUrls() async {
//     imageUrls = await getImageUrls();
//     print(imageUrls.length);
//     setState(() {
//       flag = true;
//     });
//   }

//   Future<List<String>> getImageUrls() async {
//     try {
//       final Reference ref = storage.ref().child(folderPath);
//       final ListResult result = await ref.listAll();

//       if (result.items.isNotEmpty) {
//         for (final Reference imageRef in result.items) {
//           final String downloadUrl = await imageRef.getDownloadURL();
//           imageUrls.add(downloadUrl);
//           setState(() {});
//           print(imageUrls);
//         }
//       } else {
//         print('No images found in the specified folder.');
//       }
//     } catch (e) {
//       print('Error getting image URLs: $e');
//     }

//     return imageUrls;
//   }

//   @override
//   Widget build(BuildContext context) {
//     notifire = Provider.of<ColorNotifire>(context, listen: true);
//     return Container(
//       height: 200,
//       child: flag
//           ? PageView.builder(
//               controller: _pageController,
//               itemCount: imageUrls.length,
//               itemBuilder: (BuildContext context, int index) {
//                 return Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 20.0),
//                   child: GestureDetector(
//                     onTap: () {
//                       // Navigate to the offer details page
//                     },
//                     child: Container(
//                       width: 350,
//                       height: 200,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(10.0),
//                       ),
//                       child: ClipRRect(
//                         borderRadius: BorderRadius.circular(10.0),
//                         child: Image.network(
//                           imageUrls[index],
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                     ),
//                   ),
//                 );
//               },
//               onPageChanged: (int index) {
//                 _pageController.animateToPage(
//                   index,
//                   duration: Duration(milliseconds: 1000), // Increase the duration for a smoother transition
//                   curve: Curves.easeInOut, // Adjust the animation curve for smoother motion
//                 );
//               },
//             )
//           : Center(child: CircularProgressIndicator()),
//     );
//   }
// }
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:gobank/utils/colornotifire.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'dart:async';

// class BannerPage extends StatefulWidget {
//   const BannerPage({Key? key}) : super(key: key);

//   @override
//   State<BannerPage> createState() => _BannerPageState();
// }

// class _BannerPageState extends State<BannerPage> {
//   PageController _pageController = PageController();
//   late ColorNotifire notifire;
//   final FirebaseStorage storage = FirebaseStorage.instance;
//   final String folderPath = 'Banner_images'; // Path to your Firebase Storage folder
//   List<String> imageUrls = [];
//   bool flag = false;
//   int currentPage = 0;
//   Timer? _timer;

//   @override
//   void initState() {
//     super.initState();
//     fetchImageUrls();
//     startTimer();
//   }

//   @override
//   void dispose() {
//     _timer?.cancel();
//     super.dispose();
//   }

//   void startTimer() {
//     _timer = Timer.periodic(Duration(seconds: 3), (Timer timer) {
//       if (currentPage < imageUrls.length - 1) {
//         currentPage++;
//       } else {
//         currentPage = 0;
//       }
//       _pageController.animateToPage(
//         currentPage,
//         duration: Duration(milliseconds: 500),
//         curve: Curves.easeInOut,
//       );
//     });
//   }

//   Future<void> fetchImageUrls() async {
//     imageUrls = await getImageUrls();
//     print(imageUrls.length);
//     setState(() {
//       flag = true;
//     });
//   }

//   Future<List<String>> getImageUrls() async {
//     try {
//       final Reference ref = storage.ref().child(folderPath);
//       final ListResult result = await ref.listAll();

//       if (result.items.isNotEmpty) {
//         for (final Reference imageRef in result.items) {
//           final String downloadUrl = await imageRef.getDownloadURL();
//           imageUrls.add(downloadUrl);
//           setState(() {});
//           print(imageUrls);
//         }
//       } else {
//         print('No images found in the specified folder.');
//       }
//     } catch (e) {
//       print('Error getting image URLs: $e');
//     }

//     return imageUrls;
//   }

//   @override
//   Widget build(BuildContext context) {
//     notifire = Provider.of<ColorNotifire>(context, listen: true);
//     return Container(
//       height: 200,
//       child: flag
//           ? PageView.builder(
//               controller: _pageController,
//               itemCount: imageUrls.length,
//               itemBuilder: (BuildContext context, int index) {
//                 return Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 20.0),
//                   child: GestureDetector(
//                     onTap: () {
//                       // Navigate to the offer details page
//                     },
//                     child: Container(
//                       width: 350,
//                       height: 200,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(10.0),
//                       ),
//                       child: ClipRRect(
//                         borderRadius: BorderRadius.circular(10.0),
//                         child: Image.network(
//                           imageUrls[index],
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                     ),
//                   ),
//                 );
//               },
//               onPageChanged: (int index) {
//                 currentPage = index;
//               },
//             )
//           : Center(child: CircularProgressIndicator()),
//     );
//   }
// }

