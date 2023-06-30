
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:gobank/home/loan/eligibility_loan.dart';
import 'package:gobank/home/loan/pendingapproval.dart';
import 'package:gobank/home/topup/topupcard/topup.dart';
import 'package:gobank/utils/colornotifire.dart';
import 'package:gobank/utils/media.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class personalloan_form extends StatefulWidget {
  const personalloan_form({Key? key}) : super(key: key);

  @override
  State<personalloan_form> createState() => _personalloan_formState();
}

class _personalloan_formState extends State<personalloan_form> {
  TextEditingController pan_number=TextEditingController();
  TextEditingController dob=TextEditingController();
  TextEditingController email=TextEditingController();
  TextEditingController uniname=TextEditingController();
  
  late ColorNotifire notifire;
  late DatabaseReference databaseReference;
  String approval="pending for approval";
  @override
  void initState() {
    super.initState();
    databaseReference = FirebaseDatabase.instance.reference();
  }

  final _formKey = GlobalKey<FormState>();
   getdarkmodepreviousstate() async {
    final prefs = await SharedPreferences.getInstance();
    bool? previusstate = prefs.getBool("setIsDark");
    if (previusstate == null) {
      notifire.setIsDark = false;
    } else {
      notifire.setIsDark = previusstate;
    }
  }
  @override
  Widget build(BuildContext context) {
     notifire = Provider.of<ColorNotifire>(context, listen: true);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Color.fromARGB(255, 238, 233, 233)),
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Container(
               // decoration: BoxDecoration(color: Color.fromARGB(255, 238, 233, 233)),
              child: Padding(
                padding: const EdgeInsets.only(top: 25,bottom: 5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20,right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(Icons.arrow_back)),
                          
                                Text("Help",
                                overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: height / 40,
                                    fontFamily: 'Gilroy bold'),
                                    ),
                              ],
                            ),
                          ),
                        
                        
                      ],
                    ),
                  ),
               )
              ),
            Expanded(
              flex: 2,
              child: Container(
                height: height,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                    )
                ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20,left: 20,right: 20),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text("Enter your details",
                                    overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: notifire.getdarkscolor,
                                        fontSize: height / 40,
                                        fontFamily: 'Gilroy bold'),
                                  ),
                             Text("We need to create best offer for you!",
                                    overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: notifire.getdarkscolor,
                                        fontSize: height / 50,
                                        fontFamily: 'Gilroy medium'),
                                  ),
                                  SizedBox(height: 20,),
                                  Form(
                                      key: _formKey,
                                      child: Column(
                                        children: [
                                          TextFormField(
                                           controller: pan_number,
                                            decoration: InputDecoration(
                                              labelText: 'Pan Number',
                                              labelStyle: TextStyle(fontFamily: "Gilroy medium",
                                              color: notifire.getdarkgreycolor,
                                              fontSize: height / 45),
                                            
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                color: notifire.getdarkgreycolor,
                                                style: BorderStyle.solid
                                                ),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(10),
                                              borderSide: BorderSide(color: notifire.getdarkgreycolor,),
                                            ),
                                          ),
                                        style: TextStyle(color:notifire.getdarkscolor),
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'Please enter a PAN number';
                                              }
                                              return null;
                                            },
                                          ),
                                          SizedBox(height: 20,),
                                          TextFormField(
                                           controller: dob,
                                            decoration: InputDecoration(
                                              labelText: 'Date of Birth (DD/MM/YYYY)',
                                              labelStyle: TextStyle(fontFamily: "Gilroy medium",
                                              color: notifire.getdarkgreycolor,
                                              fontSize: height / 45),
                                            
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                color: notifire.getdarkgreycolor,
                                                style: BorderStyle.solid
                                                ),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(10),
                                              borderSide: BorderSide(color: notifire.getdarkgreycolor,),
                                            ),
                                          ),
                                        style: TextStyle(color:notifire.getdarkscolor),
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'Please enter date of birth';
                                              }
                                              return null;
                                            },
                                          ),
                                          SizedBox(height: 20,),
                                          TextFormField(
                                           controller: email,
                                            decoration: InputDecoration(
                                              labelText: 'Email ID',
                                              labelStyle: TextStyle(fontFamily: "Gilroy medium",
                                              color: notifire.getdarkgreycolor,
                                              fontSize: height / 45),
                                            
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                color: notifire.getdarkgreycolor,
                                                style: BorderStyle.solid
                                                ),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(10),
                                              borderSide: BorderSide(color: notifire.getdarkgreycolor,),
                                            ),
                                          ),
                                        style: TextStyle(color:notifire.getdarkscolor),
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'Please enter a Email ID';
                                              }
                                              return null;
                                            },
                                          ),
                                          SizedBox(height: 20,),
                                          TextFormField(
                                           controller: uniname,
                                            decoration: InputDecoration(
                                              labelText: 'School or College or University Name',
                                              labelStyle: TextStyle(
                                              fontFamily: "Gilroy medium",
                                              color: notifire.getdarkgreycolor,
                                              fontSize: height / 45),
                                            
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                color: notifire.getdarkgreycolor,
                                                style: BorderStyle.solid
                                                ),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(10),
                                              borderSide: BorderSide(color: notifire.getdarkgreycolor,),
                                            ),
                                          ),
                                        style: TextStyle(color:notifire.getdarkscolor),
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'Please enter a School or College or University Name';
                                              }
                                              return null;
                                            },
                                          ),
                                        ],
                                      ),
                                  ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: Text("All loan related documents will be sent here",
                                      overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          color: notifire.getdarkgreycolor,
                                          fontSize: height / 55,
                                          fontFamily: 'Gilroy medium'),
                                    ),
                                ),
                                  SizedBox(height: 10,),  
                                  Container(
                                height: 50,
                                width: width-20,
                                child: OutlinedButton(
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                          saveFormData();
                                          // Here you can navigate to another page or perform any action after saving the form data
                                         
                                        }
                                          // pan_number.text='';
                                          // dob.text='';
                                          // email.text='';
                                          // uniname.text='';
                                      },
                                    child: Text(
                                      'Proceed for Offer Confirmation',
                                      style: TextStyle(
                                        color: notifire.getdarkwhitecolor,
                                        fontSize: height / 40,
                                        fontFamily: 'Gilroy bold',
                                      ),
                                    ),
                                    style: ButtonStyle(
                                          backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(10), // Set a circular border radius
                                            ),
                                          ),
                                        ),
                                  ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void saveFormData() async {
  String panNumber = pan_number.text;
  String dateOfBirth = dob.text;
  String emailAddress = email.text;
  String universityName = uniname.text;

  // Check if the PAN number already exists in the database
  DatabaseReference reference = FirebaseDatabase.instance.reference();

  Query query = reference.child("personal_loan").orderByChild("pan_number").equalTo(panNumber);

  try {
    DataSnapshot snapshot = await query.once().then((snapshot) => snapshot.snapshot);
    Map<dynamic, dynamic> loanData = (snapshot.value as Map<dynamic, dynamic>).values.first;
      String loanApprovalStatus = loanData['loan_approval'];
    if (snapshot.value != null) {
      if(loanApprovalStatus=='rejected')
                    {
                      Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => eligibility_loan(),
                      ),
                    );
                    pan_number.text='';
                  dob.text='';
                  email.text='';
                  uniname.text='';
                    }
                    else
                    {
                        Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => pendingapproval(),
                        
                      ),
                    );
                    pan_number.text='';
                  dob.text='';
                  email.text='';
                  uniname.text='';
                    }
                  // showDialog(
                  //   context: context,
                  //   builder: (BuildContext context) {
                  //     return AlertDialog(
                  //       title: Text("Duplicate Record"),
                  //       content: Text("You have already applied for a personal loan."),
                  //       actions: [
                  //         TextButton(
                  //           child: Text("OK"),
                  //           onPressed: () {
                  //             Navigator.of(context).pop();
                              
                  //             // pan_number.text='';
                  //             // dob.text='';
                  //             // email.text='';
                  //             // uniname.text='';
                  //           },
                  //         ),
                  //       ],
                  //     );
                      
                  //   },
                  // );
            } else {
              // If PAN number is unique, save the form data
              DatabaseReference databaseReference = reference.child("personal_loan").push();
              databaseReference.set({
                "pan_number": panNumber,
                "date_of_birth": dateOfBirth,
                "email_address": emailAddress,
                "university_name": universityName,
                'loan_approval':approval,
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Form data saved successfully!'),
                ),
              );
              
                  Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => pendingapproval(),
                ),
              );
              
              
              pan_number.text='';
              dob.text='';
              email.text='';
              uniname.text='';
            }
          } catch (error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Failed to save form data.'),
              ),
            );
          }
        }

}