import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gobank/utils/media.dart';
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
     getReferenceNumber();
    fetchData();
  }
  Future<String?> _getAuthorizationToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    return token;
  }

  Future<void> getReferenceNumber() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? number = prefs.getString('referenceNumber');
    setState(() {
      referenceNumber = number;
    });
  }
 Future<void> fetchData() async {
  String? token = await _getAuthorizationToken();
  if (token == null) {
    setState(() {
      responseMessage = 'Authorization token not found';
    });
    return;
  }
  try {
    final response = await http.get(
      // Uri.parse('https://issuanceapis-uat.pinelabs.com/v1/cards/transactions/$referenceNumber'),
      Uri.parse('https://issuanceapis-uat.pinelabs.com/v1/cards/transactions/7818167833'),
      headers: {
        'accept': 'application/json',
        'authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final dynamic transactionData = jsonData['transactions'];

      if (transactionData != null && transactionData is List<dynamic>) {
        setState(() {
          transactions = transactionData.map((data) => Transaction.fromJson(data)).toList();
          isLoading = false;
        });
      } else {
        // Handle the case when there are no transactions
        setState(() {
          transactions = []; // Set an empty list
          isLoading = false;
          responseMessage = jsonData['responseMessage'] ?? '';
        });
        print(responseMessage);
      }
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
          "Transcation History",
          style: TextStyle(
            fontFamily: "Gilroy medium",
            color: Colors.white,
            fontSize: height / 35,
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
      gradient: LinearGradient(
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
      period: Duration(seconds: 2),
      child: ListTile(
        leading: CircleAvatar(
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
    if (transactions.isEmpty) {
      return Center(
        child: Text(
          'Transaction history not available',
          style: TextStyle(
            fontFamily: "Gilroy medium",
            color: Colors.white,
            fontSize: height / 45,
          ),
        ),
      );
    }

    return ListView.builder(
      itemCount: transactions.length,
      itemBuilder: (context, index) {
        final transaction = transactions[index];
        return ListTile(
          leading: CircleAvatar(
            child: Text(transaction.transactionType.toString()),
          ),
          title: Text('Amount: ${transaction.transactionAmount}'),
          subtitle: Text('Merchant: ${transaction.merchantName}'),
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
  final String merchantName;
  final String merchantCity;

  Transaction({
    required this.transactionDate,
    required this.transactionAmount,
    required this.transactionType,
    required this.invoiceNumber,
    required this.merchantName,
    required this.merchantCity,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      transactionDate: json['transactionDate'] ?? '',
      transactionAmount: json['transactionAmount'] ?? 0,
      transactionType: json['transactionType'] ?? 0,
      invoiceNumber: json['invoiceNumber'] ?? '',
      merchantName: json['merchantName'] ?? '',
      merchantCity: json['merchantCity'] ?? '',
    );
  }
}
