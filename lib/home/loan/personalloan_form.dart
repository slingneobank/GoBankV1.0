// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as fc;
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:gobank/home/loan/eligibility_loan.dart';
import 'package:gobank/home/loan/pendingapproval.dart';
import 'package:gobank/utils/colornotifire.dart';
import 'package:gobank/utils/media.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';
// import 'package:video_player/video_player.dart';
// import 'package:chewie/chewie.dart';

class personalloan_form extends StatefulWidget {
  const personalloan_form({Key? key}) : super(key: key);

  @override
  State<personalloan_form> createState() => _personalloan_formState();
}

class _personalloan_formState extends State<personalloan_form> {
  TextEditingController pan_number = TextEditingController();
  TextEditingController dob = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController uniname = TextEditingController();
  String PanSelect = "Select Pan Card ";
  String AadhaarSelect = "Select Aadhaar Card ";
  late ColorNotifire notifire;
  late DatabaseReference databaseReference;
  String approval = "pending for approval";

  String aadhaarImagePath = '';
  String panImagePath = '';
  // late VideoPlayerController _videoPlayerController;
  // late ChewieController _chewieController;
  @override
  void initState() {
    super.initState();

    // _videoPlayerController = VideoPlayerController.asset(
    //     'vecteezy_payment-promissory-note-animation-for-transaction-pen_8105890_118.mp4');
    // _chewieController = ChewieController(
    //   videoPlayerController: _videoPlayerController,
    //   looping: true, // Set looping to true
    //   autoInitialize: true,
    //   autoPlay: true,
    //   showControls: false,
    // );
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
    //
    var aadhaarImage;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration:
            const BoxDecoration(color: Color.fromARGB(255, 238, 233, 233)),
        child: Column(
          children: [
            Expanded(
                flex: 1,
                child: Container(
                  // decoration: BoxDecoration(color: Color.fromARGB(255, 238, 233, 233)),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: Row(
                            // crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Icon(
                                    Icons.arrow_back,
                                    size: 25,
                                  )),
                              Text(
                                "Help",
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: height / 35,
                                    fontFamily: 'Gilroy bold'),
                              ),
                            ],
                          ),
                        ),
                        Image.asset("asset/images/download.jpg",
                            //cobver all remaining space
                            // width: width * 0.9,
                            height: height * 0.25,
                            fit: BoxFit.fitHeight),
                      ],
                    ),
                  ),
                )),
            Expanded(
              flex: 2,
              child: Container(
                height: height * 0.7,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    )),
                child: Padding(
                  padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Enter your details",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: notifire.getdarkscolor,
                                fontSize: height / 40,
                                fontFamily: 'Gilroy bold'),
                          ),
                          Text(
                            "We need to create best offer for you!",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: notifire.getdarkscolor,
                                fontSize: height / 50,
                                fontFamily: 'Gilroy medium'),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                TextFormField(
                                  controller: pan_number,
                                  decoration: InputDecoration(
                                    labelText: 'Pan Number',
                                    labelStyle: TextStyle(
                                        fontFamily: "Gilroy medium",
                                        color: notifire.getdarkgreycolor,
                                        fontSize: height / 45),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                          color: notifire.getdarkgreycolor,
                                          style: BorderStyle.solid),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        color: notifire.getdarkgreycolor,
                                      ),
                                    ),
                                  ),
                                  style:
                                      TextStyle(color: notifire.getdarkscolor),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter a PAN number';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                TextFormField(
                                  controller: dob,
                                  decoration: InputDecoration(
                                    labelText: 'Date of Birth (DD/MM/YYYY)',
                                    labelStyle: TextStyle(
                                        fontFamily: "Gilroy medium",
                                        color: notifire.getdarkgreycolor,
                                        fontSize: height / 45),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                          color: notifire.getdarkgreycolor,
                                          style: BorderStyle.solid),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        color: notifire.getdarkgreycolor,
                                      ),
                                    ),
                                  ),
                                  style:
                                      TextStyle(color: notifire.getdarkscolor),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter date of birth';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                TextFormField(
                                  controller: email,
                                  decoration: InputDecoration(
                                    labelText: 'Email ID',
                                    labelStyle: TextStyle(
                                        fontFamily: "Gilroy medium",
                                        color: notifire.getdarkgreycolor,
                                        fontSize: height / 45),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                          color: notifire.getdarkgreycolor,
                                          style: BorderStyle.solid),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        color: notifire.getdarkgreycolor,
                                      ),
                                    ),
                                  ),
                                  style:
                                      TextStyle(color: notifire.getdarkscolor),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter a Email ID';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                TextFormField(
                                  controller: uniname,
                                  decoration: InputDecoration(
                                    labelText:
                                        'School or College or University Name',
                                    labelStyle: TextStyle(
                                        fontFamily: "Gilroy medium",
                                        color: notifire.getdarkgreycolor,
                                        fontSize: height / 45),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                          color: notifire.getdarkgreycolor,
                                          style: BorderStyle.solid),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        color: notifire.getdarkgreycolor,
                                      ),
                                    ),
                                  ),
                                  style:
                                      TextStyle(color: notifire.getdarkscolor),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter a School or College or University Name';
                                    }
                                    return null;
                                  },
                                ),
                                //
                                const SizedBox(
                                  height: 20,
                                ),

                                TextFormField(
                                  controller: aadhaarImage,
                                  decoration: InputDecoration(
                                    labelText: AadhaarSelect,
                                    labelStyle: TextStyle(
                                      fontFamily: "Gilroy medium",
                                      // color: notifire.getdarkgreycolor,
                                      fontSize: height / 45,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        // color: notifire.getdarkgreycolor,
                                        style: BorderStyle.solid,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                          // color: notifire.getdarkgreycolor,
                                          ),
                                    ),
                                  ),
                                  style:
                                      TextStyle(color: notifire.getdarkscolor),
                                  // validator: (value) {
                                  //   if (value!.isEmpty) {
                                  //     return 'Please select an Aadhaar card image';
                                  //   }
                                  //   return null;
                                  // },
                                  onTap: () async {
                                    final ImagePicker _picker = ImagePicker();
                                    final XFile? image = await _picker
                                        .pickImage(source: ImageSource.gallery);
                                    if (image != null) {
                                      // Handle the selected image here, e.g., save it to a variable or upload it
                                      // You can assign the selected image path to the controller like this:
                                      setState(() {
                                        aadhaarImagePath = image.path;
                                        AadhaarSelect = image.path;
                                        // aadhaarImage.text = AadhaarSelect;
                                      });
                                    }
                                  },

                                  readOnly: true, // Prevents manual text input
                                  keyboardType: TextInputType
                                      .text, // or TextInputType.image if you prefer
                                  // Add any additional properties or callbacks as needed
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                TextFormField(
                                  controller: aadhaarImage,
                                  decoration: InputDecoration(
                                    labelText: PanSelect,
                                    labelStyle: TextStyle(
                                      fontFamily: "Gilroy medium",
                                      // color: notifire.getdarkgreycolor,
                                      fontSize: height / 45,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        // color: notifire.getdarkgreycolor,
                                        style: BorderStyle.solid,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                          // color: notifire.getdarkgreycolor,
                                          ),
                                    ),
                                  ),
                                  onTap: () async {
                                    final ImagePicker _picker = ImagePicker();
                                    final XFile? image = await _picker
                                        .pickImage(source: ImageSource.gallery);
                                    if (image != null) {
                                      // Handle the selected image here, e.g., save it to a variable or upload it
                                      // You can assign the selected image path to the controller like this:
                                      setState(() {
                                        panImagePath = image.path;
                                        PanSelect = image.path;
                                      });
                                    }
                                  },

                                  readOnly: true, // Prevents manual text input
                                  keyboardType: TextInputType
                                      .text, // or TextInputType.image if you prefer
                                  // Add any additional properties or callbacks as needed
                                ),
                                const SizedBox(
                                  height: 20,
                                ),

                                //
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Text(
                              "All loan related documents will be sent here",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: notifire.getdarkgreycolor,
                                  fontSize: height / 55,
                                  fontFamily: 'Gilroy medium'),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            height: 50,
                            width: width - 20,
                            child: OutlinedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  saveFormData();
                                   }
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
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.blue),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        10), // Set a circular border radius
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

    Query query = reference
        .child("personal_loan")
        .orderByChild("pan_number")
        .equalTo(panNumber);

    try {
      DataSnapshot snapshot =
          await query.once().then((snapshot) => snapshot.snapshot);
    
      if (snapshot.value != null) {
        Map<dynamic, dynamic> loanData =
            (snapshot.value as Map<dynamic, dynamic>).values.first;
        String loanApprovalStatus = loanData['loan_approval'];
        if (loanApprovalStatus == 'rejected') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const eligibility_loan(),
            ),
          );
          pan_number.text = '';
          dob.text = '';
          email.text = '';
          uniname.text = '';
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const pendingapproval(),
            ),
          );
          pan_number.text = '';
          dob.text = '';
          email.text = '';
          uniname.text = '';
        }
      } else {
        // If PAN number is unique, save the form data
        DatabaseReference databaseReference =
            reference.child("personal_loan").push();
        databaseReference.set({
          "pan_number": panNumber,
          "date_of_birth": dateOfBirth,
          "email_address": emailAddress,
          "university_name": universityName,
          'loan_approval': approval,
        });
        submitForm();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Form data saved successfully!'),
          ),
        );

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const pendingapproval(),
          ),
        );

        pan_number.text = '';
        dob.text = '';
        email.text = '';
        uniname.text = '';
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to save form data.${error.toString()}'),
        ),
      );
    }
  }

  void submitForm() async {
    try {
      FirebaseStorage storage = FirebaseStorage.instance;
      Reference storageReference = storage.ref();

      String panNo = pan_number.text;

      String aadhaarFileName = panNo + 'Aadhar.jpg';
      File aadhaarImageFile = File(aadhaarImagePath);
      TaskSnapshot aadhaarUploadTask = await storageReference
          .child(aadhaarFileName)
          .putFile(aadhaarImageFile);
      String aadhaarImageUrl = await aadhaarUploadTask.ref.getDownloadURL();

      String panFileName = panNo + 'Pan.jpg';
      File panImageFile = File(panImagePath);
      TaskSnapshot panUploadTask =
          await storageReference.child(panFileName).putFile(panImageFile);
      String panImageUrl = await panUploadTask.ref.getDownloadURL();

      // Now you have the download URLs for both images
      // You can save them to Firebase Database or perform any other actions

      // Example: Saving the URLs to Firestore
      fc.FirebaseFirestore firestore = fc.FirebaseFirestore.instance;
      fc.CollectionReference imagesCollection = firestore.collection('images');
      await imagesCollection.add({
        'aadhaarImageUrl': aadhaarImageUrl,
        'panImageUrl': panImageUrl,
      });

      // Reset the form or perform other actions after successful submission
    } catch (e) {
      // Handle any errors that occur during the upload process
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to save form data.${e.toString()}')));
    }
  }
}
