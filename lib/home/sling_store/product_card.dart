// import 'package:flutter/material.dart';

// class ProductCard extends StatelessWidget {
//   final String image;
//   final String name;
//   final double price;

//   const ProductCard({
//     Key? key,
//     required this.image,
//     required this.name,
//     required this.price,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: MediaQuery.of(context).size.width * 2 / 3,
//       height: MediaQuery.of(context).size.width,
//       margin: EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.2),
//             spreadRadius: 5,
//             blurRadius: 7,
//             offset: Offset(0, 3),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           ClipRRect(
//             borderRadius: BorderRadius.only(
//               topLeft: Radius.circular(16),
//               topRight: Radius.circular(16),
//             ),
//             child: Image.network(
//               image,
//               width: double.infinity,
//               height: MediaQuery.of(context).size.width * 2 / 3,
//               fit: BoxFit.cover,
//             ),
//           ),
//           Padding(
//             padding: EdgeInsets.all(8),
//             child: Text(
//               name,
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//               ),
//               maxLines: 2,
//               overflow: TextOverflow.ellipsis,
//             ),
//           ),
//           Spacer(),
//           Padding(
//             padding: EdgeInsets.all(8),
//             child: Text(
//               '\$${price.toStringAsFixed(2)}',
//               style: TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.green,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
