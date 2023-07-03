import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gobank/pages/digitalcard.dart';
import 'package:gobank/pages/history.dart';
import 'package:gobank/pages/physicalcard.dart';
import 'package:gobank/utils/colornotifire.dart';
import 'package:gobank/utils/media.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class CardDetails extends StatefulWidget {
  const CardDetails({Key? key}) : super(key: key);

  @override
  State<CardDetails> createState() => _CardDetailsState();
}

class _CardDetailsState extends State<CardDetails> {
  late ColorNotifire notifire;
  var blockUnblockCardValue = false;
  var mergeChannelsValue = false;
  double _sliderValue = 500;
  String referenceNumber = '9255511767';
  
  bool manageValue = true;
  @override
  void initState() {
    super.initState();
    notifire = ColorNotifire(); // Initialize the notifire variable
    getdarkmodepreviousstate();
    getReferenceNumberFromSharedPreferences();
  }
   void _setSliderValue(BuildContext context, double value) {
    setState(() {
      _sliderValue = value;
    });
  }

  void _cancelSelection() {
    // Implement the cancel logic here
  }

  void _confirmSelection() {
    // Implement the confirm logic here
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
  void makeAPIRequest(String referenceNumber) async {
    var apiUrl = 'https://issuanceapis-uat.pinelabs.com/v1/cards/attributes/states/update';
    String? token = await _getAuthorizationToken();
    if (token == null) {
      setState(() {
        responseMessage = 'Authorization token not found';
      });
      return;
    }

    var headers = {
      'accept': 'application/json',
      'authorization': 'Bearer $token',
      'content-type': 'application/json',
    };

    var body = {
      'referenceNumber': referenceNumber,
      'cardState': manageValue ? 1 : 3,
    };

    var response = await http.post(Uri.parse(apiUrl), headers: headers, body: jsonEncode(body));

    if (response.statusCode == 200) {
      // API request successful
      var responseBody = response.body;
      // Process the response body as needed
      print(responseBody);
    } else {
      // API request failed
      print('API request failed with status code: ${response.statusCode}');
    print('Response body: ${response.body}');
    print('Response headers: ${response.headers}');

    }
  }

 
  Future<void> getReferenceNumberFromSharedPreferences() async {
    var sharedPreferences = await SharedPreferences.getInstance();
    referenceNumber = sharedPreferences.getString('referenceNumber') ?? '9255511767';
   

    if (referenceNumber.isNotEmpty) {
       makeAPIRequest(referenceNumber);
    } else {
      setState(() {
        setState(() {
      print("Reference Number is not available");
    });
      });
    }
  }
  Future<String?> _getAuthorizationToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    print(token);
    return token;
  }

  Map<String, dynamic> cardSchemes = {};
  String responseMessage = '';
  int responseCode = 0;

