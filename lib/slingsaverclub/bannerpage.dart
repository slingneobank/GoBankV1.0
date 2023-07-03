import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:gobank/databasehelper.dart';
import 'package:gobank/utils/colornotifire.dart';
import 'package:gobank/utils/media.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as httpPackage;
import 'package:path/path.dart' as path;
import 'package:shimmer/shimmer.dart';

class BannerPage extends StatefulWidget {
  const BannerPage({Key? key}) : super(key: key);

  @override
  State<BannerPage> createState() => _BannerPageState();
}

class _BannerPageState extends State<BannerPage> {
  final PageController _pageController = PageController();
  late ColorNotifire notifire;
  final FirebaseStorage storage = FirebaseStorage.instance;
  final String folderPath = 'Banner_images'; // Path to your Firebase Storage folder
  List<String> imageUrls = [];
    List<String> localImageUrls = [];
    final DatabaseHelper databaseHelper = DatabaseHelper();
  bool flag = false;
  int currentPage = 0;
 bool isLoading = true;
  bool isConnected = false;
  @override
  void initState() {
    super.initState();
   // requestStoragePermission();
    //fetchImageUrls();
  
    checkInternetConnectivity(); // Check the initial internet connectivity state
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if (result != ConnectivityResult.none) {
        setState(() {
          isConnected = true;
          isLoading=false;
        });
        fetchImageUrls();
      } else {
        setState(() {
          isConnected = false;
          isLoading=false;
        });
      //  showInternetConnectionDialog(); // Show the internet connection dialog
   
      }
    });
    fetchImageUrls();
  }
   void showInternetConnectionDialog() {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('NO Internet Connection'),
        content: const Text('Try Turning on your WIFI or MOBILEDATA for using the App'),
        actions: [
          Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OutlinedButton(
                    child: const Text('Retry'),
                    onPressed: () {
                      Navigator.of(context).pop();
                      fetchImageUrls();
                    },
                  ),
                  const SizedBox(width: 20,),
                OutlinedButton(
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
                ],
              ),
              
            ],
          ),
        ],
      );
    },
  );
}
    void checkInternetConnectivity() async {
  var connectivityResult = await Connectivity().checkConnectivity();
  if (connectivityResult != ConnectivityResult.none) {
    setState(() {
      isConnected = true;
    });
  } else {
    setState(() {
      isConnected = false;
    });
    showInternetConnectionDialog(); // Show the internet connection dialog
  }
}
  Future<void> requestStoragePermission() async {
    final PermissionStatus status = await Permission.storage.request();
    if (status.isGranted) {
      // Permission granted, fetch image URLs
      fetchImageUrls();
    } else if (status.isDenied) {
      // Permission denied
      // Handle accordingly (show an error message, disable features, etc.)
      print('Storage permission is denied.');
    } else if (status.isPermanentlyDenied) {
      // Permission permanently denied
      // Open app settings to enable permission manually
      openAppSettings();
    }
  }
  // Future<void> fetchImageUrls() async {
  //   imageUrls = await getImageUrls();
  //   print(imageUrls.length);
  //   setState(() {
  //     flag = true;
  //   });
  // }
 Future<void> fetchImageUrls() async {
  if (isConnected && imageUrls.isEmpty) {
    imageUrls = await getImageUrls();
    await saveImageUrlsToDatabase(imageUrls);
    print("Images are retrieved from Firebase Storage.");
  } else if (!isConnected && localImageUrls.isEmpty) {
    localImageUrls = await getImageUrlsFromDatabase();
    print("Images are retrieved from the local database.");
  }

  setState(() {
    flag = true;
    isLoading = false;
  });
}


