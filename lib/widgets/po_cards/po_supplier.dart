// import 'package:flutter/material.dart';

// class PoSupplierCard extends StatelessWidget {
//   const PoSupplierCard({
//     Key? key,
//     this.ht,
//     this.wd,
//     this.duration,
//     this.SupplierQuoteNo,
//     this.QuoteDate,
//     this.SupplierPOCName,
//     this.SupplierPOCEmailID,
//     this.SupplierPOCTel,
//     this.SupplierPOCMob,
//     this.FinancialYear,
//   }) : super(key: key);

//   final double? ht;
//   final double? wd;
//   final dynamic duration;
//   final String? SupplierQuoteNo;
//   final String? QuoteDate;
//   final String? SupplierPOCName;
//   final String? SupplierPOCEmailID;
//   final String? SupplierPOCTel;
//   final String? SupplierPOCMob;
//   final String? FinancialYear;

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
//                           'SupplierQuoteNo   :   $SupplierQuoteNo',
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
//                           'QuoteDate :  $QuoteDate',
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
//                           'SupplierPOCName :  $SupplierPOCName',
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
//                           'SupplierPOCEmailID :  $SupplierPOCEmailID',
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
//                           'SupplierPOCTel :  $SupplierPOCTel',
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
//                           'SupplierPOCMob :  $SupplierPOCMob',
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
//                           'FinancialYear :  $FinancialYear',
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
