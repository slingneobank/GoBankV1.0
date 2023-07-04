import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class sling_storeshopessential extends StatefulWidget {
  const sling_storeshopessential({Key? key}) : super(key: key);

  @override
  State<sling_storeshopessential> createState() => _sling_storeshopessentialState();
}

class _sling_storeshopessentialState extends State<sling_storeshopessential> {
  late ScrollController _scrollController;
  int _currentPage = 0;
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    setState(() {
      _currentPage = (_scrollController.offset / 115).round(); //140
    });
  }
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: SizedBox(
        height: 230,
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('sling_store_shopEssentials')
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            List<QueryDocumentSnapshot> documents = snapshot.data!.docs;
           // _currentPage = _currentPage.clamp(0, documents.length.toDouble() - 1).toInt();

            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      controller: _scrollController,
                      itemCount: documents.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot document = documents[index];
                        String imageUrl = document['imageurl'];
                        print(imageUrl);
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: Container(
                            width: 150, // Set the desired width here //170
                            margin: EdgeInsets.only(left: index != 0 ? 10.0 : 0.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: Image.network(
                                imageUrl,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        );
                      },
                    )
                ),
                const SizedBox(
                  height: 20,
                ),
                
                Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List<Widget>.generate(documents.length, (int index) {
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 3.0),
                    height: 7.0,
                    width: _currentPage == index ? 7.0 : 7.0,
                    decoration: BoxDecoration(
                      color: _currentPage == index ? Colors.white : Colors.grey,
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  );
                }
                ),
                )
              ],
            );
          },
        ),
      ),
    );
  }

}