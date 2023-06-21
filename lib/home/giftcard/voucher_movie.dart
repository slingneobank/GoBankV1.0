import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gobank/utils/media.dart';

class voucher_movie extends StatefulWidget {
  const voucher_movie({Key? key}) : super(key: key);

  @override
  State<voucher_movie> createState() => _voucher_movieState();
}

class _voucher_movieState extends State<voucher_movie> {
   @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: SizedBox(
        height: 120,
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('voucher_movie')
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            List<QueryDocumentSnapshot> documents = snapshot.data!.docs;

            return Wrap(
              spacing: 15.0,
              runSpacing: 10.0,
              children: documents.map((document) {
                String discount = document['discount'];
                String iconimg = document['iconimg'];
                String imgurl = document['imgurl'];
                String storename = document['storename'];

                return Container(
                  width: 150,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 187, 229, 187),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: Stack(
                      children: [
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            height: 80,
                            width: 80,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15.0),
                              ),
                            ),
                            child: Image.network(
                              imgurl,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 20, left: 20, right: 10, bottom: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "$storename",
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: height / 40,
                                    fontFamily: 'Gilroy bold'),
                              ),
                              Container(
                                height: 20,
                                width: 70,
                                decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(5)),
                                child: Center(
                                  child: Text(
                                    "$discount",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: height / 45,
                                        fontFamily: 'Gilroy bold'),
                                  ),
                                ),
                              ),
                              SizedBox(height: 15),
                              Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(color: Colors.black45),
                                    borderRadius: BorderRadius.circular(5)),
                                child: SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: Image.network(
                                    iconimg,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }).toList(),
            );
          },
        ),
      ),
    );
  }
}
