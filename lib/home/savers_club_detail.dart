import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:gobank/utils/media.dart';
import 'package:google_fonts/google_fonts.dart';

class SaversClubDetail extends StatefulWidget {
  SaversClubDetail(this.data, {Key? key}) : super(key: key);
  Map data;

  @override
  State<SaversClubDetail> createState() => _SaversClubDetailState();
}

class _SaversClubDetailState extends State<SaversClubDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Row(children: [
            Icon(Icons.arrow_back_ios_new_rounded),
            Text(
              "Back",
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(color: Colors.white, fontSize: 12),
            ),
          ]),
        ),
        title: Text(
          "Sling-Store",
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
              color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
        actions: [
          Align(
            alignment: Alignment.center,
            child: Text(
              "My Orders",
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                  color: Colors.grey,
                  fontSize: 12,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.black,
      body: ListView(children: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            height: height / 2.4,
            decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.fill, image: NetworkImage(widget.data['image'])),
              color: Colors.yellow[300],
              borderRadius: BorderRadius.circular(12.0),
            ),
            // A text widget with some style and the index of the container
          ),
        ),
        if (widget.data["price"] != null) ...[
          Padding(
            padding: EdgeInsets.only(left: 15, right: width / 1.4),
            child: Container(
              height: height / 18,
              constraints: const BoxConstraints(
                maxWidth: 10,
              ),
              decoration: BoxDecoration(
                color: Colors.yellow[300],
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Center(
                  child: Text(
                widget.data["price"] == ""
                    ? "Rs.0"
                    : '\u{20B9}' + widget.data["price"],
                style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.8),
              )),
              // A text widget with some style and the index of the container
            ),
          ),
        ],
        if (widget.data["price"] != null) ...[
          Padding(
            padding: EdgeInsets.only(left: 15, top: 15),
            child: Text(
              widget.data["name"] == "" ? "Product Name" : widget.data["name"],
              style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.8),
            ),
          ),
        ],
        Padding(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Text(
            widget.data["desc"],
            // "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
            textAlign: TextAlign.justify,
            style: GoogleFonts.poppins(
                color: Colors.grey,
                fontSize: 16,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.8),
          ),
        ),

        //!BUTTON FOR BUYING IF SHOP
        if (widget.data["price"] != null) ...[
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              height: height / 18,
              decoration: BoxDecoration(
                color: Colors.yellow[300],
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Center(
                  child: Text(
                "Place Order",
                style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.8),
              )),
              // A text widget with some style and the index of the container
            ),
          ),
        ]
      ]),
    );
  }
}