  Future<void> getCardSchemes() async {
    final url = Uri.parse('https://issuanceapis-uat.pinelabs.com/v1/cards/schemes');
    
    String? token = await _getAuthorizationToken();
    if (token == null) {
      setState(() {
        responseMessage = 'Authorization token not found';
      });
      return;
    }

    final headers = {
      'accept': 'application/json',
      'authorization': 'Bearer $token',
    };

    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
     setState(() {
        responseMessage = jsonResponse.toString();
        if (jsonResponse['cardSchemes'] != null && jsonResponse['cardSchemes'].isNotEmpty) {
          cardSchemes = jsonResponse['cardSchemes'][0];
          int cardSchemeId = cardSchemes['cardSchemeId'];
          print(cardSchemeId);
          saveCardSchemeId(cardSchemeId);
        }
      });
      print(jsonResponse);
      navigator!.push(MaterialPageRoute(builder: (context) => const digitalcard(),));
      return jsonResponse;
    } else {
      throw Exception('Failed to load card schemes');
    }
  }

  Future<void> saveCardSchemeId(int cardSchemeId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('cardSchemeId', cardSchemeId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        leading: IconButton(
          onPressed: () {
          Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new_sharp),
        ),
        centerTitle: true,
        title:  Text('Card Details',
                style: TextStyle(fontFamily: "Gilroy Bold",
                           color: notifire.getdarkwhitecolor,
                           fontSize: height / 35),),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.headset_mic)),
        ],
      ),
      body: Container(
        color: notifire.getdarkscolor,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final h = constraints.maxHeight;
            final w = constraints.maxWidth;
            
            return Column(
              children: [
                const SizedBox(height: 10,),
                SizedBox(
                  height: h * 0.5,
                  child: Image.asset("card2.jpg"),
                ),
                SizedBox(
                  height: h * 0.1,
                  width: w * 0.9,
                  child: Card(
                    color: notifire.getdarkscolor,
                    child: Column(
                      children: [
                         Text("Get Insights into your spends!",
                         style: TextStyle(fontFamily: "Gilroy medium",
                           color: notifire.gettabwhitecolor,
                           fontSize: height / 45)),
                        Expanded(
                          child: TextButton(
                            onPressed: () {
                              getCardSchemes();
                            },
                            child:  Text("Generate a Card",style: TextStyle(fontFamily: "Gilroy Bold",
                           color: notifire.gettabwhitecolor,
                           fontSize: height / 40)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                      // height: h * 0.29,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 10,
                              left: 10,
                              right: 10,
                            ),
                            child: Card(
                              color: const Color.fromARGB(255, 55, 59, 78),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: ListTile(
                                title:  Text("Order Card",
                                style: TextStyle(fontFamily: "Gilroy medium",
                                    color: notifire.gettabwhitecolor,
                                    fontSize: height / 45),
                                    ),
                                trailing: IconButton(
                                  onPressed: () {
                                   // Navigator.pushNamed(context, '/physicalcard');
                                   navigator!.push(MaterialPageRoute(builder: (context) => const physicalcard(),));
                                  },
                                  icon:  Icon(Icons.arrow_forward_ios,color: notifire.gettabwhitecolor,),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 10,
                              left: 10,
                              right: 10,
                            ),
                            child: Card(
                              color: const Color.fromARGB(255, 55, 59, 78),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: ListTile(
                                title:  Text(
                                  "Transaction History",
                                style: TextStyle(fontFamily: "Gilroy medium",
                                    color: notifire.gettabwhitecolor,
                                    fontSize: height / 45),
                                ),
                                trailing: IconButton(
                                  onPressed: () {
                                   // Navigator.pushNamed(context, '/history');
                                    navigator!.push(MaterialPageRoute(builder: (context) => const TransactionHistoryPage(),));
                                  },
                                  icon:  Icon(Icons.arrow_forward_ios,color: notifire.gettabwhitecolor,),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 10,
                              left: 10,
                              right: 10,
                            ),
                            child: Card(
                              color: const Color.fromARGB(255, 55, 59, 78),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: ListTile(
                                title:  Text("Card Settings",
                                style: TextStyle(fontFamily: "Gilroy medium",
                                    color: notifire.gettabwhitecolor,
                                    fontSize: height / 45),
                                    ),
                                trailing: IconButton(
                                  onPressed: () {
                                    showModalBottomSheet(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Container(
                                          height: 300,
                                          color: notifire.getdarkscolor,
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 20,
                                          ),
                                          width: double.infinity,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                               Text(
                                                "Card Settings",
                                                style: TextStyle(
                                                  color: const Color.fromARGB(
                                                    255,
                                                    135,
                                                    145,
                                                    197,
                                                  ),
                                                  fontFamily: "Gilroy medium",
                                                  fontSize: height / 25, 
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              ListTile(
                                                tileColor: const Color.fromARGB(
                                                  255,
                                                  55,
                                                  59,
                                                  78,
                                                ),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                contentPadding:
                                                    const EdgeInsets.symmetric(
                                                  vertical: 8,
                                                  horizontal: 16,
                                                ),
                                                title:  Text(
                                                  "Block/Unblock Card",
                                                  style: TextStyle(
                                                    fontFamily: "Gilroy medium",
                                                    color: notifire.gettabwhitecolor,
                                                    fontSize: height / 45
                                                  ),
                                                ),
                                                trailing: IconButton(
                                                  onPressed: () {
                                                    showModalBottomSheet(
                                                      context: context,
                                                      builder:
                                                          (BuildContext context) {
                                                       
      
                                                        return Container(
                                                          color: Colors.black,
                                                          height: 200,
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                               Text(
                                                                'Block/Unblock Card',
                                                                style: TextStyle(
                                                                  fontFamily: "Gilroy medium",
                                                                  color: notifire.gettabwhitecolor,
                                                                  fontSize: height / 45
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                height: 16,
                                                              ),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                   Text(
                                                                    'Virtual Card',
                                                                     style: TextStyle(
                                                                  fontFamily: "Gilroy medium",
                                                                  color: notifire.gettabwhitecolor,
                                                                  fontSize: height / 45
                                                                    ),
                                                                  ),
                                                                  Switch(
                                                                    activeColor: Colors.amber,
                                                                    value: manageValue,
                                                                    onChanged: (value) {
                                                                      setState(() {
                                                                        manageValue = value;
                                                                      });
                                                                      getReferenceNumberFromSharedPreferences();
                                                                    },
                                                                  ),
                        
                                                                ],
                                                              ),
                                                              const SizedBox(
                                                                height: 16,
                                                              ),
                                                               Text(
                                                                "All your card services will be unblocked till you switch it off from the app. You can block it anytime you want.",
                                                                 style: TextStyle(
                                                                  fontFamily: "Gilroy medium",
                                                                  color: notifire.gettabwhitecolor,
                                                                  fontSize: height / 45
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        );
                                                      },
                                                    );
                                                  },
                                                  icon: const Icon(
                                                    Icons.arrow_forward_ios,
                                                  ),
                                                  color: Colors.white,
                                                ),
                                              ),
                                              ListTile(
                                                tileColor: const Color.fromARGB(
                                                  255,
                                                  55,
                                                  59,
                                                  78,
                                                ),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                contentPadding:
                                                    const EdgeInsets.symmetric(
                                                  vertical: 8,
                                                  horizontal: 16,
                                                ),
                                                title:  Text(
                                                  "Setting Up Limit",
                                                   style: TextStyle(
                                                       fontFamily: "Gilroy medium",
                                                        color: notifire.gettabwhitecolor,
                                                          fontSize: height / 45
                                                        ),
                                                ),
                                                trailing: IconButton(
                                                  onPressed: () {
                                                    showModalBottomSheet(
                                                      
                                                      context: context,
                                                      builder:
                                                          (BuildContext context) {
                                                        return Container(
                                                          color: Colors.black87,
                                                          padding:
                                                              const EdgeInsets.all(16),
                                                          child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize.min,
                                                            children: [
                                                              Text(
                                                                'Selected Value: ${_sliderValue.toInt()}',
                                                                 style: TextStyle(
                                                                  fontFamily: "Gilroy medium",
                                                                  color: notifire.gettabwhitecolor,
                                                                  fontSize: height / 45
                                                                ),
                                                              ),
                                                              Slider(
                                                                activeColor: Colors.amber,
                                                                value:
                                                                    _sliderValue,
                                                                min: 500,
                                                                max: 100000,
                                                                divisions: 995,
                                                                onChanged:
                                                                    (value) {
                                                                  _setSliderValue(
                                                                    context,
                                                                    value,
                                                                  );
                                                                },
                                                              ),
                                                              ElevatedButton(
                                                                style: OutlinedButton.styleFrom(backgroundColor: Colors.amber),
                                                                onPressed:
                                                                    _confirmSelection,
                                                                child: Text(
                                                                  'Confirm',
                                                                   style: TextStyle(
                                                                  fontFamily: "Gilroy medium",
                                                                  color: notifire.getdarkscolor,
                                                                  fontSize: height / 50
                                                                ),
                                                                ),
                                                              ),
                                                              ElevatedButton(
                                                                style: OutlinedButton.styleFrom(backgroundColor: Colors.amber),
                                                                onPressed:
                                                                    _cancelSelection,
                                                                child: Text(
                                                                  'Cancel',
                                                                   style: TextStyle(
                                                                  fontFamily: "Gilroy medium",
                                                                  color: notifire.getdarkscolor,
                                                                  fontSize: height / 50
                                                                ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        );
                                                      },
                                                    );
                                                  },
                                                  icon: const Icon(
                                                    Icons.arrow_forward_ios,
                                                  ),
                                                  color: Colors.white,
                                                ),
                                              ),
                                              ListTile(
                                                tileColor: const Color.fromARGB(
                                                  255,
                                                  55,
                                                  59,
                                                  78,
                                                ),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                contentPadding:
                                                    const EdgeInsets.symmetric(
                                                  vertical: 8,
                                                  horizontal: 16,
                                                ),
                                                title: const Text(
                                                  "Merge Channels",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                trailing: IconButton(
                                                  onPressed: () {
                                                    showDialog(
                                                      context: context,
                                                      builder:
                                                          (BuildContext context) {
                                                        return AlertDialog(
                                                          
                                                          title: const Text(
                                                            "Merge Channels",
                                                          ),
                                                          content: Column(
                                                            mainAxisSize:
                                                                MainAxisSize.min,
                                                            children: [
                                                              MergeC(
                                                                onChanged:
                                                                    (value) {
                                                                  setState(() {
                                                                    mergeChannelsValue =
                                                                        value;
                                                                  });
                                                                },
                                                                value:
                                                                    mergeChannelsValue,
                                                              ),
                                                            ],
                                                          ),
                                                          actions: <Widget>[
                                                            TextButton(
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              child: const Text(
                                                                "Cancel",
                                                              ),
                                                            ),
                                                            TextButton(
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                    context);
                                                                // Perform merge action
                                                              },
                                                              child: const Text(
                                                                "Merge",
                                                              ),
                                                            ),
                                                          ],
                                                        );
                                                      },
                                                    );
                                                  },
                                                  icon: const Icon(
                                                    Icons.arrow_forward_ios,
                                                  ),
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  icon:  Icon(Icons.arrow_forward_ios,color: notifire.gettabwhitecolor,),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class MergeC extends StatefulWidget {
  final bool value;
  final Function(bool) onChanged;

  const MergeC({
    Key? key,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  @override
  _MergeCState createState() => _MergeCState();
}

class _MergeCState extends State<MergeC> {
  bool _value = false;

  @override
  void initState() {
    super.initState();
    _value = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.compare_arrows),
      title: const Text("Merge Channels"),
      trailing: Switch(
        value: _value,
        onChanged: (value) {
          setState(() {
            _value = value;
            widget.onChanged(value);
          });
        },
      ),
    );
  }
}
