
import 'package:flutter/material.dart';
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
  late ColorNotifire notifire;
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
                                SizedBox(height: 40,),  
                                Container(
                              height: 50,
                              width: width-20,
                              child: OutlinedButton(
                                  onPressed: () {
                                    // Add your onPressed logic here
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => personalloan_form(),));
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
            )
          ],
        ),
      ),
    );
  }
}