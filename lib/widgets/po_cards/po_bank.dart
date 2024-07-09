// import 'package:flutter/material.dart';

// class PoBankCard extends StatelessWidget {
//   const PoBankCard({
//     Key? key,
//     this.ht,
//     this.wd,
//     this.duration,
//     this.AccountNo,
//     // this.PAN,
//     this.AccountName,
//     this.BankBranch,
//     this.BankIFSCCode,
//     this.BankZipCode,
//     this.BankStreet,
//     this.BankCity,
//     this.BankState,
//   }) : super(key: key);

//   final double? ht;
//   final double? wd;
//   final dynamic duration;
//   final String? AccountNo;
//   // final String? PAN;
//   final String? AccountName;
//   final String? BankBranch;
//   final String? BankIFSCCode;
//   final String? BankZipCode;
//   final String? BankStreet;
//   final String? BankCity;
//   final String? BankState;

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
//                   padding: EdgeInsets.only(top: 15, left: 18),
//                   child: Row(
//                     children: [
//                       Flexible(
//                         child: Text(
//                           'AccountNo   :   $AccountNo',
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
//                 //           'PAN :  $PAN',
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
//                 Padding(
//                   padding: const EdgeInsets.only(top: 3, left: 18),
//                   child: Row(
//                     children: [
//                       Flexible(
//                         child: Text(
//                           'AccountName :  $AccountName',
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
//                           'BankBranch :  $BankBranch',
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
//                           'BankIFSCCode :  $BankIFSCCode',
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
//                           'BankZipCode :  $BankZipCode',
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
//                           'BankStreet :  $BankStreet',
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
//                           'BankCity :  $BankCity',
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
//                           'BankState :  $BankState',
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
//         SizedBox(height: 10),
//       ],
//     );
//   }
// }
