import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/colornotifire.dart';

class InputPin extends StatefulWidget {
  const InputPin({Key? key}) : super(key: key);

  @override
  State<InputPin> createState() => _InputPinState();
}

class _InputPinState extends State<InputPin> {
  late ColorNotifire notifire;

  @override
  Widget build(BuildContext context) {
    notifire = Provider.of<ColorNotifire>(context, listen: true);
    return Scaffold(
      backgroundColor: notifire.getprimerycolor,

    );
  }

}
