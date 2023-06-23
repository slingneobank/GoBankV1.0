import 'package:flutter/material.dart';
import 'package:gobank/utils/media.dart';

class giftofferform extends StatefulWidget {
  String icon;
  String storename;
  String discount;
   giftofferform({Key? key,required this.icon,required this.storename,required this.discount}) : super(key: key);

  @override
  State<giftofferform> createState() => _giftofferformState();
}

class _giftofferformState extends State<giftofferform> {

   int saveprice=50;
   int? sprice;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sprice=int.parse(widget.discount);
    generateList();
  }
   void generateList() {
    int startValue = 500;
    int endValue = 10000;
    int increment = 250;

    for (int i = startValue; i <= endValue; i += increment) {
      pricelistindex.add(i.toString());
    }
  } 
  List<String> pricelistindex = [];
  List walletlistindex = [
    "50",
    "100",
    "500",
    "1000",
    
  ];
  int startValue = 500;
  int endValue = 10000;
  int increment = 250;

  
  List<Color> colorList = [
  Colors.greenAccent,
  Colors.blueAccent,
  Colors.redAccent,
  Colors.orangeAccent,
  // Add more colors as needed
];
  int selectedPriceIndex = -1;
   int selectedwalletIndex = -1;
  bool isSomeoneSelected = false;

  List icondetail=[
    "asset/images/fast-delivery.png",
    "asset/images/schedule.png",
    "asset/images/shops.png"
  ];
  List detaildes=[
    "Instant Delivery",
    "Valid for 12 Months",
    "Use online only"
  ];
  List saveslingicon=[
    "asset/images/discount.png",
    "asset/images/shops.png",
    "asset/images/bill.png"
  ];
  List saveslingdetail=[
    "Buy Vouchers at instant discount",
    "Visit Brand Store or Website/App",
    "Use Voucher to Pay bill"
  ];

    double calculateStoredPrice() {
      int actualIndex = selectedPriceIndex == -1 ? 0 : selectedPriceIndex; // Use index 0 as default if selectedPriceIndex is -1
      if (actualIndex >= 0 && actualIndex < pricelistindex.length) {
        double selectedPrice = double.parse(pricelistindex[actualIndex]);
        double discountAmount = selectedPrice * (sprice! / 100);
        return discountAmount;
      }
      return 0;
    }
    PersistentBottomSheetController? _bottomSheetController;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    double storedprice=calculateStoredPrice();
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        child: Column(
          children: [
            Container(
              height: 80,
              color: Colors.black,
              child: Column(
                children: [
                  SizedBox(
                    height: 40,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Icon(
                            Icons.arrow_back_ios_new,
                            size: 20,
                            color: Colors.white,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "TnC",
                          style: TextStyle(
                            fontFamily: "Gilroy medium",
                            color: Colors.white54,
                            fontSize: height / 45,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: 
                    Container(
                      color: Colors.black,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15,right: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 10,),
                            Row(
                              children: [
                                Container(
                                  height: 80,
                                  width: 80,
                                  decoration: BoxDecoration(
                                    color: const Color.fromARGB(255, 43, 42, 42),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: SizedBox(
                                    height: 30,
                                    width: 30,
                                    child: widget.icon.startsWith('http')
                                        ? Image.network(
                                            widget.icon,
                                            fit: BoxFit.fill,
                                            
                                          )
                                        : Image.asset(
                                            widget.icon,
                                            fit: BoxFit.fill,
                                            
                                          ),
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                SizedBox(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${widget.storename} Saving Voucher",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: height / 45,
                                            fontFamily: 'Gilroy medium'),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        "${widget.discount}.0% Discount",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: height / 40,
                                            fontFamily: 'Gilroy bold'),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "Enter your purchase amount",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: height / 50,
                                  fontFamily: 'Gilroy medium'),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                Container(
                                  height: 50,
                                  width: 150,
                                  decoration: BoxDecoration(
                                    color: const Color.fromARGB(255, 43, 42, 42),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Center(
                                    child: Text(
                                      selectedPriceIndex != -1
                                      ? "${pricelistindex[selectedPriceIndex]}"
                                      : "${pricelistindex[0]}",
                                    style: TextStyle(
                                              color: Colors.white,
                                              fontSize: height / 30,
                                              fontFamily: 'Gilroy medium'),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 40,
                                ),
                                SizedBox(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Min ₹250",
                                        style: TextStyle(
                                            color: Colors.white54,
                                            fontSize: height / 55,
                                            fontFamily: 'Gilroy medium'),
                                      ),
                                      Text(
                                        "Max ₹10000",
                                        style: TextStyle(
                                            color: Colors.white54,
                                            fontSize: height / 55,
                                            fontFamily: 'Gilroy medium'),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              height: 35,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: pricelistindex.length,
                                itemBuilder: (context, index) {
                                  String price = pricelistindex[index];
                                  Color color = colorList[index % 4]; // Generate color based on index modulo 4 for a repeating pattern
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: GestureDetector(
                                      onTap: () {
                                            setState(() {
                                              selectedPriceIndex = index;
                                            });
                                         },
                                      child: Container(
                                        height: 35,
                                        width: 100,
                                        decoration: BoxDecoration(
                                          color: color,
                                          borderRadius: BorderRadius.circular(30),
                                        ),
                                        child: Center(
                                          child: Text(
                                            "₹$price",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: height / 45,
                                              fontFamily: 'Gilroy bold',
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            SizedBox(height: 20,),
                            Container(
                                height: 130,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: (icondetail.length / 3).ceil(),
                                  itemBuilder: (context, rowIndex) {
                                    int startIndex = rowIndex * 3;
                                    int endIndex = startIndex + 3;
                                    if (endIndex > icondetail.length) endIndex = icondetail.length;
                                    
                                    List rowIcons = icondetail.sublist(startIndex, endIndex);
                                    List rowDescs = detaildes.sublist(startIndex, endIndex);
                                    
                                    return Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: Wrap(
                                        spacing: 10,
                                        runSpacing: 10,
                                        children: List.generate(rowIcons.length, (index) {
                                          String icon = rowIcons[index];
                                          String desc = rowDescs[index];
                                          return Container(
                                            width: MediaQuery.of(context).size.width / 3 - 20,
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                CircleAvatar(
                                                  radius: 30,
                                                  backgroundColor: Color.fromARGB(255, 43, 42, 42),
                                                  child: SizedBox(
                                                    height: 30,
                                                    child: Image.asset(
                                                      icon,
                                                      fit: BoxFit.contain,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(height: 10,),
                                                SizedBox(
                                                  height: height / 30 * 2,
                                                  child: Align(
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                      desc,
                                                      textAlign: TextAlign.center,
                                                      style: TextStyle(
                                                        color: Colors.white54,
                                                        fontSize: height / 50,
                                                        fontFamily: 'Gilroy medium',
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          );
                                        }),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            SizedBox(height: 10,),
                            Container(
                              height: 40,
                              width: MediaQuery.of(context).size.width - 40,
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 43, 42, 42),
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: Padding(
                                padding:const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                        "How to use the voucher?",
                                          style: TextStyle(
                                                color: Colors.white,
                                                fontSize: height / 45,
                                                fontFamily: 'Gilroy medium',
                                              ),
                                       ),
                                        const Icon(
                                          Icons.arrow_right_alt,
                                          color: Colors.amber,
                                          size: 30,
                                        ),
                                  ],
                                ),
                              ),
                            ),
                           SizedBox(height: 20,),
                           Text(
                                "How to save with Slingstore?",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: height / 45,
                                  fontFamily: 'Gilroy bold',
                                   ),
                               ),
                              SizedBox(height: 20,),
                               Container(
                                height: 130,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: (saveslingicon.length / 3).ceil(),
                                  itemBuilder: (context, rowIndex) {
                                    int startIndex = rowIndex * 3;
                                    int endIndex = startIndex + 3;
                                    if (endIndex > saveslingicon.length) endIndex = saveslingicon.length;
                                    
                                    List rowIcons = saveslingicon.sublist(startIndex, endIndex);
                                    List rowDescs = saveslingdetail.sublist(startIndex, endIndex);
                                    
                                    return Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: Wrap(
                                        spacing: 10,
                                        runSpacing: 10,
                                        children: List.generate(rowIcons.length, (index) {
                                          String icon = rowIcons[index];
                                          String desc = rowDescs[index];
                                          return Container(
                                            width: MediaQuery.of(context).size.width / 3 - 20,
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                CircleAvatar(
                                                  radius: 30,
                                                  backgroundColor: Color.fromARGB(255, 43, 42, 42),
                                                  child: SizedBox(
                                                    height: 30,
                                                    child: Image.asset(
                                                      icon,
                                                      fit: BoxFit.contain,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(height: 10,),
                                                SizedBox(
                                                  height: height / 30 * 2,
                                                  child: Align(
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                      desc,
                                                      textAlign: TextAlign.center,
                                                      style: TextStyle(
                                                        color: Colors.white54,
                                                        fontSize: height / 50,
                                                        fontFamily: 'Gilroy medium',
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          );
                                        }),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            //SizedBox(height: 10,),
                          const Padding(
                              padding: const EdgeInsets.only(left: 10,right: 10),
                              child: Divider(
                                color: Colors.white54,
                                
                              ),
                            ),
                            SizedBox(height: 20,),
                       
                    
                                Text(
                                  "Who are you buying this for?",
                                  style: TextStyle(
                                    color: Colors.white54,
                                    fontSize: height / 45,
                                    fontFamily: 'Gilroy bold',
                                  ),
                                ),
                                SizedBox(height: 20),
                                Theme(
                                    data: Theme.of(context).copyWith(
                                      unselectedWidgetColor: Colors.white, // Border color for unselected radio button
                                      radioTheme: RadioThemeData(
                                        fillColor: MaterialStateColor.resolveWith((states) {
                                          if (states.contains(MaterialState.selected)) {
                                            return Colors.white; // Active color for selected radio button
                                          }
                                          return Colors.transparent; // Transparent color for unselected radio button
                                        }),
                                      ),
                                    ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 20,right: 20),
                                    child: Row(
                                      children: [
                                        Container(
                                          height: 20,
                                          width: 20,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.white),
                                            shape: BoxShape.circle
                                          ),
                                          child: Radio(
                                            value: false,
                                            groupValue: isSomeoneSelected,
                                            onChanged: (value) {
                                              setState(() {
                                                isSomeoneSelected = value as bool;
                                              });
                                            },
                                          ),
                                        ),
                                        SizedBox(width: 20,),
                                        Text(
                                          'Myself',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: height / 50,
                                            fontFamily: 'Gilroy medium',
                                          ),
                                        ),
                                        SizedBox(width: 50,),
                                        Container(
                                          height: 20,
                                          width: 20,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.white),
                                            shape: BoxShape.circle
                                          ),
                                          child: Radio(
                                            value: true,
                                            groupValue: isSomeoneSelected,
                                            onChanged: (value) {
                                              setState(() {
                                                isSomeoneSelected = value as bool;
                                              });
                                            },
                                          ),
                                        ),
                                        SizedBox(width: 20,),
                                        Text(
                                          'Someone',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: height / 50,
                                            fontFamily: 'Gilroy medium',
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                if (isSomeoneSelected)
                                  Column(
                                    children: [
                                      SizedBox(height: 20),
                                      Container(
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color: Colors.black,
                                         
                                        ),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Fill in the details below for whom you arebuying this:',
                                              style: TextStyle(
                                                color: Colors.white54,
                                                fontSize: height / 50,
                                                fontFamily: 'Gilroy bold',
                                              ),
                                            ),
                                            SizedBox(height: 10),
                                            Row(
                                              children: [
                                                Container(
                                                  width: width-120,
                                                  height: 50,
                                                  decoration: BoxDecoration(
                                                    color: const Color.fromARGB(255, 43, 42, 42),
                                                    borderRadius: BorderRadius.circular(15),
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets.only(left: 10),
                                                    child: TextField(
                                                      decoration: InputDecoration(
                                                        labelText: 'Name',
                                                        labelStyle: TextStyle(
                                                          fontFamily: "Gilroy medium",
                                                          color: Colors.white54,
                                                          fontSize: height / 45,
                                                        ),
                                                      ),
                                                      style: TextStyle(color: Colors.black),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(width: 10),
                                                Container(
                                                  width: 50,
                                                  height: 50,
                                                  decoration: const BoxDecoration(
                                                    color:  Color.fromARGB(255, 43, 42, 42),
                                                    shape: BoxShape.circle
                                                  ),
                                                  child:const Icon(Icons.person,color: Colors.white54,), // Replace with the desired icon
                                                ),
                                              ],
                                            ),

                                            // TextField(
                                            //   decoration: InputDecoration(
                                            //     labelText: 'Name',
                                            //     labelStyle: TextStyle(fontFamily: "Gilroy medium",
                                            //         color: Colors.white60,
                                            //         fontSize: height / 45),
                                            //         enabledBorder: UnderlineInputBorder(
                                            //         borderSide: BorderSide(color: Colors.white60),
                                            //       ),
                                            //       focusedBorder: UnderlineInputBorder(
                                            //         borderSide: BorderSide(color: Colors.white60),
                                            //       ),
                                            //     ),
                                            //   style: TextStyle(color: Colors.white),
                                              
                                            // ),
                                            SizedBox(height: 10),
                                            // TextField(
                                            //   decoration: InputDecoration(
                                            //     labelText: 'Email',
                                            //     labelStyle: TextStyle(fontFamily: "Gilroy medium",
                                            //         color: Colors.white60,
                                            //         fontSize: height / 45),
                                            //         enabledBorder: UnderlineInputBorder(
                                            //         borderSide: BorderSide(color: Colors.white60),
                                            //       ),
                                            //       focusedBorder: UnderlineInputBorder(
                                            //         borderSide: BorderSide(color: Colors.white60),
                                            //       ),
                                            //     ),
                                            //   style: TextStyle(color: Colors.white),
                                              
                                            // ),
                                            Container(
                                                  width: width-80,
                                                  height: 50,
                                                  decoration: BoxDecoration(
                                                    color: const Color.fromARGB(255, 43, 42, 42),
                                                    borderRadius: BorderRadius.circular(15),
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets.only(left: 10),
                                                    child: TextField(
                                                      decoration: InputDecoration(
                                                        labelText: 'Email',
                                                        labelStyle: TextStyle(
                                                          fontFamily: "Gilroy medium",
                                                          color: Colors.white54,
                                                          fontSize: height / 45,
                                                        ),
                                                      ),
                                                      style: TextStyle(color: Colors.black),
                                                    ),
                                                  ),
                                                ),
                                            SizedBox(height: 10),
                                            // TextField(
                                            //   decoration: InputDecoration(
                                            //     labelText: 'Phone number',
                                            //     labelStyle: TextStyle(fontFamily: "Gilroy medium",
                                            //         color: Colors.white60,
                                            //         fontSize: height / 45),
                                            //         enabledBorder: UnderlineInputBorder(
                                            //         borderSide: BorderSide(color: Colors.white60),
                                            //       ),
                                            //       focusedBorder: UnderlineInputBorder(
                                            //         borderSide: BorderSide(color: Colors.white60),
                                            //       ),
                                            //     ),
                                            //   style: TextStyle(color: Colors.white),
                                            
                                            // ),
                                            Container(
                                                  width: width-80,
                                                  height: 50,
                                                  decoration: BoxDecoration(
                                                    color: const Color.fromARGB(255, 43, 42, 42),
                                                    borderRadius: BorderRadius.circular(15),
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets.only(left: 10),
                                                    child: TextField(
                                                      decoration: InputDecoration(
                                                        labelText: 'Phone Number',
                                                        labelStyle: TextStyle(
                                                          fontFamily: "Gilroy medium",
                                                          color: Colors.white54,
                                                          fontSize: height / 45,
                                                        ),
                                                      ),
                                                      style: TextStyle(color: Colors.black),
                                                    ),
                                                  ),
                                                ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                SizedBox(height: 20,),
                               Text(
                                  "Payment Details",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: height / 45,
                                    fontFamily: 'Gilroy bold',
                                  ),
                                ),
                                SizedBox(height: 20,),
                            SizedBox(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                  "Voucher Amount",
                                  style: TextStyle(
                                    color: Colors.white54,
                                    fontSize: height / 45,
                                    fontFamily: 'Gilroy bold',
                                  ),
                                ),
                                 Text(
                                      selectedPriceIndex != -1
                                      ? "₹${pricelistindex[selectedPriceIndex]}.0"
                                      : "₹${pricelistindex[0]}.0",
                                    style: TextStyle(
                                              color: Colors.white54,
                                              fontSize: height / 45,
                                              fontFamily: 'Gilroy medium'),
                                    ),
                                ],
                              ),
                            ),
                            SizedBox(height: 10,),
                            SizedBox(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                  "Save Using Slingstore",
                                  style: TextStyle(
                                    color: Colors.white54,
                                    fontSize: height / 45,
                                    fontFamily: 'Gilroy bold',
                                  ),
                                ),
                                 Text(
                                      "₹${storedprice.toStringAsFixed(1)}",
                                      
                                    style: TextStyle(
                                              color: Colors.white54,
                                              fontSize: height / 45,
                                              fontFamily: 'Gilroy medium'),
                                    ),
                                ],
                              ),
                            ),
                            SizedBox(height: 20,),
                            const Padding(
                              padding: const EdgeInsets.only(left: 10,right: 10),
                              child: Divider(
                                color: Colors.white54,
                                
                              ),
                            ),
                    
                    
                          ],
                        ),
                                      
                                    ),
                    ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar:BottomAppBar(
            child: Container(
              color: Colors.black,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: 30,
                    width: width,
                    color: Color.fromARGB(255, 225, 205, 151),
                    child: Center(
                      child: Text(
                            "🔥5000+ ${widget.storename} saving vouchers bought recently",
                            style: TextStyle(
                                    color: Colors.black,
                                    fontSize: height / 50,
                                    fontFamily: 'Gilroy bold'),
                                  ),
                    ),
                  ),
                  SizedBox(height: 30,),
                  Padding(
                    padding: const EdgeInsets.only(left: 20,right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height:  height * 0.06,
                          width: width*0.2,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 127, 219, 152),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              "Saved ${widget.discount}.0%",
                              overflow: TextOverflow.clip,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                      color: Colors.black,
                                      fontSize: height / 50,
                                      fontFamily: 'Gilroy bold'),
                                    ),
                          ),
                        ),
                        //SizedBox(width: width*0.1),
                        Container(
                          height: height * 0.06,
                          width: width*0.6,
                          child: OutlinedButton(onPressed: () {
                             
                              openBottomSheet();
                              }, 
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all<Color>(Colors.amber),
                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10), // Set a circular border radius
                                  ),
                                ),
                              ),
                              child: Text(
                              "Pay ₹ ${selectedPriceIndex != -1 ?
                               (int.parse(pricelistindex[selectedPriceIndex]) - storedprice).toStringAsFixed(1) 
                               : (int.parse(pricelistindex[0]) - storedprice).toStringAsFixed(1)}",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: height / 50,
                                fontFamily: 'Gilroy bold',
                              ),
                            ),
                  
                            ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10,),
                ],
              ),
            ),
          ),

      
    );
    
  }
   void openBottomSheet() async {
  await showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
    ),
    builder: (BuildContext context) {
      return Container(
        height: MediaQuery.of(context).size.height * 0.70, // Adjust the height as per your requirement
       
        decoration: BoxDecoration(
           color: Colors.white,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20))
        ),
        child: Column(
          children: [
            Container(
              child: Column(
                children: [
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Icon(
                      Icons.expand_more,
                      size: 25,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.only(left: 20,right: 10),
              child: Row(
                children: [
                  SizedBox(
                    height: 50,
                    width: 50,
                    child: Image.asset("images/wallet.png"),
                  ),
                  SizedBox(width: 20,),
                  Expanded(
                    child: Text(
                        "Your Wallet seems low on balance quick recharge now",
                        style: TextStyle(
                          fontFamily: "Gilroy bold",
                          color: Colors.black,
                          fontSize: height / 45,
                        ),
                      ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30,),
            Text(
              "Add money to your Account",
              style: TextStyle(
                fontFamily: "Gilroy medium",
                color: Colors.black54,
                fontSize: height / 45,
              ),
            ),
            SizedBox(height: 30,),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Container(
                height: 35,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: walletlistindex.length,
                  itemBuilder: (context, index) {
                    String price = walletlistindex[index];
                    Color color = colorList[index % 4]; // Generate color based on index modulo 4 for a repeating pattern
                    return Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedwalletIndex = index;
                            
                          });
                        },
                        child: Container(
                          height: 35,
                          width: 80,
                          decoration: BoxDecoration(
                            color: color,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Center(
                            child: Text(
                              "₹$price",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: height / 45,
                                fontFamily: 'Gilroy bold',
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            SizedBox(height: 20,),
            Text(
              selectedwalletIndex != -1
                  ? "${walletlistindex[selectedwalletIndex]}"
                  : "${walletlistindex[0]}",
              style: TextStyle(
                color: Colors.black,
                fontSize: height / 30,
                fontFamily: 'Gilroy medium'
              ),
            ),
            const Divider(
              height: 5,
              color: Colors.black,
              thickness: 1,
              indent: 120,
              endIndent: 120,
            ),
            SizedBox(height: 30,),
            Padding(
              padding: const EdgeInsets.only(left: 20,right: 20),
              child: Text(
                "You can add funds up to Rs.10000.0 for the ",
                style: TextStyle(
                  fontFamily: "Gilroy medium",
                  color: Colors.black54,
                  fontSize: height / 45,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20,right: 20),
              child: Text(
                "Current month ",
                style: TextStyle(
                  fontFamily: "Gilroy medium",
                  color: Colors.black54,
                  fontSize: height / 45,
                ),
              ),
            ),
            SizedBox(height: 50,),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Column(
                children: [
                  OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.black,
                      padding: EdgeInsets.symmetric(vertical: 13, horizontal: 25),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Text(
                      "Add",
                      style: TextStyle(
                        fontFamily: "Gilroy Medium",
                        color: Colors.white,
                        fontSize: height / 50,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  const Divider(
                    height: 5,
                    color: Colors.black,
                    thickness: 3,
                    indent: 120,
                    endIndent: 120,
                  ),
                ],
              ),
            ),
            // Add your button and divider here
            
          
          ],
        ),
      );
    },
  );
}
 
}