Directory? appDir;
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
  Widget buildImageWidget(String imageUrl) {
  print(imageUrl);
    if (imageUrl.startsWith('http') || imageUrl.startsWith('https')) {
      // Firebase Storage URL
      
      print('banner Images are shown from Firebase Storage.');
      return Image.network(
        imageUrl,
        fit: BoxFit.cover,
        width: height * 0.15,
        height: height * 0.15,
      );
    } else {
      // Local file path
      print('banner Images are shown from local storage.');
      // return Container(
      //   height: 10,
      //   width: 10,
      //   color: Colors.red,
      // );
      return Image.file(
        File(imageUrl),
        fit: BoxFit.cover,
        width: height * 0.15,
        height: height * 0.15,
      );
    }
  }
  Future<List<String>> getImageUrlsFromDatabase() async {
  final databaseHelper = DatabaseHelper();
  final List<Map<String, dynamic>> imageUrlData = await databaseHelper.getbannerImageUrls();
  final List<String> localImageUrls = [];

  for (var data in imageUrlData) {
    String? url = data[DatabaseHelper.BannerLiveurl];
    String? localPath = data[DatabaseHelper.BannerLocalurl];

    if (url != null && localPath != null) {
      localImageUrls.add(localPath);
    }
  }

  if (localImageUrls.isNotEmpty) {
    print("Images are retrieved from the database.");
  } else {
    print("No images found in the database.");
  }

  return localImageUrls;
}
  Future<void> downloadAndSaveImage(String imageUrl, List<String> localImagesList) async {
  final String fileName = path.basename(imageUrl);
  final Directory appDir = await getApplicationDocumentsDirectory();
  final String localPath = '${appDir.path}/$fileName';
  final File localFile = File(localPath);

  try {
    if (!localFile.existsSync()) {
      await localFile.create(recursive: true);
      final httpPackage.Response response = await httpPackage.get(Uri.parse(imageUrl));
      await localFile.writeAsBytes(response.bodyBytes);
      print('Banner Image downloaded and saved at: ${localFile.path}');
      localImagesList.add(localPath); // Add local path to the list
      //Insert the image URL and local path into the database
      await databaseHelper.insertbannerImageUrl(imageUrl, localPath);
      print("Banner Image URL inserted into the database: $localPath");
    } else {
      localImagesList.add(localPath); // Add existing local path to the list
    }
  } catch (e) {
    print('Error downloading and saving image: $e');
  }
}
Future<void> saveImageUrlsToDatabase(List<String> urls) async {
  final databaseHelper = DatabaseHelper();

  for (final url in urls) {
    final String fileName = path.basename(url);
    final Directory appDir = await getApplicationDocumentsDirectory();
    final String localPath = '${appDir.path}/$fileName';
    final File localFile = File(localPath);

    try {
      if (!localFile.existsSync()) {
        await localFile.create(recursive: true);
        final httpPackage.Response response = await httpPackage.get(Uri.parse(url));
        await localFile.writeAsBytes(response.bodyBytes);
        print('Banner Image downloaded and saved at: ${localFile.path}');
        await databaseHelper.insertbannerImageUrl(url, localPath);
        print("Banner Image URL inserted into the database: $localPath");
      }
    } catch (e) {
      print('Error downloading and saving image: $e');
    }
  }
}
  @override
  Widget build(BuildContext context) {
    notifire = Provider.of<ColorNotifire>(context, listen: true);
    return SizedBox(
      height: 160,
      child: isLoading
              ?
              Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            enabled: true,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: imageUrls.length, // Specify the number of shimmer placeholders you want
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Container(
                  width: 350,
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
            ),
          )
            // ? Center(child: CircularProgressIndicator())
            : (isConnected && imageUrls.isNotEmpty)
                ?PageView.builder(
              controller: _pageController,
              itemCount: imageUrls.length,
              itemBuilder: (BuildContext context, int index) {
                print("banner img length :${imageUrls.length}");
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
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
                          child: buildImageWidget(imageUrls[index]),
                          // child: Image.network(
                          //   imageUrls[index],
                          //   fit: BoxFit.cover,
                          // ),
                        )
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
                            spacing: const EdgeInsets.all(3.0),
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
            : (localImageUrls.isNotEmpty)
                    ? PageView.builder(
              controller: _pageController,
              itemCount: localImageUrls.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
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
                          child: buildImageWidget(localImageUrls[index]),
                          // child: Image.network(
                          //   imageUrls[index],
                          //   fit: BoxFit.cover,
                          // ),
                        )
                      ),
                      Positioned(
                        bottom: 10.0,
                        left: 0,
                        right: 0,
                        child: DotsIndicator(
                          dotsCount: localImageUrls.length,
                          position: currentPage.toInt(),
                          decorator: DotsDecorator(
                            color: Colors.grey, // Inactive dot color
                            activeColor: Colors.blue, // Active dot color
                            spacing: const EdgeInsets.all(3.0),
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
          : const Center(child: CircularProgressIndicator()),
    );
  }
}

// @override
// Widget build(BuildContext context) {
//   notifire = Provider.of<ColorNotifire>(context, listen: true);
//   return Container(
//     height: 160,
//     child: (isConnected && imageUrls.isNotEmpty) || localImageUrls.isNotEmpty
//         ? PageView.builder(
//             controller: _pageController,
//             itemCount: isConnected ? imageUrls.length : localImageUrls.length,
//             itemBuilder: (BuildContext context, int index) {
//               final imageUrl = isConnected ? imageUrls[index] : localImageUrls[index];
//               return Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 20.0),
//                 child: Stack(
//                   children: [
//                     Container(
//                       width: 350,
//                       height: 200,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(10.0),
//                       ),
//                       child: ClipRRect(
//                         borderRadius: BorderRadius.circular(10.0),
//                         child: buildImageWidget(imageUrl),
//                       ),
//                     ),
//                     Positioned(
//                       bottom: 10.0,
//                       left: 0,
//                       right: 0,
//                       child: DotsIndicator(
//                         dotsCount: isConnected ? imageUrls.length : localImageUrls.length,
//                         position: currentPage.toDouble(),
//                         decorator: DotsDecorator(
//                           color: Colors.grey, // Inactive dot color
//                           activeColor: Colors.blue, // Active dot color
//                           spacing: EdgeInsets.all(3.0),
//                           size: const Size.square(7.0),
//                           activeSize: const Size(10.0, 8.0),
//                           activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               );
//             },
//             onPageChanged: (int index) {
//               setState(() {
//                 currentPage = index;
//               });
//             },
//           )
//         : Center(child: CircularProgressIndicator()),
//   );
// }
