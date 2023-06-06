import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gobank/slingsaverclub/offerwidgets.dart';

class OfferDetailsPage extends StatefulWidget {
  final String imageUrl;
  final int currentindex;
  const OfferDetailsPage({Key? key,required this.imageUrl,required this.currentindex}) : super(key: key);

  @override
  State<OfferDetailsPage> createState() => _OfferDetailsPageState();
}

class _OfferDetailsPageState extends State<OfferDetailsPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.imageUrl);
    print(widget.currentindex);
  }
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      //   elevation: 0,
      //   leading: Row(
      //     children: [
      //       Icon(Icons.arrow_back_ios_new,color: Colors.black,),
      //       Text("Back",style: TextStyle(color: Colors.black),),
      //     ],
      //   ),
      // ),
      body: _buildPageContent(),
    );
  }
  Widget _buildPageContent() {
    if (widget.currentindex==0) {
      // Customize UI for image1.jpg
      return Container(
        // Custom UI for image1.jpg
        child: offer1widget(),
      );
    } else if (widget.currentindex==1) {
      // Customize UI for image2.jpg
      return Container(
        // Custom UI for image2.jpg
        child:offer2widget(),
      );
    }
    else if (widget.currentindex==2) {
      // Customize UI for image2.jpg
      return Container(
        // Custom UI for image2.jpg
        child: offer3widget(),
      );
    }
    else if (widget.currentindex==3) {
      // Customize UI for image2.jpg
      return Container(
        // Custom UI for image2.jpg
        child: offer4widget(),
      );
    }
    else if (widget.currentindex==4) {
      // Customize UI for image2.jpg
      return Container(
        // Custom UI for image2.jpg
        child: offer5widget(),
      );
    }
    else if (widget.currentindex==5) {
      // Customize UI for image2.jpg
      return Container(
        // Custom UI for image2.jpg
        child: offer6widget(),
      );
    }
    else if (widget.currentindex==6) {
      // Customize UI for image2.jpg
      return Container(
        // Custom UI for image2.jpg
        child: offer7widget(),
      );
    }
     else {
      // Default UI for other images
      return Container(
        // Default UI
        child: Center(child: Text('Image Details')),
      );
    }
  }
}



