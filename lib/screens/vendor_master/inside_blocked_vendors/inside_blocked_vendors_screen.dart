import 'package:erp_copy/controllers/vendor_master_controller/approve_reject_blocked_vendor_controller.dart';
import 'package:erp_copy/controllers/vendor_master_controller/vendor_list_pdf_controller.dart';
import 'package:erp_copy/model/vendor_master/get_blocked_list_vendors_model.dart';
import 'package:erp_copy/screens/pdf_view_screen/pdf_view_screen.dart';
import 'package:erp_copy/widget/vendor_cards/vendor_master_details_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class InsideBlockedVendorsScreen extends StatefulWidget {
  const InsideBlockedVendorsScreen({super.key, required this.selectedItem});

  final GetBlockedVendorListModel selectedItem;

  @override
  State<InsideBlockedVendorsScreen> createState() =>
      _InsideBlockedVendorsScreenState();
}

class _InsideBlockedVendorsScreenState
    extends State<InsideBlockedVendorsScreen> {
  final GetVendorMasterPdfController gvmpc = GetVendorMasterPdfController();

  final ApproveRejectBlockedVendorController arbvc =
      Get.put(ApproveRejectBlockedVendorController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 68, 168, 71),
        title: const Text('Vendor details',
            style: TextStyle(color: Colors.white, fontSize: 15)),
        actions: [
          ElevatedButton(
            onPressed: () async {
              if (widget.selectedItem.vcTxnID != null) {
                try {
                  int vcTxnID =
                      int.parse(widget.selectedItem.vcTxnID.toString()!);
                  await gvmpc.getVednorMaster(vcTxnID, 'VCTxnID');

                  if (gvmpc.getVednorPdf.isNotEmpty &&
                      gvmpc.getVednorPdf.first.filePath != null) {
                    String filePath = gvmpc.getVednorPdf.first.filePath!;
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) =>
                            PdfViewerScreen(filePath: filePath),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('PDF not available.')),
                    );
                  }
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Invalid transaction ID')),
                  );
                }
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Transaction ID is missing.')),
                );
              }
            },
            child: const Text('View PDF'),
          ),
          const SizedBox(width: 20),
        ],
      ),
      body: Stack(children: [
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              children: [
                VendorDetailsCard(
                  vendorName: widget.selectedItem.vendorName ?? 'N/A',
                  vendorGroup: widget.selectedItem.vendorGroup ?? 'N/A',
                  paymentTerms: widget.selectedItem.paymentTerms ?? 'N/A',
                  vendorCurrency: widget.selectedItem.vendorCurrency ?? 'N/A',
                  telephone: widget.selectedItem.telephone ?? 'N/A',
                  mobilePhone: widget.selectedItem.mobilePhone ?? 'N/A',
                  emailID: widget.selectedItem.emailID ?? 'N/A',
                  website: widget.selectedItem.website ?? 'N/A',
                  billToAddressL1: widget.selectedItem.billToAddressL1 ?? 'N/A',
                  billToAddressL2: widget.selectedItem.billToAddressL2 ?? 'N/A',
                  billToAddressL3: widget.selectedItem.billToAddressL3 ?? 'N/A',
                  billToZipCode: widget.selectedItem.billToZipCode ?? 'N/A',
                  billToCity: widget.selectedItem.billToCity ?? 'N/A',
                  billToState: widget.selectedItem.billToState ?? 'N/A',
                  billToCountry: widget.selectedItem.billToCountry ?? 'N/A',
                  gstNumber: widget.selectedItem.gstNumber ?? 'N/A',
                  gstRegType: widget.selectedItem.gstRegType ?? 'N/A',
                  msme: widget.selectedItem.msme ?? 'N/A',
                  pan: widget.selectedItem.pan ?? 'N/A',
                  accountNo: widget.selectedItem.accountNo ?? 'N/A',
                  accountName: widget.selectedItem.accountName ?? 'N/A',
                  bankIFSCCode: widget.selectedItem.bankIFSCCode ?? 'N/A',
                  bankBranch: widget.selectedItem.bankBranch ?? 'N/A',
                  bankZipCode: widget.selectedItem.bankZipCode ?? 'N/A',
                  bankStreet: widget.selectedItem.bankStreet ?? 'N/A',
                  bankCity: widget.selectedItem.bankCity ?? 'N/A',
                  bankState: widget.selectedItem.bankState ?? 'N/A',
                ),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 20,
          left: 20,
          right: 20,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Shimmer(
                duration: const Duration(seconds: 2),
                interval: const Duration(seconds: 1),
                color: Colors.white,
                colorOpacity: 1,
                enabled: true,
                direction: const ShimmerDirection.fromLTRB(),
                child: Container(
                  height: 50,
                  width: 118,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                    ),
                    onPressed: () async {
                      await arbvc.approve(
                          widget.selectedItem.vendorID!.toInt(), 1);
                    },
                    child: const Text(
                      'Approve',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
              Shimmer(
                duration: const Duration(seconds: 2),
                interval: const Duration(seconds: 1),
                color: Colors.white,
                colorOpacity: 1,
                enabled: true,
                direction: const ShimmerDirection.fromLTRB(),
                child: Container(
                  height: 50,
                  width: 118,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                    ),
                    onPressed: () async {
                      await arbvc.approve(
                          widget.selectedItem.vendorID!.toInt(), 2);
                    },
                    child: const Text(
                      'Reject',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
