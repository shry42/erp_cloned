import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:erp_copy/controllers/app_controller.dart';
import 'package:erp_copy/controllers/po_controllers/approve_po_controller.dart';
import 'package:erp_copy/controllers/po_controllers/po_details_controller.dart';
import 'package:erp_copy/controllers/po_controllers/po_log_controller.dart';
import 'package:erp_copy/controllers/po_controllers/reject_po_controller.dart';
import 'package:erp_copy/controllers/po_controllers/vendor_details_controller.dart';
import 'package:erp_copy/screens/po_screens/po_item_details.dart';
import 'package:erp_copy/widgets/po_cards/po_bank.dart';
import 'package:erp_copy/widgets/po_cards/po_buyer.dart';
import 'package:erp_copy/widgets/po_cards/supplier_details_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import '../../widgets/po_cards/po_vendor_details_card.dart';

class VendorDetailsScreen extends StatefulWidget {
  final String POTxnID;
  final String VendorID;
  VendorDetailsScreen(
      {super.key, required this.POTxnID, required this.VendorID});

  @override
  State<VendorDetailsScreen> createState() => _VendorDetailsScreenState();
}

class _VendorDetailsScreenState extends State<VendorDetailsScreen> {
  double _height = 450;
  double _width = 350;
  dynamic? _duration = 500;
  bool animated = false;
  List<dynamic>? dataList;

  @override
  void initState() {
    setState(() {
      vendorDetCont.getVendorById(widget.VendorID, widget.POTxnID);
      dataList = vendorDetCont.PoVendorDetailsObjList;
    });
    super.initState();
  }

