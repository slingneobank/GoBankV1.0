import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'page_4.dart';

class Page3 extends StatefulWidget {
  const Page3({super.key, required this.phNum, required this.oprtr});
  final String phNum;
  final String oprtr;

  @override
  State<Page3> createState() => _Page3State();
}

class _Page3State extends State<Page3> {
  final Stream<QuerySnapshot> _dataStream =
      FirebaseFirestore.instance.collection('recharges').snapshots();
  final TextEditingController _searchController = TextEditingController();
  final _controller = ScrollController();
  bool _useBouncyPhysics = false;
  var fieldList = <String>[];
  var fieldDataMap = {};
  bool isDataLoaded = false;
  late ImageProvider _cachedImage;
  bool _imageLoaded = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_handleScroll);
    fetchData();
    _loadImage();
  }

  Future<void> _loadImage() async {
    final imageUrl = await getImageUrl('${widget.oprtr.toLowerCase()}.png');
    setState(() {
      _cachedImage = NetworkImage(imageUrl);
      _imageLoaded = true;
    });
  }

  Future<void> fetchData() async {
    final snapshot = await _dataStream.first;
    final tabData = snapshot.docs
        .where(
          (doc) => doc.id == widget.oprtr.toLowerCase(),
        )
        .toList();
    if (tabData.isNotEmpty) {
      final Map<String, dynamic> oprtrData =
          tabData[0].data() as Map<String, dynamic>;
      fieldList = oprtrData.keys.toList();
      for (var field in fieldList) {
        final List<Map<String, dynamic>> data = List.castFrom(oprtrData[field]);
        fieldDataMap[field] = data;
      }
      setState(() {
        isDataLoaded = true;
      });
    }
  }

  List<Map<String, dynamic>> getFieldDataForField(String field) {
    return fieldDataMap[field] ?? [];
  }

  Future<String> getImageUrl(String imageName) async {
    final firebase_storage.Reference ref = firebase_storage
        .FirebaseStorage.instance
        .ref('recharges_assets/$imageName');
    final String downloadUrl = await ref.getDownloadURL();
    return downloadUrl;
  }

  void _handleScroll() {
    if (_controller.position.pixels >=
        _controller.position.maxScrollExtent - 100) {
      setState(() {
        _useBouncyPhysics = true;
      });
    } else {
      setState(() {
        _useBouncyPhysics = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0XFF23272d),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFF0d141c),
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
        title: Text(
          '${widget.oprtr.toUpperCase()} Prepaid',
          style: const TextStyle(fontSize: 20.0, color: Colors.white),
        ),
      ),
      body: DefaultTabController(
        length: isDataLoaded ? fieldList.length : 1,
        child: NestedScrollView(
          controller: _controller,
          physics: _useBouncyPhysics
              ? const BouncingScrollPhysics()
              : const ClampingScrollPhysics(),
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverAppBar(
              automaticallyImplyLeading: false,
              backgroundColor: const Color(0xFF0d141c),
              elevation: 0,
              expandedHeight: height * 0.1,
              flexibleSpace: FlexibleSpaceBar(
                background: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            bottom: height * 0.03,
                            left: width * 0.05,
                            right: width * 0.05,
                          ),
                          child: SizedBox(
                            width: width * 0.1,
                            child: _imageLoaded
                                ? Image(
                                    image: _cachedImage,
                                    fit: BoxFit.fill,
                                  )
                                : const SizedBox.shrink(),
                          ),
                        ),
                        Text(
                          widget.phNum,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SliverAppBar(
              automaticallyImplyLeading: false,
              backgroundColor: const Color(0xFF0d141c),
              elevation: 0,
              pinned: true,
              toolbarHeight: height * 0.18,
              flexibleSpace: Container(
                margin: EdgeInsets.zero,
                decoration: const BoxDecoration(
                  color: Color(0XFF23272d),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.zero,
                      width: width,
                      height: height * 0.1,
                      padding: EdgeInsets.only(
                        top: height * 0.02,
                        left: width * 0.05,
                        right: width * 0.05,
                      ),
                      child: TextFormField(
                        onChanged: (text) {
                          setState(() {});
                        },
                        controller: _searchController,
                        textAlignVertical: TextAlignVertical.center,
                        style: const TextStyle(
                          color: Colors.grey,
                        ),
                        decoration: InputDecoration(
                          fillColor: Colors.black,
                          filled: true,
                          enabledBorder: UnderlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.transparent),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.transparent),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          prefixIcon: const Icon(
                            Icons.search,
                            color: Color(0XFF23272d),
                          ),
                          hintText: 'Search for plan or enter amount',
                          hintStyle: const TextStyle(
                            color: Color(0XFF23272d),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: width,
                      color: const Color(0XFF23272d),
                      child: Theme(
                        data: Theme.of(context).copyWith(
                          colorScheme: Theme.of(context).colorScheme.copyWith(
                                surfaceVariant: Colors.transparent,
                              ),
                        ),
                        child: TabBar(
                          isScrollable: true,
                          indicatorColor: Colors.transparent,
                          labelColor: Colors.white,
                          unselectedLabelColor: Colors.grey,
                          tabs: [
                            if (isDataLoaded)
                              for (var field in fieldList) Tab(text: field)
                            else
                              const Tab(text: "Loading..."),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
          body: TabBarView(
            children: isDataLoaded
                ? [
                    for (var field in fieldList)
                      ListView.builder(
                        physics: _useBouncyPhysics
                            ? const BouncingScrollPhysics()
                            : const ClampingScrollPhysics(),
                        itemCount: fieldDataMap[field].length,
                        itemBuilder: (context, index) {
                          final fieldData = fieldDataMap[field][index];
                          final searchText =
                              _searchController.text.toLowerCase();

                          if (searchText.isNotEmpty &&
                              !fieldData['desc']
                                  .toLowerCase()
                                  .contains(searchText) &&
                              !fieldData['price']
                                  .toString()
                                  .toLowerCase()
                                  .contains(searchText) &&
                              !fieldData['validity']
                                  .toString()
                                  .toLowerCase()
                                  .contains(searchText)) {
                            return Container();
                          }
                          return Container(
                            decoration: const BoxDecoration(
                              color: Color(0XFF23272d),
                            ),
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                horizontal: width * 0.05,
                                vertical: height * 0.01,
                              ),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: const Color(0xFF0d141c),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: ListTile(
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: height * 0.01,
                                  horizontal: width * 0.03,
                                ),
                                title:
                                    fieldData['validity'] == 'Existing Plan' ||
                                            fieldData['validity'] == 'NA'
                                        ? Text(
                                            '${fieldData['validity']}',
                                            style: const TextStyle(
                                              color: Colors.white,
                                            ),
                                          )
                                        : Text(
                                            '${fieldData['validity']} Days',
                                            style: const TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                subtitle: Text(
                                  '${fieldData['desc']}',
                                  style: const TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                                leading: SizedBox(
                                  width: width * 0.18,
                                  child: Text(
                                    '₹${fieldData['price']}',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                                trailing: const Icon(
                                  Icons.keyboard_arrow_right_rounded,
                                  size: 30,
                                  color: Colors.white,
                                ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Page4(
                                        planData: fieldData,
                                        oprtr: widget.oprtr,
                                        phNum: widget.phNum,
                                        field: field,
                                        cachedImage: _cachedImage,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          );
                        },
                      ),
                  ]
                : [
                    const Center(
                      child: Text('Loading'),
                    ),
                  ],
          ),
        ),
      ),
    );
  }
}
