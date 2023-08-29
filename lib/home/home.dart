import 'dart:convert';
import 'dart:io';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:gobank/analytics/analytics.dart';
import 'package:gobank/card/mycard.dart';
import 'package:gobank/databasehelper.dart';
import 'package:gobank/home/giftcard/buyvoucher.dart';
import 'package:gobank/home/helpandsupport.dart';
import 'package:gobank/home/rating.dart';
import 'package:gobank/home/notifications.dart';
import 'package:gobank/home/savings/savings_story_page.dart';
import 'package:gobank/home/scanpay/scan.dart';
import 'package:gobank/home/seealltransaction.dart';
import 'package:gobank/home/sling_store/sling_storemain.dart';
import 'package:gobank/login/auth_controller.dart';
import 'package:gobank/login/minnativekyclogin.dart';
import 'package:gobank/pages/CardDetails.dart';
import 'package:gobank/profile/profile.dart';
import 'package:gobank/recharges/page_1.dart';
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
import 'package:shimmer/shimmer.dart';
import '../slingsaverclub/bannerpage.dart';
import 'NotificationServices.dart';
import 'giftcard/giftofferform.dart';
import 'home_ctrl.dart';
import 'loan/personalloan.dart';
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
  DateTime pre_backpress = DateTime.now();
  String? username;
  Widget currentScreen = const Home();
  int currentTab = 0;

  final List screens = [
    const Home(),
    const Analytics(),
    const MyCard(),
    const Profile(),
  ];

  List img = [
    "images/mobile.png",
    "images/shopping.png",
    "images/ticket.png",
    "images/wifi1.png",
    //"images/assurance.png",
    "images/ticket.png",
    //"images/bill.png",
    // "images/mastercard.png",
  ];
  List giftimg = [
    "asset/images/amazon.png",
    "asset/images/bigbasket.png",
    "asset/images/myntra.png",
    "asset/images/nykaa.png",
    "asset/images/swiggy.png",
    "asset/images/zomato.png",
    "asset/images/flipkart.png",
    "asset/images/more.png",
  ];
  List giftname = [
    "Amazon",
    "Bigbasket",
    "Myntra",
    "Nykaa",
    "Swiggy",
    "Zomato",
    "Flipkart",
    "100+\nMore"
  ];
  List giftdiscount = ["5", "5", "5", "5", "2", "5", "3", ""];
  List paymentname = [
    "Sling_store",
    //CustomStrings.nearbystores,
    "Fees pay",
    // CustomStrings.travelflight,
    "Bus Booking",
    // CustomStrings.eventsmovies,
    "Recharges",
    // CustomStrings.buyinsurance,
    //"Bharat Bill Payment",
    // CustomStrings.getfastag,
    "Fees Payment",
    // CustomStrings.buyelectronic,
    //"Buy Coupons",
    // CustomStrings.allservices,
    //"Credit Card"
  ];
  List transaction = [
    "images/starbuckscoffee.png",
    "images/spotify.png",
    "images/netflix.png"
  ];
  List cashbankimg = [
    //"images/cashback.png",
    // "images/merchant1.png",
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
    // CustomStrings.cashback,
    // "Refer A Friend",
    CustomStrings.helpandsuppors,
  ];
  List cashbankdiscription = [
    // CustomStrings.scratchcards,
    // CustomStrings.startsccepting,
    CustomStrings.relatedpaytm,
  ];
  List transactiondate = [
    "12 Oct 2021 . 16:03",
    "8 Oct 2021 . 12:05",
    "4 Oct 2021 . 09:25",
  ];
  List cashbankdiscription2 = [
    // CustomStrings.scratchcards2,
    // CustomStrings.startsccepting2,
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
  String? minKycUniqueId;
  var loadAmount = 0;
  var referenceNumber = '';
  NotificationServices notificationServices = NotificationServices();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    checkInternetConnectivity(); // Check the initial internet connectivity state
    requestStoragePermission();

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

    notification_loan();
    notification_FD();
    getminkycuniqeid();
    getUsername();
    getReferenceNumberFromSharedPreferences();
    getReferenceNumber();
    fetchCardSchemeId(referenceNumber);
    setState(() {
      makeGetRequest(referenceNumber);
    });

    fetchImageUrls();
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
      activeIndex = (_scrollController.offset / 130).round(); //140
    });
  }

  getminkycuniqeid() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    minKycUniqueId = await prefs.getString('storedminKycUniqueId') ?? '';
    print("minKycUniqueId is home :- $minKycUniqueId");
  }

  getdarkmodepreviousstate() async {
    final prefs = await SharedPreferences.getInstance();
    bool? previusstate = prefs.getBool("setIsDark");
    if (previusstate == null) {
      notifire.setIsDark = false;
    } else {
      notifire.setIsDark = previusstate;
    }
  }

  Future<void> getUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    username = prefs.getString('username');
    setState(() {});
  }

  Future<void> getReferenceNumber() async {
    DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? phoneNumber = prefs.getString('mobileNumber');
    print("phonenumber $phoneNumber");

    // Retrieve the reference number from SharedPreferences
    referenceNumber = prefs.getString('referenceNumber') ?? '';

    // If the reference number is null, retrieve it from the "digital_card_issuance" table
    if (referenceNumber.isEmpty) {
      DatabaseEvent event =
          await databaseRef.child('digital_card_issuance').once();
      DataSnapshot snapshot = event.snapshot;
      Map<dynamic, dynamic>? digitalCardData =
          snapshot.value as Map<dynamic, dynamic>?;
      if (digitalCardData != null &&
          phoneNumber != null &&
          digitalCardData.containsKey(phoneNumber)) {
        int? referenceNumberInt =
            digitalCardData[phoneNumber]['referenceNumber'] as int?;
        referenceNumber = referenceNumberInt?.toString() ?? '';

        // Store the reference number in SharedPreferences
        await prefs.setString('referenceNumber', referenceNumber);
      }
    }

    print('Reference Number: $referenceNumber');
  }

  Future<void> fetchCardSchemeId(String referenceNumber) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      referenceNumber = prefs!.getString('referenceNumber') ?? '';
      print(referenceNumber);
      String storedReferenceNumber = prefs.getString('referenceNumber') ?? '';
      print("stored $storedReferenceNumber");
      if (referenceNumber == storedReferenceNumber) {
        final databaseReference = FirebaseDatabase.instance.reference();
        DatabaseEvent event = await databaseReference
            .child('card_responses')
            .child(referenceNumber)
            .once();
        DataSnapshot snapshot = event.snapshot;
        // Print the entire snapshot.value to understand its structure
        print('Snapshot Value: ${snapshot.value}');

        // Check if the snapshot exists and contains data

        if (snapshot.value != null) {
          Map<dynamic, dynamic>? data =
              snapshot.value as Map<dynamic, dynamic>?;
          int? cardSchemeId = data?['cardDetailResponse']?['cardSchemeId'];

          if (cardSchemeId != null) {
            print('Card Scheme Id: $cardSchemeId');
            await prefs!.setInt('cardSchemeId', cardSchemeId!);
          } else {
            print('Card Scheme Id not found in the snapshot.');
          }
        } else {
          print('Reference number not found.');
        }
      } else {
        // Show a dialog box to create a digital card
        showDialog(
          context: context, // You'll need to pass the context to this function
          builder: (context) => AlertDialog(
            title: Text('Create Digital Card'),
            content: Text('First, create a digital card.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK'),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  void notification_FD() {
    notificationServices.getDeviceToken().then((value) async {
      var data = {
        'to': value.toString(),
        'priority': 'high',
        'notification': {
          'title': 'Slingone',
          'body': 'Open a FD',
          "sound": "windchime.mp3"
        },
        // 'android': {
        //   'notification': {
        //     'notification_count': 23,
        //   },
        // },
        // 'data' : {
        //   'type' : 'msj' ,
        //   'id' : 'Asif Taj'
        // }
      };

      await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
          body: jsonEncode(data),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization':
                'key=AAAAd2FTt9k:APA91bHEX1w3KaiJCSVfo6yxtaA9qyfOh9AqodXOFtkmjIdc7J_tMzl760nLGgTkvaYAScMQVTcXcC-icHl0I3Z4p_fTRZUFXWgUwnVHYVRGB9b5LF4HVdyYa-dTX5ayzCNhiv6ZCLcb'
          }).then((value) {
        if (kDebugMode) {
          print("sucess" + value.body.toString());
        }
      }).onError((error, stackTrace) {
        if (kDebugMode) {
          print("error$error");
        }
      });
    });
  }

  void notification_loan() {
    notificationServices.getDeviceToken().then((value) async {
      var data = {
        'to': value.toString(),
        'priority': 'high',
        'notification': {
          'title': 'Slingone',
          'body': 'Apply For a Loan',
          "sound": "windchime.mp3"
        },
        // 'android': {
        //   'notification': {
        //     'notification_count': 23,
        //   },
        // },
        // 'data' : {
        //   'type' : 'msj' ,
        //   'id' : 'Asif Taj'
        // }
      };

      await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
          body: jsonEncode(data),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization':
                'key=AAAAd2FTt9k:APA91bHEX1w3KaiJCSVfo6yxtaA9qyfOh9AqodXOFtkmjIdc7J_tMzl760nLGgTkvaYAScMQVTcXcC-icHl0I3Z4p_fTRZUFXWgUwnVHYVRGB9b5LF4HVdyYa-dTX5ayzCNhiv6ZCLcb'
          }).then((value) {
        if (kDebugMode) {
          print("sucess" + value.body.toString());
        }
      }).onError((error, stackTrace) {
        if (kDebugMode) {
          print("error$error");
        }
      });
    });
  }

  Future<void> getReferenceNumberFromSharedPreferences() async {
    var sharedPreferences = await SharedPreferences.getInstance();
    referenceNumber = sharedPreferences.getString('referenceNumber') ?? '';

    if (referenceNumber.isNotEmpty) {
      makeGetRequest(referenceNumber);
    } else {
      setState(() {
        loadAmount = 0;
      });
    }
  }

  Future<void> makeGetRequest(String referenceNumber) async {
    var sharedPreferences = await SharedPreferences.getInstance();
    var token = sharedPreferences.getString('token');

    var url = Uri.parse(
        'https://issuanceapis-uat.pinelabs.com/v1/cards/balances/$referenceNumber');

    var headers = {
      'accept': 'application/json',
      'authorization': 'Bearer $token',
    };

    var response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      setState(() {
        loadAmount = data['loadAmount'];
      });
      print(response.body);
      print("loadamount$loadAmount");
    } else {
      setState(() {
        loadAmount = 0;
      });
    }
  }

  void showInternetConnectionDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('NO Internet Connection'),
          content: const Text(
              'Try Turning on your WIFI or MOBILEDATA for using the App'),
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
                    const SizedBox(
                      width: 20,
                    ),
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
    if (mounted) {
      setState(() {
        flag = true;
        isLoading = false;
      });
    }
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

