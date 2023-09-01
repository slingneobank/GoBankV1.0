import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import 'page_3.dart';

class Page2 extends StatefulWidget {
  const Page2({super.key, required this.phNum});
  final String phNum;

  @override
  State<Page2> createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  final Stream<QuerySnapshot> _dataStream =
      FirebaseFirestore.instance.collection('recharges').snapshots();

  Map<String, String> imageUrls = {};

  @override
  void initState() {
    super.initState();
    fetchImageUrls();
  }

  Future<void> fetchImageUrls() async {
    final snapshot =
        await FirebaseFirestore.instance.collection('recharges').get();

    for (final doc in snapshot.docs) {
      final imageName = doc.id.toLowerCase();
      final url = await getImageUrl('$imageName.png');

      setState(() {
        imageUrls[imageName] = url;
      });
    }
  }

  Future<String> getImageUrl(String imageName) async {
    final firebase_storage.Reference ref = firebase_storage
        .FirebaseStorage.instance
        .ref('recharges_assets/$imageName');
    final String downloadUrl = await ref.getDownloadURL();
    return downloadUrl;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;
    return Scaffold(
      backgroundColor: const Color(0xFF0d141c),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.keyboard_arrow_left_rounded,
            color: Colors.white,
            size: 30,
          ),
        ),
        title: const Text(
          'Select your Prepaid operator',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: height * 0.5,
            child: StreamBuilder<QuerySnapshot>(
              stream: _dataStream,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return const Text("Error");
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Text('Loading');
                } else {
                  List<String> documentNames =
                      snapshot.data!.docs.map((doc) => doc.id).toList();
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: documentNames.length,
                    itemBuilder: (context, index) {
                      final imageName = documentNames[index].toLowerCase();
                      return Container(
                        width: width * 0.9,
                        height: height * 0.12,
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: Colors.grey, width: 0.5),
                          ),
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Page3(
                                  phNum: widget.phNum,
                                  oprtr: documentNames[index],
                                ),
                              ),
                            );
                          },
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.transparent),
                            elevation: MaterialStateProperty.all(0),
                          ),
                          child: Row(
                            children: [
                              if (imageUrls.containsKey(imageName))
                                SizedBox(
                                  width: width * 0.16,
                                  child:
                                      Image.network(imageUrls[imageName] ?? ''),
                                ),
                              SizedBox(
                                width: width * 0.1,
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  documentNames[index].toUpperCase(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
          SizedBox(
            height: height * 0.1,
            child: ElevatedButton(
              style: ButtonStyle(
                overlayColor: MaterialStateProperty.all(Colors.transparent),
                backgroundColor: MaterialStateProperty.all(Colors.transparent),
                elevation: MaterialStateProperty.all(0),
              ),
              onPressed: () {},
              child: const Text(
                'I am a Postpaid User',
                style: TextStyle(color: Colors.greenAccent),
              ),
            ),
          )
        ],
      ),
    );
  }
}
