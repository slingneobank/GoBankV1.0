import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

final MethodChannel _methodChannel = MethodChannel('my_channel');

class CustomCardView extends StatefulWidget {
  const CustomCardView({super.key});

  @override
  State<CustomCardView> createState() => _CustomCardViewState();
}

class _CustomCardViewState extends State<CustomCardView> {
  bool _showCardDetails = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Card Details'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Card Details',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _toggleCardDetails,
              child: Text(_showCardDetails ? 'Hide Details' : 'Show Details'),
            ),
            SizedBox(height: 20),
            Visibility(
              visible: _showCardDetails,
              child: FutureBuilder<Map<String, dynamic>?>(
                  future: _getCardDetails(),
                  builder: (BuildContext context, AsyncSnapshot<Map<String, dynamic>?> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      final cardDetails = snapshot.data;
                      return Column(
                        children: [
                          Text('Card Number: ${cardDetails?['cardNumber'] ?? ''}'),
                          Text('Issue Date: ${cardDetails?['issueDate'] ?? ''}'),
                          Text('Expiry Date: ${cardDetails?['expiryDate'] ?? ''}'),
                          Text('CVV: ${cardDetails?['cvv'] ?? ''}'),
                        ],
                      );
                    }
                  },
                )

            ),
          ],
        ),
      ),
    );
  }

  void _toggleCardDetails() {
    setState(() {
      _showCardDetails = !_showCardDetails;
    });
  }

  Future<Map<String, dynamic>?> _getCardDetails() async {
    if (_showCardDetails) {
      try {
        await _methodChannel.invokeMethod('showCardDetails');
      } on PlatformException catch (e) {
        print('Error: ${e.message}');
        return null;
      }
    } else {
      try {
        await _methodChannel.invokeMethod('maskCardDetails');
      } on PlatformException catch (e) {
        print('Error: ${e.message}');
        return null;
      }
    }

    // Return dummy data for testing
    return {
      'cardNumber': '**** **** **** 1234',
      'issueDate': '01/22',
      'expiryDate': '12/25',
      'cvv': '***',
    };
  }
}