//  void _scrollListener() {
//     ///final screenWidth = MediaQuery.of(context).size.width;
//     final containerWidth = 150.0;
//     final itemWidth = containerWidth + 8;
//     final index = (_scrollController.offset / itemWidth).round();
//     if (activeIndex != index) {
//       setState(() {
//         activeIndex = index;
//       });
//     }
//     print(" active index$activeIndex");
//     print(" index $index");
//   }
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
          (context) => const bottomsheetpage(),
          elevation: 10,
          backgroundColor: Colors.transparent,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    notifire = Provider.of<ColorNotifire>(context, listen: true);
    return WillPopScope(
      onWillPop: () async {
        final timegap = DateTime.now().difference(pre_backpress);
        final cantExit = timegap >= Duration(seconds: 2);
        pre_backpress = DateTime.now();
        if (cantExit) {
          //show snackbar
          final snack = SnackBar(
            content: Text('Press Back button again to Exit'),
            duration: Duration(seconds: 2),
          );
          ScaffoldMessenger.of(context).showSnackBar(snack);
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
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
                      Text(
                        '${username ?? "Guest"}',
                        style: TextStyle(
                            color: notifire.getdarkscolor,
                            fontSize: height / 40,
                            fontFamily: 'Gilroy Bold'),
                      ),
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
                          builder: (context) => const Notificationindex(
                              CustomStrings.notification),
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
                                padding: EdgeInsets.symmetric(
                                    horizontal: width / 20),
                                child: Row(
                                  children: [
                                    Text(
                                      CustomStrings.totalcardbalance,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: height / 50,
                                          fontFamily: 'Gilroy Medium'),
                                    ),
                                    const Spacer(),
                                    Column(
                                      children: [
                                        Image.asset(
                                          "images/rupay.png",
                                          height: height / 45,
                                          fit: BoxFit.contain,
                                        ),
                                        Text(
                                          CustomStrings.rupaycard,
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
                                              "$loadAmount",
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
                                                generateToken('payvoy.uatuser',
                                                    'X4oVUECF9EWhX9');
                                                // Navigator.push(
                                                //   context,
                                                //   MaterialPageRoute(
                                                //     builder: (context) =>
                                                //        const  CardDetails(),
                                                //   ),
                                                // );
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
                                              " Debit card",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontFamily: "Gilroy Bold",
                                                  color: notifire.getdarkscolor,
                                                  fontSize: height / 65),
                                            ),
                                          ],
                                        ),
                                        Positioned(
                                          top: -5,
                                          right: 15,
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
                                                  offset:
                                                      const Offset(4.0, 4.0),
                                                  blurRadius: 16.0,
                                                ),
                                              ],
                                            ),
                                            // A text widget with some style
                                            child: Text(
                                              'Sling',
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
                                          "Add Money",
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
                                                    const personalloan(),
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
                                          "Apply for a Loan",
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
                                          "Open a FD",
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
              const SizedBox(
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
                  height: height / 7,
                  width: width,
                  child: GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.only(bottom: height / 15),
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: height / 9,
                        mainAxisExtent: height / 8,
                        childAspectRatio: 4 / 2,
                        crossAxisSpacing: height / 30,
                        mainAxisSpacing: height / 50,
                      ),
                      itemCount: img.length,
                      itemBuilder: (BuildContext ctx, index) {
                        return GestureDetector(
                          onTap: () {
                            if (index == 0) {
                              // Get.to(() => const SlingStore());
                              navigator!.push(MaterialPageRoute(
                                builder: (context) => const sling_storemain(),
                              ));
                            } else if (index == 3) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Page1(),
                                ),
                              );
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
                                    height: height / 20,
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
                height: height / 100,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width / 18),
                child: Row(
                  children: [
                    Text(
                      CustomStrings.giftcardsection,
                      style: TextStyle(
                          fontFamily: "Gilroy Bold",
                          color: notifire.getdarkscolor,
                          fontSize: height / 40),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: height / 60,
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: 10, left: width / 20, right: width / 20),
                child: Container(
                  height: height / 2.5,
                  width: width,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 239, 251, 253),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      Container(
                        height: height / 30,
                        width: width, // Adjust the width as needed
                        // Add your content for the first child here
                        child: SizedBox(),
                      ),
                      // SizedBox(
                      //   height: height / 90,
                      // ),
                      Expanded(
                        child: GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.only(bottom: height / 20),
                          gridDelegate:
                              SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: height / 9,
                            mainAxisExtent: height / 8,
                            childAspectRatio: 3 / 2,
                            crossAxisSpacing: height / 30,
                            mainAxisSpacing: height / 30,
                          ),
                          itemCount: giftimg.length,
                          itemBuilder: (BuildContext ctx, index) {
                            return GestureDetector(
                              onTap: () {
                                if (index == 7) {
                                  navigator!.push(MaterialPageRoute(
                                      builder: (context) => buyvoucher()));
                                } else {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => giftofferform(
                                            icon: giftimg[index],
                                            storename: giftname[index],
                                            discount: giftdiscount[index]),
                                      ));
                                }
                              },
                              child: Column(
                                children: [
                                  giftdiscount[index].isNotEmpty
                                      ? Container(
                                          height: 15,
                                          width: 50,
                                          decoration: BoxDecoration(
                                            color: Colors.amber[300],
                                            borderRadius:
                                                BorderRadius.circular(2),
                                          ),
                                          child: Center(
                                            child: Text(
                                              "${giftdiscount[index]}% Off",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontFamily: "Gilroy Bold",
                                                color: notifire.getdarkscolor,
                                                fontSize: height / 55,
                                              ),
                                            ),
                                          ),
                                        )
                                      : SizedBox(),
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
                                        giftimg[index],
                                        height: height / 20,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: height / 90,
                                  ),
                                  Center(
                                    child: Text(
                                      giftname[index],
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: "Gilroy Bold",
                                        color: notifire.getdarkscolor,
                                        fontSize: height / 55,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      Container(
                        height: height / 25,
                        width: width, // Adjust the width as needed
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          ),
                          child: Container(
                            color: const Color.fromARGB(255, 142, 219, 145),
                            child: Center(
                              child: Text(
                                'Instant Discount. No Limits. 100+ Brands!',
                                style: TextStyle(
                                  color: notifire.getdarkscolor,
                                  fontSize: height / 55,
                                  fontFamily: 'Gilroy Bold',
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(
                height: height / 40,
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
              SizedBox(
                height: 230,
                child: Column(
                  children: [
                    Expanded(
                      flex: 1,
                      child: imageUrls.length == 0
                          ? Center(child: CircularProgressIndicator())
                          : (isConnected && imageUrls.isNotEmpty)
                              ? ListView.builder(
                                  controller: _scrollController,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: imageUrls.length,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () => _onImageTap(index),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5.0),
                                        child: Container(
                                          width: 150,
                                          //height: 200,
                                          margin: EdgeInsets.only(
                                              left: index != 0 ? 10.0 : 0.0),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            child: buildImageWidget(
                                                imageUrls[index]),
                                          ),
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
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 5.0),
                                            child: Container(
                                              width: 150,
                                              margin: EdgeInsets.only(
                                                  left:
                                                      index != 0 ? 10.0 : 0.0),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                child: buildImageWidget(
                                                    localImageUrls[index]),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    )
                                  : const Center(
                                      child: CircularProgressIndicator()),
                    ),
                    SizedBox(height: height / 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List<Widget>.generate(
                        isConnected ? imageUrls.length : localImageUrls.length,
                        (int index) {
                          bool isActive = (index == activeIndex);
                          bool isImageUrl =
                              (isConnected && index < imageUrls.length);

                          return AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            margin: const EdgeInsets.symmetric(horizontal: 3.0),
                            height: 7.0,
                            width: isActive ? 7.0 : 7.0,
                            decoration: BoxDecoration(
                              color: isActive ? Colors.blue : Colors.grey,
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: height / 80),
              //add here indicator
              SizedBox(
                height: height / 80,
              ),
              const SizedBox(
                height: 200,
                //width: width-30,
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
                height: height / 7.8,
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
                        // if (index == 0) {
                        //   Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //       builder: (context) =>
                        //           const Notificationindex(CustomStrings.cashback),
                        //     ),
                        //   );
                        // } else if (index == 1) {
                        //   Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //       builder: (context) => const HelpSupport(
                        //         "Refer A Friend",
                        //       ),
                        //     ),
                        //   );
                        // } else
                        if (index == 0) {
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
            ],
          ),
        ),
        // backgroundColor: notifire.getprimerycolor,
        //   body: PageStorage(
        //     bucket: bucket,
        //     child: currentScreen,
        //   ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: notifire.getbluecolor,
          child: Image.asset(
            "images/scan1.png",
            height: height / 30,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const Scan(),
              ),
            );
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
        resizeToAvoidBottomInset: false,
        bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          notchMargin: 10,
          child: Container(
            color: notifire.getprimerydarkcolor,
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: width / 30,
                    ),
                    MaterialButton(
                      minWidth: 40,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Home(),
                            ));
                        setState(
                          () {
                            currentScreen = const Home();
                            currentTab = 0;
                          },
                        );
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          currentTab == 0
                              ? Image.asset(
                                  "images/home1.png",
                                  height: height / 34,
                                  color: notifire.getbluecolor,
                                )
                              : Image.asset(
                                  "images/home.png",
                                  height: height / 33,
                                  color: notifire.getdarkscolor,
                                ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: width / 20,
                    ),
                    MaterialButton(
                      minWidth: 40,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Analytics(),
                            ));
                        setState(
                          () {
                            currentScreen = const Analytics();
                            currentTab = 1;
                          },
                        );
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          currentTab == 1
                              ? Image.asset(
                                  "images/order1.png",
                                  height: height / 33,
                                  color: notifire.getbluecolor,
                                )
                              : Image.asset("images/variant.png",
                                  height: height / 33,
                                  color: notifire.getdarkscolor),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MaterialButton(
                      minWidth: 40,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const MyCard(),
                            ));
                        setState(
                          () {
                            currentScreen = const MyCard();
                            currentTab = 3;
                          },
                        );
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          currentTab == 3
                              ? Image.asset(
                                  "images/wallet.png",
                                  height: height / 30,
                                  color: notifire.getbluecolor,
                                )
                              : Image.asset("images/message1.png",
                                  height: height / 30,
                                  color: notifire.getdarkscolor),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: width / 20,
                    ),
                    MaterialButton(
                      minWidth: 40,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Profile(),
                            ));
                        setState(
                          () {
                            currentScreen = const Profile();
                            currentTab = 4;
                          },
                        );
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          currentTab == 4
                              ? Image.asset(
                                  "images/profile1.png",
                                  height: height / 30,
                                  color: notifire.getbluecolor,
                                )
                              : Image.asset("images/profile.png",
                                  height: height / 30,
                                  color: notifire.getdarkscolor),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: width / 30,
                    ),
                  ],
                ),
              ],
            ),
          ),
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
      return FadeInImage.assetNetwork(
        placeholder: 'asset/images/loading.gif',
        image: imageUrl,
        fit: BoxFit.cover,
        width: height * 0.15,
        height: height * 0.15,
      );
      // return Image.network(
      //   imageUrl,
      //   fit: BoxFit.cover,
      //   width: height * 0.15,
      //   height: height * 0.15,
      // );
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

  String responseMessage = '';

  Future<void> generateToken(String username, String apiKey) async {
    AuthController authController = AuthController();

    try {
      String? token = await authController.generateToken(username, apiKey);

      setState(() {
        responseMessage =
            'Debit card for Token generated successfully. Refresh Token: $token';
      });
      print(token);
      // Navigate to the next screen
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const CardDetails()),
      );
      print(responseMessage);
    } catch (e) {
      setState(() {
        responseMessage = 'Error: $e';
      });
      print(responseMessage);
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(responseMessage),
          content: const Text('An error occurred. Please try again later.'),
          actions: [
            TextButton(
              onPressed: () {
                // Exit the app
                //Navigator.of(context).pop();
                SystemNavigator.pop();
                // exit(0);//forcefully terminate app to background
              },
              child: const Text('Exit'),
            ),
            TextButton(
              onPressed: () {
                // Retry the token generation
                generateToken(username, apiKey);
                Navigator.of(context).pop();
              },
              child: const Text('Retry'),
            ),
          ],
        ),
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
