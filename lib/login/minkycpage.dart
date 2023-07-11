import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gobank/login/auth_controller.dart';
import 'package:gobank/login/minnativekyclogin.dart';

import '../utils/media.dart';

class minkycpage extends StatefulWidget {
  const minkycpage({Key? key}) : super(key: key);

  @override
  State<minkycpage> createState() => _minkycpageState();
}

class _minkycpageState extends State<minkycpage> {
  bool isSelected = false;
  String responseMessage = '';
  bool isLoading = false;
  bool isDisposed = false; // Add a flag to track the widget's disposal

  @override
  void dispose() {
    super.dispose();
    isDisposed = true; // Set the flag to true when the widget is disposed
  }

  Future<void> generateToken(String username, String apiKey) async {
    AuthController authController = AuthController();
    setState(() {
      isLoading = true;
    });
    try {
      String? token = await authController.generateToken(username, apiKey);

      if (!isDisposed) {
        setState(() {
          responseMessage = 'Token generated successfully. Refresh Token: $token';
          isLoading = false;
        });
      }

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const minnativekyclogin()),
      );
      print(responseMessage);
    } catch (e) {
      if (!isDisposed) {
        setState(() {
          responseMessage = 'Error: $e';
          isLoading = false;
        });
      }

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(responseMessage),
          content: const Text('An error occurred. Please try again later.'),
          actions: [
            TextButton(
              onPressed: () {
                SystemNavigator.pop();
              },
              child: const Text('Exit'),
            ),
            TextButton(
              onPressed: () {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.arrow_back_outlined,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(''),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
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
                ? const AlwaysScrollableScrollPhysics()
                : const NeverScrollableScrollPhysics(),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    const SizedBox(height: 30),
                    const Text(
                      'Complete Account Setup',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'As per RBI Guidelines, you have to verify your identity to open your account',
                      style: TextStyle(fontSize: 15, color: Colors.grey),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    Container(
                      height: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.grey[200],
                      ),
                      child: ListTile(
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 20.0),
                        leading: Container(
                          width: 50.0,
                          height: 50.0,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: AssetImage('asset/images/adhar.png'),
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                        ),
                        title: const Text(
                          'Aadhar Card',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                        trailing: GestureDetector(
                          onTap: () {
                            setState(() {
                              isSelected = !isSelected;
                            });
                          },
                          child: Container(
                            width: 24.0,
                            height: 24.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: isSelected ? Colors.green : Colors.grey,
                            ),
                            child: const Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 16.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {},
                      child: const Center(
                        child: Text(
                          "Don't have an Aadhar card?",
                          style: TextStyle(color: Colors.amber),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'asset/images/adhar.png',
                          width: 25,
                          height: 25,
                        ),
                        const SizedBox(width: 10),
                        const Text(
                          'Trusted by 15 lakh families',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Gilroy',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'asset/images/adhar.png',
                          width: 25,
                          height: 25,
                        ),
                        const SizedBox(width: 10),
                        const Text(
                          'Takes one minute to complete',
                          style: TextStyle(
                            fontWeight: FontWeight.w100,
                            fontFamily: 'Gilroy',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 25),
                    const Center(
                      child: Text("Powered by"),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 25,
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: Image.asset('asset/images/adhar.png'),
                      ),
                    ),
                    const SizedBox(height: 80),
                    GestureDetector(
                      onTap: () {
                        generateToken('payvoy.uatuser', 'X4oVUECF9EWhX9');
                      },
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: isLoading
                              ? CircularProgressIndicator()
                              : Text(
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
            ),
          );
        },
      ),
    );
  }
}
