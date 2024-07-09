// import 'package:flutter/material.dart';

// class PoBuyerCard extends StatelessWidget {
//   const PoBuyerCard({
//     Key? key,
//     this.ht,
//     this.wd,
//     this.duration,
//     this.BuyerName,
//     this.BuyerEmailID,
//     this.BuyerTel,
//     this.BuyerMob,
//   }) : super(key: key);

//   final double? ht;
//   final double? wd;
//   final dynamic duration;
//   final String? BuyerName;
//   final String? BuyerEmailID;
//   final String? BuyerTel;
//   final String? BuyerMob;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Card(
//           margin: const EdgeInsets.symmetric(horizontal: 18),
//           elevation: 8,
//           shape: RoundedRectangleBorder(
//             side: const BorderSide(color: Colors.white),
//             borderRadius: BorderRadius.circular(25),
//           ),
//           //  color: Color.fromARGB(243, 199, 80, 11),
//           //color: Colors.red,
//           child: AnimatedContainer(
//             duration: Duration(milliseconds: duration),
//             height: ht,
//             width: wd,
//             decoration: ColorCards.gradientDecoration,
//             child: SingleChildScrollView(
//               physics: const NeverScrollableScrollPhysics(),
//               child: Column(children: [
//                 Padding(
//                   padding: const EdgeInsets.only(top: 15, left: 18),
//                   child: Row(
//                     children: [
//                       Flexible(
//                         child: Text(
//                           'BuyerName   :   $BuyerName',
//                           style: const TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.white,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(top: 3, left: 18),
//                   child: Row(
//                     children: [
//                       Flexible(
//                         child: Text(
//                           'BuyerEmailID :  $BuyerEmailID',
//                           style: const TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.white,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(top: 3, left: 18),
//                   child: Row(
//                     children: [
//                       Flexible(
//                         child: Text(
//                           'BuyerTel :  $BuyerTel',
//                           style: const TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.white,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(top: 3, left: 18),
//                   child: Row(
//                     children: [
//                       Flexible(
//                         child: Text(
//                           'BuyerMob :  $BuyerMob',
//                           style: const TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.white,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(height: 10),
//               ]),
//               //
//             ),
//           ),
//         ),
//         const SizedBox(height: 10),
//       ],
//     );
//   }
// }
