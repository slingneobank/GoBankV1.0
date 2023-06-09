import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:gobank/login/verifyOTP.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/media.dart';

class MyPhone extends StatefulWidget {
  const MyPhone({Key? key}) : super(key: key);
  static String verify = '';

  @override
  State<MyPhone> createState() => _MyPhoneState();
}

class _MyPhoneState extends State<MyPhone> {
  TextEditingController countryController = TextEditingController();
  var phone = "";
   bool isLoading = false;
  FirebaseAuth auth=FirebaseAuth.instance;
  @override
  void initState() {
  
    countryController.text = "+91";
    super.initState();
    setState(() {
      isLoading=false;
    });
  }
  // @override
  // void dispose() {
  //   setState(() {
  //     isLoading = false;
  //   });
  //   super.dispose();
  // }
   
Future<void> savePhoneNumber(String phoneNumber) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('phone_number', phoneNumber);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(left: 25, right: 25),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/img1.png',
                width: 150,
                height: 150,
              ),
              const SizedBox(
                height: 25,
              ),
              const Text(
                "Phone Verification",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "We need to register your phone without getting started!",
                style: TextStyle(
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                height: 55,
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: 40,
                      child: TextField(
                        controller: countryController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const Text(
                      "|",
                      style: TextStyle(fontSize: 33, color: Colors.grey),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: TextField(
                      onChanged: (value) {
                        phone = value;
                      },
                       inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                  LengthLimitingTextInputFormatter(10),
                                ],
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Phone",
                      ),
                    ))
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                height: 45,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff2D2D3A),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    onPressed: () async {
                       
                      try{
                        setState(() {
                            isLoading = true;
                          });
                      await savePhoneNumber(countryController.text + phone);
                      await FirebaseAuth.instance.verifyPhoneNumber(
                        phoneNumber: countryController.text + phone,
                        
                        verificationCompleted:
                            (PhoneAuthCredential credential) async{
                              await auth.signInWithCredential(credential);
                            },
                        verificationFailed: (FirebaseAuthException e) {
                           ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Verification failed. Please try again later."),
                            ),
                          );
                        },
                        codeSent: (String verificationId, int? resendToken) {
                          MyPhone.verify = verificationId;
                          // FirebaseAuth auth=FirebaseAuth.instance;
                          //   if(auth.currentUser!=null)
                          //   {
                          //     sp!.setBool("skip", true);
                          //   }
                           ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("OTP successfully sent"),
                              ),
                            );
                          print("code sent"
                              );
                          saveLoggedInStatus(true);
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>  const MyVerify()),
                          );
                        },
                        codeAutoRetrievalTimeout: (String verificationId) {},
                      );
                      }catch(e)
                      {
                         // Handle exceptions during phone number verification

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Error sending OTP. Please try again later."),
                          ),
                        );
                      }
                    },
                    child: isLoading
                         ? CircularProgressIndicator() 
                         : Text("Send the code")),
              )
            ],
          ),
        ),
      ),
    );
  }
}
