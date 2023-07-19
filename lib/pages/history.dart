import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

class TransactionHistoryPage extends StatefulWidget {
  const TransactionHistoryPage({Key? key}) : super(key: key);

  @override
  _TransactionHistoryPageState createState() => _TransactionHistoryPageState();
}

class _TransactionHistoryPageState extends State<TransactionHistoryPage> {
  bool isLoading = true;
  List<Transaction> transactions = [];
  String? referenceNumber;
  String responseMessage = '';

  @override
  void initState() {
    super.initState();
   
    getReferenceNumberFromSharedPreferences();
  }
Future<void> getReferenceNumberFromSharedPreferences() async {
  var sharedPreferences = await SharedPreferences.getInstance();
  referenceNumber = sharedPreferences.getString('referenceNumber');
  print(referenceNumber);
  if (referenceNumber != null ) {
    fetchData(referenceNumber!);
  } else {
    setState(() {
      isLoading = false;
      print("Reference Number is not available");
    });
  }
}

  Future<String?> _getAuthorizationToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    return token;
  }

  Future<void> fetchData(String referenceNumber) async {
    String? token = await _getAuthorizationToken();
    if (token == null) {
      setState(() {
        responseMessage = 'Authorization token not found';
      });
      return;
    }
    try {
      final response = await http.get(
        Uri.parse('https://issuanceapis-uat.pinelabs.com/v1/cards/transactions/$referenceNumber'),
        headers: {
          'accept': 'application/json',
          'authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        setState(() {
          final jsonData = jsonDecode(response.body);
          print(jsonData);
          final List<dynamic> transactionData = jsonData['transactionDetailList'];
          transactions = transactionData.map((data) => Transaction.fromJson(data)).toList();
          isLoading = false;
        });
      } else {
        throw Exception('Failed to fetch transaction history');
      }
    } catch (error) {
      setState(() {
        isLoading = false;
      });
      print('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black87,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new_sharp),
        ),
        title: Text(
          "Transaction History",
          style: TextStyle(
            fontFamily: "Gilroy medium",
            color: Colors.white,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              // Perform an action
            },
            icon: const Icon(Icons.candlestick_chart_rounded),
          ),
        ],
      ),
      body: isLoading ? showLoadingScreen() : showContent(),
    );
  }

  Widget showLoadingScreen() {
    return Shimmer(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Colors.grey,
          Colors.grey,
          Colors.black,
          Colors.grey,
          Colors.grey,
        ],
      ),
      period: const Duration(seconds: 2),
      child: ListTile(
        leading: const CircleAvatar(
          radius: 25,
          backgroundColor: Colors.grey,
        ),
        title: Container(
          width: double.infinity,
          height: 20,
          color: Colors.grey,
        ),
        subtitle: Container(
          width: double.infinity,
          height: 15,
          color: Colors.grey,
        ),
        trailing: Container(
          width: 70,
          height: double.infinity,
          color: Colors.grey,
        ),
      ),
    );
  }

  Widget showContent() {
    if (transactions.isEmpty || referenceNumber==null) {
      return Center(
        child: Text(
          'Transaction history not available',
          style: TextStyle(
            fontFamily: "Gilroy medium",
            color: Colors.white,
            fontSize: 14,
          ),
        ),
      );
    }

    return ListView.builder(
      itemCount: transactions.length,
      itemBuilder: (context, index) {
        final transaction = transactions[index];
        return Card(
          child: Container(
            height: 100,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   
                    Text('invoiceNumber:${transaction.invoiceNumber}',
                       style: TextStyle(
                       fontFamily: "Gilroy medium",
                       color: Colors.black,
                       fontSize: 14,
                     ),
                    ),
                    
                     Text('Amount: ${transaction.transactionAmount}',
                    style: TextStyle(
                      fontFamily: "Gilroy medium",
                      color: Colors.black,
                      fontSize: 14,
                    ),
                     ),
                     Text('transactionType: ${transaction.transactionType}',
                    style: TextStyle(
                      fontFamily: "Gilroy medium",
                      color: Colors.black,
                      fontSize: 14,
                    ),
                    ),
                    Text('transactionDate: ${transaction.transactionDate}',
                    style: TextStyle(
                      fontFamily: "Gilroy medium",
                      color: Colors.black,
                      fontSize: 14,
                    ),
                    ),
                  ],
                  ),
            ),
          ),
            
          
          
        );
      },
    );
  }
}

class Transaction {
  final String transactionDate;
  final double transactionAmount;
  final int transactionType;
  final String invoiceNumber;

  Transaction({
    required this.transactionDate,
    required this.transactionAmount,
    required this.transactionType,
    required this.invoiceNumber,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      transactionDate: json['transactionDate'] ?? '',
      transactionAmount: json['transactionAmount']?.toDouble() ?? 0.0,
      transactionType: json['transactionType'] ?? 0,
      invoiceNumber: json['invoiceNumber'] ?? '',
    );
  }
}
