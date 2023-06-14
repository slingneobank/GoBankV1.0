import 'dart:io';
import 'package:carousel_indicator/carousel_indicator.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gobank/bottombar/bottombar.dart';
import 'package:gobank/card/mycard.dart';
import 'package:gobank/databasehelper.dart';
import 'package:gobank/home/helpandsupport.dart';
import 'package:gobank/home/rating.dart';
import 'package:gobank/home/sliders.dart';
import 'package:gobank/home/sling_store/sling_store.dart';
import 'package:gobank/home/notifications.dart';
import 'package:gobank/home/request/request.dart';
import 'package:gobank/home/savers_club_sliders.dart';
import 'package:gobank/home/savings/savings_story_page.dart';
import 'package:gobank/home/scanpay/scan.dart';
import 'package:gobank/home/seealltransaction.dart';
import 'package:gobank/slingsaverclub/bottomsheetpage.dart';
import 'package:gobank/slingsaverclub/offerdetailspage.dart';
import 'package:gobank/slingsaverclub/sliderpage.dart';
import 'package:gobank/utils/colornotifire.dart';
import 'package:gobank/utils/media.dart';
import 'package:gobank/utils/string.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:gobank/login/auth_ctrl.dart';
import '../profile/helpsupport.dart';
import '../profile/legalandpolicy.dart';
import '../slingsaverclub/bannerpage.dart';
import 'home_ctrl.dart';
import 'seeallpayment.dart';
import 'transfer/sendmoney.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart' as httpPackage;
import 'package:path/path.dart' as path;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final homeCtrl = Get.put<HomeCtrl>(HomeCtrl());
  // final authCtrl = Get.find<AuthCtrl>();
  late ScrollController _scrollController;
  late ColorNotifire notifire;
  PersistentBottomSheetController? _bottomSheetController;
  getdarkmodepreviousstate() async {
    final prefs = await SharedPreferences.getInstance();
    bool? previusstate = prefs.getBool("setIsDark");
    if (previusstate == null) {
      notifire.setIsDark = false;
    } else {
      notifire.setIsDark = previusstate;
    }
  }

  List img = [
    "images/mobile.png",
    "images/shopping.png",
    "images/ticket.png",
    "images/wifi1.png",
    "images/assurance.png",
    "images/ticket.png",
    "images/bill.png",
    "images/mastercard.png",
    "images/mobrecharge.png",
    "images/pp.png",
    "images/dth.png",
  ];

  List paymentname = [
    CustomStrings.nearbystores,
    "Sling Store",
    // CustomStrings.travelflight,
    "Bus Booking",
    // CustomStrings.eventsmovies,
    "Recharges",
    // CustomStrings.buyinsurance,
    "Bharat Bill Payment",
    // CustomStrings.getfastag,
    "Fees Payment",
    // CustomStrings.buyelectronic,
    "Buy Coupons",
    // CustomStrings.allservices,
    "Credit Card",
    // CustomStrings.mobrecharge,
    "Mobile Recharge",
    //CustomStrings.pp,
    "PostPaid",
    //CustomStrings.dth,
    "DTH",
  ];

  List transaction = [
    "images/starbuckscoffee.png",
    "images/spotify.png",
    "images/netflix.png"
  ];

  List cashbankimg = [
    "images/cashback.png",
    "images/merchant1.png",
    "images/helpandsupport.png"
  ];
  List transactionname = [
    CustomStrings.starbuckscoffee,
    CustomStrings.spotifypremium,
    CustomStrings.netflixpremium,
  ];
  List transactioncolor = [
    Colors.red,
    Colors.green,
    Colors.red,
  ];
  List transactionamount = [
    "-\$.55.000",
    "+\$.27.000",
    "-\$.34.000",
  ];
  List cashbankname = [
    CustomStrings.cashback,
    "Refer A Friend",
    CustomStrings.helpandsuppors,
  ];
  List cashbankdiscription = [
    CustomStrings.scratchcards,
    CustomStrings.startsccepting,
    CustomStrings.relatedpaytm,
  ];
  List transactiondate = [
    "12 Oct 2021 . 16:03",
    "8 Oct 2021 . 12:05",
    "4 Oct 2021 . 09:25",
  ];
  List cashbankdiscription2 = [
    CustomStrings.scratchcards2,
    CustomStrings.startsccepting2,
    CustomStrings.relatedpaytm2,
  ];
  bool selection = true;

  int activeIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final FirebaseStorage storage = FirebaseStorage.instance;
  final String folderPath =
      'offer_images'; // Path to your Firebase Storage folder
  List<String> imageUrls = [];
  bool flag = false;
  bool isLoading = true;
  bool isConnected = false;
  List<String> localImageUrls = [];
  final List<String> localImagesList =
      []; // Create an empty list to store local paths

  final DatabaseHelper databaseHelper = DatabaseHelper();
  Directory? appDir;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    requestStoragePermission();

    checkInternetConnectivity(); // Check the initial internet connectivity state
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      print(result);
      if (result != ConnectivityResult.none) {
        setState(() {
          isConnected = true;
        });
        fetchImageUrls();
      } else {
        setState(() {
          isConnected = false;
        });
        showInternetConnectionDialog(); // Show the internet connection dialog
      }
    });
    fetchImageUrls();
    _scrollController =
        ScrollController(); // Initialize the scroll controller here
    _scrollController.addListener(_scrollListener);
  }

  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void showInternetConnectionDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('NO Internet Connection'),
          content:
              Text('Try Turning on your WIFI or MOBILEDATA for using the App'),
          actions: [
            Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    OutlinedButton(
                      child: Text('Retry'),
                      onPressed: () {
                        Navigator.of(context).pop();
                        fetchImageUrls();
                      },
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    OutlinedButton(
                      child: Text('Cancel'),
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

  Future<void> fetchImageUrls() async {
    if (isConnected) {
      imageUrls = await getImageUrls();
      await saveImageUrlsToDatabase(imageUrls);
      print("Images are retrieved from Firebase Storage.");
    } else {
      localImageUrls = await getImageUrlsFromDatabase();
      print("Images are retrieved from the local database.");
    }

    setState(() {
      flag = true;
      isLoading = false;
    });
  }

  Future<List<String>> getImageUrlsFromDatabase() async {
    final databaseHelper = DatabaseHelper();
    final List<Map<String, dynamic>> imageUrlData =
        await databaseHelper.getImageUrls();
    final List<String> localImageUrls = [];

    for (var data in imageUrlData) {
      String? url = data[DatabaseHelper.columnLiveUrl];
      String? localPath = data[DatabaseHelper.columnLocalUrl];

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
          final httpPackage.Response response =
              await httpPackage.get(Uri.parse(url));
          await localFile.writeAsBytes(response.bodyBytes);
          print('Image downloaded and saved at: ${localFile.path}');
          await databaseHelper.insertImageUrl(url, localPath);
          print("Image URL inserted into the database: $localPath");
        }
      } catch (e) {
        print('Error downloading and saving image: $e');
      }
    }
  }

  Future<void> downloadAndSaveImage(
      String imageUrl, List<String> localImagesList) async {
    final String fileName = path.basename(imageUrl);
    final Directory appDir = await getApplicationDocumentsDirectory();
    final String localPath = '${appDir.path}/$fileName';
    final File localFile = File(localPath);

    try {
      if (!localFile.existsSync()) {
        await localFile.create(recursive: true);
        final httpPackage.Response response =
            await httpPackage.get(Uri.parse(imageUrl));
        await localFile.writeAsBytes(response.bodyBytes);
        print('Image downloaded and saved at: ${localFile.path}');
        localImagesList.add(localPath); // Add local path to the list
        //Insert the image URL and local path into the database
        await databaseHelper.insertImageUrl(imageUrl, localPath);
        print("Image URL inserted into the database: $localPath");
      } else {
        localImagesList.add(localPath); // Add existing local path to the list
      }
    } catch (e) {
      print('Error downloading and saving image: $e');
    }
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
    ///final screenWidth = MediaQuery.of(context).size.width;
    final containerWidth = 150.0;
    final itemWidth = containerWidth + 8;
    final index = (_scrollController.offset / itemWidth).round();
    if (activeIndex != index) {
      setState(() {
        activeIndex = index;
      });
    }
    print(" active index$activeIndex");
    print(" index $index");
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
    notifire = Provider.of<ColorNotifire>(context, listen: true);
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: notifire.getprimerycolor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: height / 20,
            ),
            Row(
              children: [
                SizedBox(
                  width: width / 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      CustomStrings.goodmorning,
                      style: TextStyle(
                          color: notifire.getdarkgreycolor,
                          fontSize: height / 50,
                          fontFamily: 'Gilroy Medium'),
                    ),
                    SizedBox(
                      height: height / 100,
                    ),
                    // Text(
                    //   authCtrl.auth.currentUser!.phoneNumber ?? 'mynumber',
                    //   style: TextStyle(
                    //       color: notifire.getdarkscolor,
                    //       fontSize: height / 40,
                    //       fontFamily: 'Gilroy Bold'),
                    // ),
                  ],
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MyCard(),
                      ),
                    );
                  },
                  child: Image.asset(
                    "images/message1.png",
                    color: notifire.getdarkscolor,
                    height: height / 30,
                  ),
                ),
                SizedBox(
                  width: width / 30,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const Notificationindex(CustomStrings.notification),
                      ),
                    );
                  },
                  child: Image.asset(
                    "images/notification.png",
                    color: notifire.getdarkscolor,
                    height: height / 30,
                  ),
                ),
                SizedBox(
                  width: width / 20,
                ),
              ],
            ),
            SizedBox(
              height: height / 80,
            ),
            Stack(
              children: [
                Container(
                    color: notifire.getbackcolor,
                    child: Image.asset("images/backphoto.png")),
                Column(
                  children: [
                    SizedBox(
                      height: height / 30,
                    ),
                    Center(
                      child: Container(
                        height: height / 35,
                        width: width / 1.5,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                          color: Color(0xff8978fa),
                        ),
                      ),
                    ),
                    Center(
                      child: Container(
                        height: height / 7,
                        width: width / 1.2,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                          color: notifire.getbluecolor,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: height / 40,
                            ),
                            Padding(
                              padding:
                                  EdgeInsets.symmetric(horizontal: width / 20),
                              child: Row(
                                children: [
                                  Text(
                                    CustomStrings.totalwalletbalance,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: height / 50,
                                        fontFamily: 'Gilroy Medium'),
                                  ),
                                  const Spacer(),
                                  Column(
                                    children: [
                                      Image.asset(
                                        "images/mastercard.png",
                                        height: height / 25,
                                      ),
                                      Text(
                                        CustomStrings.mastercard,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: height / 70,
                                            fontFamily: 'Gilroy Medium'),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: width / 20),
                              child: Row(
                                children: [
                                  Container(
                                    height: height / 20,
                                    width: width / 2.4,
                                    color: selection
                                        ? Colors.transparent
                                        : Colors.transparent,
                                    child: selection
                                        ? Text(
                                            "\$.12.000.000",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: height / 35,
                                                fontFamily: 'Gilroy Bold'),
                                          )
                                        : Text(
                                            "********",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: height / 20,
                                                fontFamily: 'Gilroy Bold'),
                                          ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selection = !selection;
                                      });
                                    },
                                    child: selection
                                        ? Padding(
                                            padding: EdgeInsets.only(
                                                bottom: height / 100),
                                            child: Image.asset(
                                              "images/eye.png",
                                              color: Colors.white,
                                              height: height / 40,
                                            ),
                                          )
                                        : Padding(
                                            padding: EdgeInsets.only(
                                                bottom: height / 100),
                                            child: const Icon(
                                              Icons.remove_red_eye,
                                              color: Colors.white,
                                            ),
                                          ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: width / 30),
                        child: Container(
                          height: height / 6.5,
                          width: width,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(10),
                            ),
                            color: notifire.getdarkwhitecolor,
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                color: notifire.getbluecolor.withOpacity(0.4),
                                blurRadius: 15.0,
                                offset: const Offset(0.0, 0.75),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              SizedBox(
                                height: height / 50,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Stack(
                                    children: [
                                      Column(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      const Scan(),
                                                ),
                                              );
                                            },
                                            child: Container(
                                              height: height / 15,
                                              width: width / 7,
                                              decoration: BoxDecoration(
                                                color:
                                                    notifire.gettabwhitecolor,
                                                borderRadius:
                                                    const BorderRadius.all(
                                                  Radius.circular(10),
                                                ),
                                              ),
                                              child: Center(
                                                child: Image.asset(
                                                  "images/scanpay.png",
                                                  height: height / 20,
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: height / 60,
                                          ),
                                          Text(
                                            "Order\nPhysical Card",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontFamily: "Gilroy Bold",
                                                color: notifire.getdarkscolor,
                                                fontSize: height / 65),
                                          ),
                                        ],
                                      ),
                                      Positioned(
                                        top: 0,
                                        right: 0,
                                        child: Container(
                                          padding: const EdgeInsets.all(4.0),
                                          decoration: BoxDecoration(
                                            color: Colors.yellow[300],
                                            borderRadius:
                                                BorderRadius.circular(32.0),
                                            boxShadow: [
                                              const BoxShadow(
                                                color: Colors.white,
                                                offset: Offset(-4.0, -4.0),
                                                blurRadius: 16.0,
                                              ),
                                              BoxShadow(
                                                color: Colors.black
                                                    .withOpacity(0.2),
                                                offset: const Offset(4.0, 4.0),
                                                blurRadius: 16.0,
                                              ),
                                            ],
                                          ),
                                          // A text widget with some style
                                          child: Text(
                                            'Coming Soon',
                                            style: TextStyle(
                                              color: Colors.grey[800],
                                              fontWeight: FontWeight.bold,
                                              fontSize: 7,
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const SendMoney(),
                                            ),
                                          );
                                        },
                                        child: Container(
                                          height: height / 15,
                                          width: width / 7,
                                          decoration: BoxDecoration(
                                            color: notifire.gettabwhitecolor,
                                            borderRadius:
                                                const BorderRadius.all(
                                              Radius.circular(10),
                                            ),
                                          ),
                                          child: Center(
                                            child: Image.asset(
                                              "images/transfer.png",
                                              height: height / 20,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: height / 60,
                                      ),
                                      Text(
                                        "Coins",
                                        style: TextStyle(
                                            fontFamily: "Gilroy Bold",
                                            color: notifire.getdarkscolor,
                                            fontSize: height / 55),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const Request(),
                                            ),
                                          );
                                        },
                                        child: Container(
                                          height: height / 15,
                                          width: width / 7,
                                          decoration: BoxDecoration(
                                            color: notifire.gettabwhitecolor,
                                            borderRadius:
                                                const BorderRadius.all(
                                              Radius.circular(10),
                                            ),
                                          ),
                                          child: Center(
                                            child: Image.asset(
                                              "images/request.png",
                                              height: height / 20,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: height / 60,
                                      ),
                                      Text(
                                        "Debit Card",
                                        style: TextStyle(
                                            fontFamily: "Gilroy Bold",
                                            color: notifire.getdarkscolor,
                                            fontSize: height / 55),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const SavingsStory(),
                                            ),
                                          );
                                        },
                                        child: Container(
                                          height: height / 15,
                                          width: width / 7,
                                          decoration: BoxDecoration(
                                            color: notifire.gettabwhitecolor,
                                            borderRadius:
                                                const BorderRadius.all(
                                              Radius.circular(10),
                                            ),
                                          ),
                                          child: Center(
                                            child: Image.asset(
                                              "images/topup.png",
                                              height: height / 20,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: height / 60,
                                      ),
                                      Text(
                                        "Savings",
                                        style: TextStyle(
                                            fontFamily: "Gilroy Bold",
                                            color: notifire.getdarkscolor,
                                            fontSize: height / 55),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            // SizedBox(
            //   height: height / 30,
            // ),
            // Padding(
            //   padding: EdgeInsets.symmetric(horizontal: width / 30),
            //   child: Container(
            //       height: height / 7,
            //       decoration: const BoxDecoration(
            //         borderRadius: BorderRadius.all(
            //           Radius.circular(10),
            //         ),
            //       ),
            //       child: const CouponSliders()),
            // ),
            SizedBox(
              height: height / 30,
            ),
            SizedBox(
              child: BannerPage(),
            ),
            SizedBox(
              height: height / 30,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width / 18),
              child: Row(
                children: [
                  Text(
                    CustomStrings.discoverservices,
                    style: TextStyle(
                        fontFamily: "Gilroy Bold",
                        color: notifire.getdarkscolor,
                        fontSize: height / 40),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Seeallpayment(),
                        ),
                      );
                    },
                    child: Container(
                      color: Colors.transparent,
                      child: Text(
                        CustomStrings.seeall,
                        style: TextStyle(
                            fontFamily: "Gilroy Bold",
                            color: notifire.getbluecolor,
                            fontSize: height / 45),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: height / 50,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width / 20),
              child: Container(
                color: Colors.transparent,
                height: height / 2.3,
                width: width,
                child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.only(bottom: height / 15),
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: height / 10,
                      mainAxisExtent: height / 8,
                      childAspectRatio: 3 / 2,
                      crossAxisSpacing: height / 50,
                      mainAxisSpacing: height / 50,
                    ),
                    itemCount: img.length,
                    itemBuilder: (BuildContext ctx, index) {
                      return GestureDetector(
                        onTap: () {
                          if (index == 1) {
                            Get.to(() => const SlingStore());
                          } else {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Scan(),
                              ),
                            );
                          }
                        },
                        child: Column(
                          children: [
                            Container(
                              height: height / 15,
                              width: width / 7,
                              decoration: BoxDecoration(
                                color: notifire.gettabwhitecolor,
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              child: Center(
                                child: Image.asset(
                                  img[index],
                                  height: height / 30,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: height / 90,
                            ),
                            Center(
                              child: Text(
                                paymentname[index],
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: "Gilroy Bold",
                                    color: notifire.getdarkscolor,
                                    fontSize: height / 55),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
              ),
            ),
            SizedBox(
              height: height / 80,
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: width / 18),
              child: Row(
                children: [
                  Text(
                    CustomStrings.slingsaverclub,
                    style: TextStyle(
                        fontFamily: "Gilroy Bold",
                        color: notifire.getdarkscolor,
                        fontSize: height / 40),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: height / 80,
            ),
            Container(
              height: 200,
              child: isLoading
                  ? Center(child: CircularProgressIndicator())
                  : (isConnected && imageUrls.isNotEmpty)
                      ? ListView.builder(
                          controller: _scrollController,
                          scrollDirection: Axis.horizontal,
                          itemCount: imageUrls.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () => _onImageTap(index),
                              child: Container(
                                height: 200,
                                width: 140,
                                margin: EdgeInsets.all(4),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: buildImageWidget(imageUrls[index]),
                                ),
                              ),
                            );
                          },
                        )
                      : (localImageUrls.isNotEmpty)
                          ? ListView.builder(
                              controller: _scrollController,
                              scrollDirection: Axis.horizontal,
                              itemCount: localImageUrls.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () => _onImageTap(index),
                                  child: Container(
                                    height: 200,
                                    width: 160,
                                    margin: EdgeInsets.all(4),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: buildImageWidget(
                                          localImageUrls[index]),
                                    ),
                                  ),
                                );
                              },
                            )
                          : Center(child: Text("No images available.")),
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

            SizedBox(
              height: height / 80,
            ),
            SizedBox(
              height: 200,
              width: width - 30,
              child: SliderPage(),
            ),
            SizedBox(
              height: height / 80,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width / 18),
              child: Row(
                children: [
                  Text(
                    CustomStrings.lasttransaction,
                    style: TextStyle(
                        fontFamily: "Gilroy Bold",
                        color: notifire.getdarkscolor,
                        fontSize: height / 40),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Seealltransaction(),
                        ),
                      );
                    },
                    child: Container(
                      color: Colors.transparent,
                      child: Text(
                        CustomStrings.seeall,
                        style: TextStyle(
                            fontFamily: "Gilroy Bold",
                            color: notifire.getbluecolor,
                            fontSize: height / 45),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: height / 50,
            ),
            Container(
              height: height / 3,
              color: Colors.transparent,
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                itemCount: transaction.length,
                itemBuilder: (context, index) => Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: width / 22, vertical: height / 100),
                  child: Container(
                    height: height / 11,
                    width: width,
                    decoration: BoxDecoration(
                      color: notifire.getdarkwhitecolor,
                      border: Border.all(
                        color: Colors.grey.withOpacity(0.2),
                      ),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: width / 20),
                      child: Row(
                        children: [
                          Container(
                            height: height / 15,
                            width: width / 7,
                            decoration: BoxDecoration(
                              color: notifire.gettabwhitecolor,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            child: Center(
                              child: Image.asset(
                                transaction[index],
                                height: height / 20,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: width / 30,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: height / 70,
                              ),
                              Row(
                                children: [
                                  Text(
                                    transactionname[index],
                                    style: TextStyle(
                                        fontFamily: "Gilroy Bold",
                                        color: notifire.getdarkscolor,
                                        fontSize: height / 50),
                                  ),
                                  // SizedBox(width: width / 7,),
                                ],
                              ),
                              SizedBox(
                                height: height / 100,
                              ),
                              Row(
                                children: [
                                  Text(
                                    transactiondate[index],
                                    style: TextStyle(
                                        fontFamily: "Gilroy Medium",
                                        color: notifire.getdarkgreycolor
                                            .withOpacity(0.6),
                                        fontSize: height / 60),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const Spacer(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              SizedBox(
                                height: height / 70,
                              ),
                              Text(
                                transactionamount[index],
                                style: TextStyle(
                                    fontFamily: "Gilroy Bold",
                                    color: transactioncolor[index],
                                    fontSize: height / 45),
                              ),
                              SizedBox(
                                height: height / 100,
                              ),
                              Text(
                                "Order ID:***ase21",
                                style: TextStyle(
                                    fontFamily: "Gilroy Medium",
                                    color: notifire.getdarkgreycolor
                                        .withOpacity(0.6),
                                    fontSize: height / 60),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              height: height / 2.5,
              color: Colors.transparent,
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                itemCount: cashbankname.length,
                itemBuilder: (context, index) => Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: width / 20, vertical: height / 100),
                  child: InkWell(
                    onTap: () {
                      if (index == 0) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const Notificationindex(CustomStrings.cashback),
                          ),
                        );
                      } else if (index == 1) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HelpSupport(
                              "Refer A Friend",
                            ),
                          ),
                        );
                      } else if (index == 2) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HelpAndSupport(),
                          ),
                        );
                      }
                    },
                    child: Container(
                      height: height / 9,
                      width: width,
                      decoration: BoxDecoration(
                        color: notifire.getdarkwhitecolor,
                        border: Border.all(
                          color: Colors.grey.withOpacity(0.2),
                        ),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: width / 20),
                        child: Row(
                          children: [
                            Container(
                              height: height / 15,
                              width: width / 7,
                              decoration: BoxDecoration(
                                color: notifire.gettabwhitecolor,
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              child: Center(
                                child: Image.asset(
                                  cashbankimg[index],
                                  height: height / 20,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: width / 30,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: height / 70,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      cashbankname[index],
                                      style: TextStyle(
                                          fontFamily: "Gilroy Bold",
                                          color: notifire.getdarkscolor,
                                          fontSize: height / 50),
                                    ),
                                    // SizedBox(width: width / 7,),
                                  ],
                                ),
                                SizedBox(
                                  height: height / 100,
                                ),
                                Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          cashbankdiscription[index],
                                          style: TextStyle(
                                              fontFamily: "Gilroy Medium",
                                              color: notifire.getdarkgreycolor
                                                  .withOpacity(0.6),
                                              fontSize: height / 70),
                                        ),
                                        Text(
                                          cashbankdiscription2[index],
                                          style: TextStyle(
                                              fontFamily: "Gilroy Medium",
                                              color: notifire.getdarkgreycolor
                                                  .withOpacity(0.6),
                                              fontSize: height / 60),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const Spacer(),
                            Icon(Icons.arrow_forward_ios,
                                color: notifire.getdarkscolor,
                                size: height / 40),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              height: height / 6,
              color: Colors.transparent,
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                itemCount: 1,
                itemBuilder: (context, index) => Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: width / 20, vertical: height / 100),
                  child: InkWell(
                    onTap: () {},
                    child: Container(
                      height: height / 7,
                      width: width,
                      decoration: BoxDecoration(
                        color: notifire.getdarkwhitecolor,
                        border: Border.all(
                          color: Colors.grey.withOpacity(0.2),
                        ),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: width / 20),
                        child: Row(
                          children: [
                            Container(
                              height: height / 10,
                              width: width / 6,
                              decoration: BoxDecoration(
                                color: notifire.gettabwhitecolor,
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              child: Center(
                                child: Image.asset(
                                  'images/rating.png',
                                  height: height / 5,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: width / 30,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: height / 70,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      CustomStrings.lovingsling,
                                      style: TextStyle(
                                          fontFamily: "Gilroy Bold",
                                          color: notifire.getdarkscolor,
                                          fontSize: height / 50),
                                    ),
                                    // SizedBox(width: width / 7,),
                                  ],
                                ),
                                InkWell(
                                  onTap: () {
                                    openRatingDialog(context);
                                  },
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        CustomStrings.rating,
                                        style: TextStyle(
                                          fontFamily: "Gilroy Bold",
                                          color: const Color.fromARGB(
                                              255, 210, 194, 51),
                                          fontSize: height / 50,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            const Spacer(),
                            Icon(Icons.arrow_forward_ios,
                                color: notifire.getdarkscolor,
                                size: height / 40),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            // SizedBox(
            //   height: height / 20,
            // ),
          ],
        ),
      ),
    );
  }

// Widget week() {
//   return selectedindex == 0
//       ? const ChatScreen()
//       : const ChatRound();
// }
  Widget buildImageWidget(String imageUrl) {
    print(imageUrl);
    if (imageUrl.startsWith('http') || imageUrl.startsWith('https')) {
      // Firebase Storage URL

      print('Images are shown from Firebase Storage.');
      return Image.network(
        imageUrl,
        fit: BoxFit.cover,
        width: height * 0.15,
        height: height * 0.15,
      );
    } else {
      // Local file path
      print('Images are shown from local storage.');
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
}

openRatingDialog(BuildContext context) {
  showDialog(
      context: context,
      builder: (context) {
        return MaterialApp(
          theme: ThemeData(
            dialogTheme: DialogTheme(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
            ),
          ),
          home: const Dialog(
            child: Rating(),
          ),
        );
      });
}
