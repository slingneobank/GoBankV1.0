import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
class CustomCardView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AndroidView(
      viewType: 'custom_card_view',
      creationParams: {},
      creationParamsCodec: const StandardMessageCodec(),
    );
  }
}
class showcard extends StatelessWidget {
  const showcard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: CustomCardView(),
        ),
    );
  }
}




