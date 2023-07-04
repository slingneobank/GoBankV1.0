import 'package:flutter/material.dart';
import 'package:gobank/login/phone.dart';
import 'package:gobank/utils/colornotifire.dart';
import 'package:gobank/utils/media.dart';
import 'package:shared_preferences/shared_preferences.dart';
class logoutbottomsheet extends StatelessWidget {
  const logoutbottomsheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(30),
                                          topRight: Radius.circular(30),
                                        ),
                                    child: Container(
                                      height: 300,
                                      width: width,
                                      //padding: EdgeInsets.all(16),
                                      color: Colors.white,
                                      child: Column(
                                        //crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          
                                          InkWell(
                                                onTap: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Icon(Icons.expand_more,size: 50,),
                                              ),
                                          Text(
                                            'Log out of SlingStore?',
                                            style: TextStyle(
                                              fontFamily: "Gilroy Bold",
                                              color: Colors.black,
                                              fontSize: height / 35,
                                            ),
                                          ),
                                          SizedBox(height: 16),
                                          SizedBox(
                                            height: 100,
                                            width: 100,
                                            child: Image. asset('asset/images/close.jpg')),
                                          SizedBox(height: 16),
                                          CustomButton(),
                                          
                                        ],
                                      ),
                                    ),
                                  );
  }
}
class CustomButton extends StatefulWidget {
  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  String _selectedButton = '';

   Future<void> removePhoneNumber() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('phone_number');
  }
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width - 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            height: height / 12,
            width: width / 3,
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  _selectedButton = 'Cancel';
                });
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                primary: _selectedButton == 'Cancel' ? Colors.black : Colors.white,
                onPrimary: _selectedButton == 'Cancel' ? Colors.white : Colors.black,
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              ),
              child: Text(
                'Cancel',
                style: TextStyle(
                   fontFamily: "Gilroy Bold",
                    fontSize: height / 40,
                  color: _selectedButton == 'Cancel' ? Colors.white : Colors.black,
                ),
              ),
            ),
          ),
          Container(
            height: height / 12,
            width: width / 3,
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  _selectedButton = 'Logout';
                });
                removePhoneNumber();
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => MyPhone(),));
              },
              style: ElevatedButton.styleFrom(
                primary: _selectedButton == 'Logout' ? Colors.black : Colors.white,
                onPrimary: _selectedButton == 'Logout' ? Colors.white : Colors.black,
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              ),
              child: Text(
                'Logout',
                style: TextStyle(
                  fontFamily: "Gilroy Bold",
                  fontSize: height / 40,
                  color: _selectedButton == 'Logout' ? Colors.white : Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
