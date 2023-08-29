import 'package:flutter/material.dart';

class Page4 extends StatefulWidget {
  const Page4(
      {super.key,
      this.planData,
      required this.oprtr,
      required this.phNum,
      required this.field,
      required this.cachedImage});
  final dynamic planData;
  final String oprtr;
  final String phNum;
  final String field;
  final ImageProvider cachedImage;
  @override
  State<Page4> createState() => _Page4State();
}

class _Page4State extends State<Page4> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFF020002),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFF0c141b),
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
      body: Column(
        children: [
          SizedBox(
            height: height * 0.03,
          ),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  bottom: height * 0.03,
                  left: width * 0.05,
                  right: width * 0.05,
                ),
                child: SizedBox(
                  width: width * 0.2,
                  child: Image(
                    image: widget.cachedImage,
                  ),
                ),
              ),
              Text(
                widget.phNum,
                style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(
            height: height * 0.04,
          ),
          Container(
            width: width * 0.9,
            decoration: BoxDecoration(
              color: const Color(0XFF23272d),
              borderRadius: BorderRadius.circular(15),
            ),
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              title: Container(
                height: height * 0.08,
                padding: EdgeInsets.symmetric(
                  horizontal: width * 0.05,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '₹${widget.planData['price']}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      width: width * 0.4,
                      child: Text(
                        widget.field,
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          height: 1.2,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                  ],
                ),
              ),
              subtitle: SizedBox(
                width: width * 0.9,
                child: Column(
                  children: [
                    SizedBox(
                      width: width * 0.8,
                      child: const Divider(
                        color: Colors.grey,
                        thickness: 0.5,
                        height: 0,
                      ),
                    ),
                    Container(
                      width: width * 0.8,
                      padding: const EdgeInsets.all(10),
                      child: SingleChildScrollView(
                        child: Text(
                          '${widget.planData['desc']}',
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: width * 0.8,
                      child: const Divider(
                        color: Colors.grey,
                        thickness: 0.5,
                        height: 0,
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.transparent),
                          elevation: MaterialStateProperty.all(0),
                          alignment: Alignment.centerRight,
                          overlayColor: MaterialStateProperty.all(
                            Colors.transparent,
                          ),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'Change Plan',
                          style: TextStyle(
                            color: Colors.greenAccent,
                            fontSize: 20,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: height * 0.05,
          ),
          SizedBox(
            width: width * 0.25,
            child: ElevatedButton(
              onPressed: () {},
              child: const Text(
                'Pay',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
