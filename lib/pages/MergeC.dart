import 'package:flutter/material.dart';

class mC extends StatefulWidget {
  const mC({Key? key}) : super(key: key);

  @override
  State<mC> createState() => _mCState();
}

class _mCState extends State<mC> {
  @override
  Widget build(BuildContext context) {
    var Managevalue = true;
    return Container(
      color: Colors.black,
      height: 200,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Manage Channels',
            style: TextStyle(fontSize: 20),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Ecommerce'),
              Switch(
                value: Managevalue,
                onChanged: (value) {
                  setState(() {
                    print(value);
                    Managevalue = value;
                  });
                },
              ),
            ],
          ),
          const Divider(
            color: Colors.black,
            thickness: 1,
          ),
          // Add any additional content or buttons here
        ],
      ),
    );
  }
}
