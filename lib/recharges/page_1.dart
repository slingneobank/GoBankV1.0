import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:task/page_2.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class Page1 extends StatefulWidget {
  const Page1({super.key});
  @override
  State<Page1> createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  final _controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late ImageProvider _cachedImage;
  bool _submitted = false;
  bool _imageLoaded = false;

  Future<String> getImageUrl(String imageName) async {
    final firebase_storage.Reference ref = firebase_storage
        .FirebaseStorage.instance
        .ref('recharges_assets/$imageName');
    final String downloadUrl = await ref.getDownloadURL();
    return downloadUrl;
  }

  Future<void> _loadImage() async {
    final imageUrl = await getImageUrl('banner.jpg');
    setState(() {
      _cachedImage = NetworkImage(imageUrl);
      _imageLoaded = true;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadImage();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFF0d141c),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.keyboard_arrow_left_rounded,
            color: Colors.white,
            size: 30,
          ),
        ),
        title: const Text(
          'Prepaid Recharge',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
      body: SizedBox(
        width: width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: width * 0.9,
              height: height * 0.25,
              margin: EdgeInsets.only(top: height * 0.05),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: _imageLoaded
                    ? Image(
                        image: _cachedImage,
                        fit: BoxFit.fill,
                      )
                    : const SizedBox.shrink(),
              ),
            ),
            Container(
              height: height * 0.1,
              width: width,
              padding: EdgeInsets.only(left: width * 0.05),
              child: const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Enter mobile number',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            Row(
              children: [
                Container(
                  height: height * 0.08,
                  width: width * 0.7,
                  margin: EdgeInsets.symmetric(horizontal: width * 0.05),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1c2029),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: width * 0.15,
                        child: const Center(
                          child: Text(
                            '+91',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height * 0.05,
                        child: const VerticalDivider(
                          color: Colors.grey,
                          width: 1,
                        ),
                      ),
                      SizedBox(
                        width: width * 0.5,
                        child: Form(
                          autovalidateMode: AutovalidateMode.always,
                          key: _formKey,
                          child: TextFormField(
                            validator: (value) {
                              if (_submitted) {
                                if (value!.isEmpty) {
                                  return 'Cannot be Empty';
                                }
                                if (!RegExp(r"^[6-9]\d{4} \d{5}$")
                                    .hasMatch(value)) {
                                  return 'Enter valid number';
                                }
                              }
                              return null;
                            },
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              IndianMobileNumberFormatter(),
                            ],
                            controller: _controller,
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 18,
                            ),
                            keyboardType: TextInputType.number,
                            maxLength: 11,
                            cursorWidth: 0.5,
                            cursorColor: Colors.grey,
                            decoration: InputDecoration(
                              fillColor: const Color(0xFF1c2029),
                              filled: true,
                              hintText: "00000 00000",
                              counterText: "",
                              errorStyle: const TextStyle(
                                color: Colors.red,
                              ),
                              contentPadding: EdgeInsets.only(
                                left: width * 0.05,
                              ),
                              hintStyle: const TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.normal,
                                fontSize: 18,
                              ),
                              focusedErrorBorder: const UnderlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                              errorBorder: const UnderlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                ),
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(15),
                                  bottomRight: Radius.circular(15),
                                ),
                              ),
                              enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                ),
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(15),
                                  bottomRight: Radius.circular(15),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: width * 0.15,
                  height: height * 0.08,
                  decoration: const BoxDecoration(
                    color: Color(0xFF1c2029),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.account_circle_outlined,
                      size: 24,
                      color: Colors.lightBlueAccent,
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: height * 0.3,
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _submitted = true;
                });
                if (_formKey.currentState?.validate() ?? false) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Page2(phNum: _controller.text),
                    ),
                  );
                }
              },
              child: const Text(
                'Continue',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class IndianMobileNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final newText = newValue.text.replaceAll(RegExp(r'\D'), '');
    final length = newText.length;

    if (length <= 5) {
      return TextEditingValue(
        text: newText,
        selection: TextSelection.collapsed(offset: length),
      );
    } else {
      return TextEditingValue(
        text: '${newText.substring(0, 5)} ${newText.substring(5)}',
        selection: TextSelection.collapsed(offset: length + 1),
      );
    }
  }
}
