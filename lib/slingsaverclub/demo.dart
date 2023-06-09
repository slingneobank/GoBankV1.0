import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class ListViewWithSideIndicator1 extends StatefulWidget {
  @override
  _ListViewWithSideIndicator1State createState() =>
      _ListViewWithSideIndicator1State();
}

class _ListViewWithSideIndicator1State extends State<ListViewWithSideIndicator1> {
  late ScrollController _scrollController;
  int _currentIndex = 0;

  final FirebaseStorage storage = FirebaseStorage.instance;
  final String folderPath = 'offer_images'; // Path to your Firebase Storage folder
  List<String> imageUrls = [];
  bool flag=false;
  @override
  
  Future<void> fetchImageUrls() async {
  imageUrls = await getImageUrls(); // Wait for the asynchronous operation to complete
  print(imageUrls.length); 
  setState(() {
    
  });
  } 
  Future<List<String>> getImageUrls() async {

  try {
    final Reference ref = storage.ref().child(folderPath);
    final ListResult result = await ref.listAll();

    if (result.items.isNotEmpty) {
      for (final Reference imageRef in result.items) {
        final String downloadUrl = await imageRef.getDownloadURL();
        imageUrls.add(downloadUrl);
        setState(() {
          
        });
        print(imageUrls);

      }
      flag=true;
      setState(() {
        
      });
    } else {
      print('No images found in the specified folder.');
    }
  } catch (e) {
    print('Error getting image URLs: $e');
  }

  return imageUrls;
}
  @override
  void initState() {
    super.initState();
    fetchImageUrls();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    final screenWidth = MediaQuery.of(context).size.width;
    final containerWidth = 150.0; // Updated container width
    final itemWidth = containerWidth + 8; // Adjusted item width including margin
    final index = (_scrollController.offset / itemWidth).round();
    if (_currentIndex != index) {
      setState(() {
        _currentIndex = index;
      });
    }
  }

  void _changeIndex(int index) {
    setState(() {
      _currentIndex = index;
      _scrollController.animateTo(
        index * 158.0, // Updated container width
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
         Container(
                height: 200,
                child: flag
                    ? 
                    ListView.builder(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              itemCount: imageUrls.length,
              itemBuilder: (context, index) {
                //print(imageUrls.length);
                print(_currentIndex);
                return GestureDetector(
                  
                  onTap: () => _changeIndex(index),
                  child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                              child: Row(
                                children: [
                                  Container(
                                    width: 140,
                                    height: 200,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10.0),
                                      child: Image.network(
                                        imageUrls[index],
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                ],
                              ),
                            ),
                );
              },
            )
            : Center(child: CircularProgressIndicator()),
          ),
          Container(
                height: 5,
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: imageUrls.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () => _changeIndex(index),
                            child: CircleAvatar(
                              radius: _currentIndex == index ? 7 : 5,
                              backgroundColor: _currentIndex == index ? Colors.blue : Colors.black,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
          


        ],
      ),
    );
  }
}