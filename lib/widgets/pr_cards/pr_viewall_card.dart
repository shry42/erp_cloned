// import 'package:erp_copy/utils/color_for_Cards.dart';
// import 'package:flutter/material.dart';
// import 'package:shimmer_animation/shimmer_animation.dart';

// class PRViewAllCard extends StatelessWidget {
//   const PRViewAllCard({
//     Key? key,
//     this.ht,
//     this.wd,
//     required this.PRTxnID,
//     this.TxnDate,
//     this.duration,
//     this.ReqDate,
//     this.ProjectCode,
//     this.PRStatus,
//   }) : super(key: key);

//   final double? ht;
//   final double? wd;
//   final String? PRTxnID;
//   final String? TxnDate;
//   final String? ReqDate;
//   final String? ProjectCode;

//   final String? PRStatus;

//   final dynamic duration;

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
//                   padding: const EdgeInsets.only(top: 16, left: 18),
//                   child: Row(
//                     children: [
//                       Flexible(
//                         child: Text(
//                           'PRTxnID :  $PRTxnID',
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
//                           'PRTxnDate :  $TxnDate',
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
//                           'ReqDate :  $ReqDate',
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
//                           'ProjectCode :  $ProjectCode',
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
//                           'PRStatus :  $PRStatus',
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
