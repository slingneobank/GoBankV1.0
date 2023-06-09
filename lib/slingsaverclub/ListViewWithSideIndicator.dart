
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:carousel_indicator/carousel_indicator.dart';
import 'package:gobank/databasehelper.dart';
import 'package:gobank/slingsaverclub/bottomsheetpage.dart';
import 'package:gobank/slingsaverclub/offerdetailspage.dart';
import 'package:connectivity/connectivity.dart';
import 'package:permission_handler/permission_handler.dart';


class ListViewWithSideIndicator extends StatefulWidget {
  @override
  _ListViewWithSideIndicatorState createState() =>
      _ListViewWithSideIndicatorState();
}

class _ListViewWithSideIndicatorState extends State<ListViewWithSideIndicator> {
  late ScrollController _scrollController;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  PersistentBottomSheetController? _bottomSheetController;
  int activeIndex = 0;
  bool isLoading = true;
  bool isConnected = false;

  final FirebaseStorage storage = FirebaseStorage.instance;
  final String folderPath = 'offer_images';
  List<String> imageUrls = [];
   List<String> localImageUrls = [];
  bool flag = false;
 final DatabaseHelper databaseHelper = DatabaseHelper();
  @override
  void initState() {
    super.initState();
     requestStoragePermission();
    fetchImageUrls();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if (result != ConnectivityResult.none) {
        setState(() {
          isConnected = true;
        });
        fetchImageUrls();
      } else {
        setState(() {
          isConnected = false;
        });
      }
    });
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
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

   Future<void> fetchImageUrls() async {
   

    if (isConnected) {
      imageUrls = await getImageUrls();
      await saveImageUrlsToDatabase(imageUrls);
    } else {
      imageUrls = await getImageUrlsFromDatabase();
    }

    setState(() {
      flag = true;
      isLoading = false;
    });
  }
  Future<List<String>> getImageUrlsFromDatabase() async {
    localImageUrls = await databaseHelper.getImageUrls();
    return localImageUrls;
  }

  Future<void> saveImageUrlsToDatabase(List<String> urls) async {
    for (final url in urls) {
      //print(url);
      await databaseHelper.insertImageUrl(url);
    }
  }
   Future<bool> checkConnectivity() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }
  Future<List<String>> getImageUrls() async {
    try {
      final Reference ref = storage.ref().child(folderPath);
      final ListResult result = await ref.listAll();

      if (result.items.isNotEmpty) {
        final List<String> urls = [];

        for (final Reference imageRef in result.items) {
          final String downloadUrl = await imageRef.getDownloadURL();
          urls.add(downloadUrl);
        }

        return urls;
      } else {
        print('No images found in the specified folder.');
      }
    } catch (e) {
      print('Error getting image URLs: $e');
    }

    return [];
  }

  void _scrollListener() {
    final screenWidth = MediaQuery.of(context).size.width;
    final containerWidth = 150.0;
    final itemWidth = containerWidth + 8;
    final index = (_scrollController.offset / itemWidth).round();
    if (activeIndex != index) {
      setState(() {
        activeIndex = index;
      });
    }
    print("object1$activeIndex");
    print("object2$index");
  }

  void _onImageTap(int index) {
    setState(() {
      activeIndex = index;
    });

    if (index == 0) {
      // Navigate to the page view
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OfferDetailsPage(
            imageUrl: imageUrls[index],
            currentindex: index,
          ),
        ),
      );
    } else {
      if (_scaffoldKey.currentState != null) {
        _bottomSheetController = _scaffoldKey.currentState!.showBottomSheet(
          (context) => bottomsheetpage(),
          elevation: 10,
          backgroundColor: Colors.transparent,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      key: _scaffoldKey,
      body: Column(
        children: [
          Container(
  height: 200,
  child: flag
      ? CarouselSlider(
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
                activeIndex = index;
              });
            },
          ),
          items: imageUrls.map((imageUrl) {
            return GestureDetector(
              onTap: () {
                // Navigate to the offer details page
               // _onImageTap(index);
              },
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 10,
                ),
                child: Row(
                  children: [
                    Container(
                      width: 140,
                      height: 200,
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
                    SizedBox(width: 10),
                  ],
                ),
              ),
            );
          }).toList(),
        )
      : Center(child: CircularProgressIndicator()),
),
SizedBox(height: height / 80),
if (flag && imageUrls.isNotEmpty)
  Container(
    child: CarouselIndicator(
      count: imageUrls.length,
      index: activeIndex,
      color: Colors.orange,
      activeColor: Colors.deepOrange,
      space: 4,
      width: 4,
      height: 4,
    ),
  ),

        ],
      ),
    );
  }
}
