import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gobank/login/auth_controller.dart';
import 'package:gobank/login/minnativekycotp.dart';

import 'package:shared_preferences/shared_preferences.dart';

class minnativekyclogin extends StatefulWidget {
  const minnativekyclogin({Key? key}) : super(key: key);

  @override
  State<minnativekyclogin> createState() => _minnativekycloginState();
}

class _minnativekycloginState extends State<minnativekyclogin> {
    final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  String _response = '';
  String _mobile = '';
  String _username = '';
  String _email = '';

   @override
  void dispose() {
    _usernameController.dispose();
    _mobileController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        // leading: IconButton(
        //   onPressed: () {},
        //   icon: Icon(
        //     Icons.arrow_back_outlined,
        //     color: Colors.black,
        //   ),
        // ),
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Profile Section',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.card_giftcard,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          bool _hasContentOverflow =
              constraints.maxHeight < MediaQuery.of(context).size.height;
          return SingleChildScrollView(
            physics: _hasContentOverflow
                ? AlwaysScrollableScrollPhysics()
                : NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(20, 10, 10, 30),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    'Enter details carefully',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 4.0),
                                child: Container(
                                  height: 50.0,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                                    child: TextFormField(
                                      controller: _usernameController,
                                      decoration: InputDecoration(
                                        hintText: 'Username(can be different than FullName)',
                                        contentPadding:
                                            EdgeInsets.only(top: 12.0, bottom: 8.0),
                                        border: InputBorder.none,
                                      ),
                                      maxLength: 40,
                                      onChanged: (value) {
                                        _username = value;
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 8.0),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 4.0),
                                child: Container(
                                  height: 50.0,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                                    child: TextFormField(
                                      controller: _mobileController,
                                      decoration: InputDecoration(
                                        contentPadding:
                                            EdgeInsets.only(top: 12.0, bottom: 8.0),
                                        hintText: 'Mobile No.',
                                        border: InputBorder.none,
                                      ),
                                      maxLength: 10,
                                      keyboardType: TextInputType.number,
                                      onChanged: (value) {
                                        _mobile = "+91" + value;
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 8.0),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 4.0),
                                child: Container(
                                  height: 50.0,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                                    child: TextFormField(
                                      controller: _emailController,
                                      decoration: InputDecoration(
                                        hintText: 'Email',
                                        contentPadding:
                                            EdgeInsets.only(top: 12.0, bottom: 8.0),
                                        border: InputBorder.none,
                                      ),
                                      maxLength: 40,
                                      onChanged: (value) {
                                        _email = value;
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                  // Expanded(child: SizedBox()),
                  GestureDetector(
                    onTap: () {
                      _makeApiCall();
                      // Navigator.push(context,
                      //     MaterialPageRoute(builder: (_) => minnativekycotp()));
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('next section')),
                      );
                    },
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          'Continue',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  
  Future<String?> _getAuthorizationToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    print(token);
    return token;
  }

  Future<void> _makeApiCall() async {
    String apiUrl = 'https://issuanceapis-uat.pinelabs.com/v1/kycs/mins/natives/initiate';

    String? token = await _getAuthorizationToken();
    if (token == null) {
      setState(() {
        _response = 'Authorization token not found';
      });
      return;
    }

    Map<String, String> headers = {
      'accept': 'application/json',
      'authorization': 'Bearer $token',
      'content-type': 'application/json',
    };

    dynamic requestBody = {
      "customerName": _usernameController.text,
      "email": _emailController.text,
      "mobileNumber": int.parse(_mobileController.text),
    };

    try {
      Map<String, dynamic> responseData = await AuthController.minnativekycphone(apiUrl, headers, requestBody);
    
      String minKycUniqueId = responseData['minKycUniqueId'];
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('minKycUniqueId', minKycUniqueId);

      setState(() {
        _response = responseData.toString();
      });
      print(_response);
      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => minnativekycotp()));
                          
    } catch (error) {
      setState(() {
        _response = 'Error in API call: $error';
      });
      print(_response);
        showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(_response),
          content: Text('An error occurred. Please try again later.'),
          actions: [
            TextButton(
              onPressed: () {
                // Exit the app
                Navigator.of(context).pop();
                //SystemNavigator.pop(); 
               // exit(0);//forcefully terminate app to background
              },
              child: Text('Exit'),
            ),
            TextButton(
              onPressed: () {
                // Retry the token generation
                _makeApiCall();
                Navigator.of(context).pop();
              },
              child: Text('Retry'),
            ),
          ],
        ),
      );
    }
  }
}
