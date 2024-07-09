// import 'package:flutter/material.dart';

// class PoItemInfoCard extends StatelessWidget {
//   const PoItemInfoCard({
//     Key? key,
//     this.ht,
//     this.wd,
//     this.duration,
//     this.PODetailsID,
//     this.POTxnID,
//     this.ItemID,
//     this.SAPID,
//     this.ItemName,
//     this.HSN_Code,
//     this.POQty,
//     this.PurchaseUOM,
//     this.DeliveryDate,
//     this.UnitPrice,
//     this.TaxCode,
//     this.TaxPercent,
//     this.LineTotal,
//     this.TaxAmt,
//     this.FinalAmt,
//     this.RevisionNumber,
//     this.BuyerName,
//     this.BuyerEmailID,
//     this.BuyerTel,
//     this.BuyerMob,
//     this.SupplierPOCName,
//     this.QuoteDate,
//   }) : super(key: key);

//   final double? ht;
//   final double? wd;
//   final dynamic duration;
//   final String? PODetailsID;
//   final String? POTxnID;
//   final String? ItemID;
//   final String? SAPID;
//   final String? ItemName;
//   final String? HSN_Code;
//   final String? POQty;
//   final String? PurchaseUOM;
//   final String? DeliveryDate;
//   final String? UnitPrice;
//   final String? TaxCode;
//   final String? TaxPercent;
//   final String? LineTotal;
//   final String? TaxAmt;
//   final String? FinalAmt;
//   final String? RevisionNumber;
//   final String? BuyerName;
//   final String? BuyerEmailID;
//   final String? BuyerTel;
//   final String? BuyerMob;
//   final String? SupplierPOCName;
//   final String? QuoteDate;

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
//           child: AnimatedContainer(
//             duration: Duration(milliseconds: duration),
//             height: ht,
//             width: wd,
//             decoration: ColorCards.gradientDecoration,
//             child: SingleChildScrollView(
//               // physics: const NeverScrollableScrollPhysics(),
//               child: Column(children: [
//                 Padding(
//                   padding: EdgeInsets.only(top: 15, left: 18),
//                   child: Row(
//                     children: [
//                       Flexible(
//                         child: Text(
//                           'PODetailsID   :   $PODetailsID',
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
//                           'POTxnID :  $POTxnID',
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
//                           'ItemID :  $ItemID',
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
//                           'SAPID :  $SAPID',
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
//                           'ItemName :  $ItemName',
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
//                           'HSN_Code :  $HSN_Code',
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
//                           'POQty :  $POQty',
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
//                           'PurchaseUOM :  $PurchaseUOM',
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
//                           'DeliveryDate :  $DeliveryDate',
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
//                           'UnitPrice :  $UnitPrice',
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
//                           'TaxCode :  $TaxCode',
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
//                           'TaxPercent :  $TaxPercent',
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
//                           'LineTotal :  $LineTotal',
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
//                           'TaxAmt :  $TaxAmt',
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
//                           'FinalAmt :  $FinalAmt',
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
//                 // Padding(
//                 //   padding: const EdgeInsets.only(top: 3, left: 18),
//                 //   child: Row(
//                 //     children: [
//                 //       Flexible(
//                 //         child: Text(
//                 //           'RevisionNumber :  $RevisionNumber',
//                 //           style: const TextStyle(
//                 //             fontSize: 18,
//                 //             fontWeight: FontWeight.bold,
//                 //             color: Colors.white,
//                 //           ),
//                 //         ),
//                 //       ),
//                 //     ],
//                 //   ),
//                 // ),
//                 // Padding(
//                 //   padding: const EdgeInsets.only(top: 3, left: 18),
//                 //   child: Row(
//                 //     children: [
//                 //       Flexible(
//                 //         child: Text(
//                 //           'BuyerName :  $BuyerName',
//                 //           style: const TextStyle(
//                 //             fontSize: 18,
//                 //             fontWeight: FontWeight.bold,
//                 //             color: Colors.white,
//                 //           ),
//                 //         ),
//                 //       ),
//                 //     ],
//                 //   ),
//                 // ),
//                 // Padding(
//                 //   padding: const EdgeInsets.only(top: 3, left: 18),
//                 //   child: Row(
//                 //     children: [
//                 //       Flexible(
//                 //         child: Text(
//                 //           'BuyerEmailID :  $BuyerEmailID',
//                 //           style: const TextStyle(
//                 //             fontSize: 18,
//                 //             fontWeight: FontWeight.bold,
//                 //             color: Colors.white,
//                 //           ),
//                 //         ),
//                 //       ),
//                 //     ],
//                 //   ),
//                 // ),
//                 // Padding(
//                 //   padding: const EdgeInsets.only(top: 3, left: 18),
//                 //   child: Row(
//                 //     children: [
//                 //       Flexible(
//                 //         child: Text(
//                 //           'BuyerTel :  $BuyerTel',
//                 //           style: const TextStyle(
//                 //             fontSize: 18,
//                 //             fontWeight: FontWeight.bold,
//                 //             color: Colors.white,
//                 //           ),
//                 //         ),
//                 //       ),
//                 //     ],
//                 //   ),
//                 // ),
//                 // Padding(
//                 //   padding: const EdgeInsets.only(top: 3, left: 18),
//                 //   child: Row(
//                 //     children: [
//                 //       Flexible(
//                 //         child: Text(
//                 //           'BuyerMob :  $BuyerMob',
//                 //           style: const TextStyle(
//                 //             fontSize: 18,
//                 //             fontWeight: FontWeight.bold,
//                 //             color: Colors.white,
//                 //           ),
//                 //         ),
//                 //       ),
//                 //     ],
//                 //   ),
//                 // ),
//                 // Padding(
//                 //   padding: const EdgeInsets.only(top: 3, left: 18),
//                 //   child: Row(
//                 //     children: [
//                 //       Flexible(
//                 //         child: Text(
//                 //           'SupplierPOCName :  $SupplierPOCName',
//                 //           style: const TextStyle(
//                 //             fontSize: 18,
//                 //             fontWeight: FontWeight.bold,
//                 //             color: Colors.white,
//                 //           ),
//                 //         ),
//                 //       ),
//                 //     ],
//                 //   ),
//                 // ),
//                 // Padding(
//                 //   padding: const EdgeInsets.only(top: 3, left: 18),
//                 //   child: Row(
//                 //     children: [
//                 //       Flexible(
//                 //         child: Text(
//                 //           'QuoteDate :  $QuoteDate',
//                 //           style: const TextStyle(
//                 //             fontSize: 18,
//                 //             fontWeight: FontWeight.bold,
//                 //             color: Colors.white,
//                 //           ),
//                 //         ),
//                 //       ),
//                 //     ],
//                 //   ),
//                 // ),
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