  final VenodorDetailsController vendorDetCont = VenodorDetailsController();
  final RejectPoController rejectPo = RejectPoController();
  final ApprovePoController approvePo = ApprovePoController();
  final PoLogDetailsController poLogCont = PoLogDetailsController();
  final PoDetailsSelectByItemIdController poDetailsCont =
      PoDetailsSelectByItemIdController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Vendor Details'), actions: [
        // if (role == 'Superadmin')
        Shimmer(
          duration: const Duration(seconds: 2),
          // This is NOT the default value. Default value: Duration(seconds: 0)
          interval: const Duration(milliseconds: 20),
          // This is the default value
          color: Colors.white,
          // This is the default value
          colorOpacity: 1,
          // This is the default value
          enabled: true,
          // This is the default value
          direction: const ShimmerDirection.fromLTRB(),
          child: GestureDetector(
            onTap: () async {
              await poDetailsCont.getPoDetailsById(widget.POTxnID);
              if (AppController.message != null) {
                Get.defaultDialog(
                  title: "Oops!",
                  middleText: "${AppController.message}",
                  textConfirm: "OK",
                  confirmTextColor: Colors.white,
                  onConfirm: () async {
                    Get.back();
                  },
                );
                return;
              }
              Get.to(
                PoByItemDetailsScreen(
                  PoTxnID: widget.POTxnID,
                ),
              );
            },
            child: Container(
              height: 30,
              width: 100,
              decoration: BoxDecoration(
                  border: Border.all(),
                  color: Colors.white70,
                  borderRadius: BorderRadius.circular(6)),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      'View Items',
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: 15),
      ]),
      body: SafeArea(
        child: FutureBuilder(
          future: vendorDetCont.getVendorById(widget.VendorID, widget.POTxnID),
          builder: (BuildContext ctx, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return Center(
                child: Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/loaderr.gif',
                      height: 200,
                      width: 250,
                    ),
                    const Text('No records found')
                  ],
                )),
              );
            } else {
              return Column(
                children: [
                  Expanded(
                    child: DefaultTabController(
                      length: 4,
                      child: Column(
                        children: <Widget>[
                          ButtonsTabBar(
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            unselectedBackgroundColor: Colors.grey[300],
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                colors: <Color>[
                                  Color(0xFF8BC34A), // Light Green 500
                                  Color(0xFFCDDC39), // Lime 500
                                  Color(0xFFE6EE9C), // Lime 100
                                ],
                              ),
                            ),
                            unselectedLabelStyle:
                                const TextStyle(color: Colors.black),
                            labelStyle: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                            tabs: const [
                              Tab(
                                icon: Icon(Icons.store),
                                text: "Vendor ",
                              ),
                              Tab(
                                icon: Icon(Icons.supervised_user_circle),
                                text: "Supplier",
                              ),
                              Tab(
                                icon: Icon(Icons.person),
                                text: "Buyer",
                              ),
                              Tab(
                                icon: Icon(Icons.account_balance),
                                text: "Bank",
                              ),
                            ],
                          ),
                          Expanded(
                            child: TabBarView(
                              children: <Widget>[
                                Center(
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        const SizedBox(height: 30),

                                        // child: PoVendorCard(
                                        //   ht: _height,
                                        //   wd: _width,
                                        //   duration: _duration,
                                        //   POTxnID: snapshot.data[0].POTxnID
                                        //       .toString(),
                                        //   POCode: snapshot.data[0].POCode
                                        //       .toString(),
                                        //   Pan: snapshot.data[0].PAN.toString(),
                                        //   RevisionNumber: snapshot
                                        //       .data[0].RevisionNumber
                                        //       .toString(),
                                        //   PODate: snapshot.data[0].PODate
                                        //       .toString()
                                        //       .split("T")[0],
                                        //   VendorID: snapshot.data[0].VendorID
                                        //       .toString(),
                                        //   VendorName: snapshot
                                        //       .data[0].VendorName
                                        //       .toString(),
                                        //   VendorGroup: snapshot
                                        //       .data[0].VendorGroup
                                        //       .toString(),
                                        //   VendorCurrency: snapshot
                                        //       .data[0].VendorCurrency
                                        //       .toString(),
                                        //   BillToAddressL1: snapshot
                                        //       .data[0].BillToAddressL1
                                        //       .toString(),
                                        //   BillToAddressL2: snapshot
                                        //       .data[0].BillToAddressL2
                                        //       .toString(),
                                        //   BillToAddressL3: snapshot
                                        //       .data[0].BillToAddressL3
                                        //       .toString(),
                                        //   BillToState: snapshot
                                        //       .data[0].BillToState
                                        //       .toString(),
                                        //   BillToCountry: snapshot
                                        //       .data[0].BillToCountry
                                        //       .toString(),
                                        //   BillToCity: snapshot
                                        //       .data[0].BillToCity
                                        //       .toString(),
                                        //   BillToZipCode: snapshot
                                        //       .data[0].BillToZipCode
                                        //       .toString(),
                                        //   GSTNumber: snapshot.data[0].GSTNumber
                                        //       .toString(),
                                        //   GSTRegType: snapshot
                                        //       .data[0].GSTRegType
                                        //       .toString(),
                                        //   MSME:
                                        //       snapshot.data[0].MSME.toString(),
                                        //   EmailID: snapshot.data[0].EmailID
                                        //       .toString(),
                                        //   Telephone: snapshot.data[0].Telephone
                                        //       .toString(),
                                        //   MobilePhone: snapshot
                                        //       .data[0].MobilePhone
                                        //       .toString(),
                                        //   Website: snapshot.data[0].Website
                                        //       .toString(),
                                        //   DeliveryTerms: snapshot
                                        //       .data[0].DeliveryTerms
                                        //       .toString(),
                                        //   PaymentTerms: snapshot
                                        //       .data[0].PaymentTerms
                                        //       .toString(),
                                        //   HeaderNote: snapshot
                                        //       .data[0].HeaderNote
                                        //       .toString(),
                                        // ),
                                        VendorDetailsCard(
                                          POTxnID: snapshot.data[0].POTxnID,
                                          POCode: snapshot.data[0].POCode
                                              .toString(),
                                          PANNo:
                                              snapshot.data[0].PAN.toString(),
                                          RevisionNumber: snapshot
                                              .data[0].RevisionNumber
                                              .toString(),
                                          PODate: snapshot.data[0].PODate
                                              .toString()
                                              .split("T")[0],
                                          VendorID: snapshot.data[0].VendorID
                                              .toString(),
                                          VendorName: snapshot
                                              .data[0].VendorName
                                              .toString(),
                                          VendorGroup: snapshot
                                              .data[0].VendorGroup
                                              .toString(),
                                          VendorCurrency: snapshot
                                              .data[0].VendorCurrency
                                              .toString(),
                                          BillToAddressL1: snapshot
                                              .data[0].BillToAddressL1
                                              .toString(),
                                          BillToAddressL2: snapshot
                                              .data[0].BillToAddressL2
                                              .toString(),
                                          BillToAddressL3: snapshot
                                              .data[0].BillToAddressL3
                                              .toString(),
                                          BillToState: snapshot
                                              .data[0].BillToState
                                              .toString(),
                                          BillToCountry: snapshot
                                              .data[0].BillToCountry
                                              .toString(),
                                          BillToCity: snapshot
                                              .data[0].BillToCity
                                              .toString(),
                                          BillToZipCode: snapshot
                                              .data[0].BillToZipCode
                                              .toString(),
                                          GSTNumber: snapshot.data[0].GSTNumber
                                              .toString(),
                                          GSTRegType: snapshot
                                              .data[0].GSTRegType
                                              .toString(),
                                          MSME:
                                              snapshot.data[0].MSME.toString(),
                                          EmailId: snapshot.data[0].EmailID
                                              .toString(),
                                          Telephone: snapshot.data[0].Telephone
                                              .toString(),
                                          MobilePhone: snapshot
                                              .data[0].MobilePhone
                                              .toString(),
                                          Website: snapshot.data[0].Website
                                              .toString(),
                                          DeliveryTerms: snapshot
                                              .data[0].DeliveryTerms
                                              .toString(),
                                          PaymentTerms: snapshot
                                              .data[0].PaymentTerms
                                              .toString(),
                                          HeaderNote: snapshot
                                              .data[0].HeaderNote
                                              .toString(),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Center(
                                  child: Column(
                                    children: [
                                      const SizedBox(height: 30),
                                      POSupplierCard(
                                        QuoteNo: snapshot
                                            .data[0].SupplierQuoteNo
                                            .toString(),
                                        Date: snapshot.data[0].QuoteDate
                                            .toString(),
                                        FinancialYear: snapshot
                                            .data[0].FinancialYear
                                            .toString(),
                                        EmailId: snapshot
                                            .data[0].SupplierPOCEmailID
                                            .toString(),
                                        POCTel: snapshot.data[0].SupplierPOCTel
                                            .toString(),
                                        POCMob: snapshot.data[0].SupplierPOCMob
                                            .toString(),
                                        POCName: snapshot
                                            .data[0].SupplierPOCName
                                            .toString(),
                                      ),
                                    ],
                                  ),
                                ),
                                Center(
                                  child: Column(
                                    children: [
                                      const SizedBox(height: 30),
                                      PoBuyerCard(
                                        Name: snapshot.data[0].BuyerName
                                            .toString(),
                                        EmailId: snapshot.data[0].BuyerEmailID
                                            .toString(),
                                        Tel: snapshot.data[0].BuyerMob
                                            .toString(),
                                        Mob: snapshot.data[0].BuyerTel
                                            .toString(),
                                      ),
                                    ],
                                  ),
                                ),
                                Center(
                                  child: Column(
                                    children: [
                                      const SizedBox(height: 30),
                                      PoBankCard(
                                        AccountNo: snapshot.data[0].AccountNo
                                            .toString(),
                                        Name: snapshot.data[0].AccountName
                                            .toString(),
                                        Branch: snapshot.data[0].BankBranch
                                            .toString(),
                                        IFSCCode: snapshot.data[0].BankIFSCCode
                                            .toString(),
                                        ZipCode: snapshot.data[0].BankZipCode
                                            .toString(),
                                        Street: snapshot.data[0].BankStreet
                                            .toString(),
                                        City: snapshot.data[0].BankCity
                                            .toString(),
                                        State: snapshot.data[0].BankState
                                            .toString(),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Shimmer(
                          duration: const Duration(seconds: 2),
                          interval: const Duration(seconds: 1),
                          color: Colors.white,
                          colorOpacity: 1,
                          enabled: true,
                          direction: const ShimmerDirection.fromLTRB(),
                          child: Container(
                            height: 40,
                            width: 118,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: ElevatedButton(
                              onPressed: () async {
                                await approvePo.getApprovePo(widget.POTxnID);
                                if (AppController.message != null) {
                                  Get.defaultDialog(
                                    title: "Success!",
                                    middleText: "${AppController.message}",
                                    textConfirm: "OK",
                                    confirmTextColor: Colors.white,
                                    onConfirm: () async {
                                      await poLogCont.getPoLogDetails();
                                      // Get.offAll(PoLogDetailsScreen());
                                    },
                                  );
                                  return;
                                }
                              },
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Center(
                                    child: Text(
                                      'Approve',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 16),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )),
                      Shimmer(
                          duration: const Duration(seconds: 2),
                          // This is NOT the default value. Default value: Duration(seconds: 0)
                          interval: const Duration(seconds: 1),
                          // This is the default value
                          color: Colors.white,
                          // This is the default value
                          colorOpacity: 1,
                          // This is the default value
                          enabled: true,
                          // This is the default value
                          direction: const ShimmerDirection.fromLTRB(),
                          child: Container(
                            height: 40,
                            width: 118,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: ElevatedButton(
                              onPressed: () async {
                                await rejectPo.getRejectPo(widget.POTxnID);
                                if (AppController.message != null) {
                                  Get.defaultDialog(
                                    title: "Success!",
                                    middleText: "${AppController.message}",
                                    textConfirm: "OK",
                                    confirmTextColor: Colors.white,
                                    onConfirm: () async {
                                      await poLogCont.getPoLogDetails();
                                      // Get.off(PoLogDetailsScreen());
                                    },
                                  );
                                  return;
                                }
                              },
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Center(
                                    child: Text(
                                      'Reject',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 18),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )),
                    ],
                  ),
                  const SizedBox(height: 10),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
