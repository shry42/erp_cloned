import 'package:erp_copy/controllers/vendor_master_controller/vendor_list_pdf_controller.dart';
import 'package:erp_copy/model/vendor_master/vendor_master_model.dart';
import 'package:erp_copy/screens/pdf_view_screen/pdf_view_screen.dart';
import 'package:erp_copy/widget/vendor_cards/vendor_master_details_card.dart';
import 'package:flutter/material.dart';

class VendorMasterDetailsScreen extends StatefulWidget {
  const VendorMasterDetailsScreen({super.key, required this.selectedItem});

  final VendorModel selectedItem;

  @override
  State<VendorMasterDetailsScreen> createState() =>
      _VendorMasterDetailsScreenState();
}

class _VendorMasterDetailsScreenState extends State<VendorMasterDetailsScreen> {
  final GetVendorMasterPdfController gvmpc = GetVendorMasterPdfController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 68, 168, 71),
        title: const Text('Vendor details',
            style: TextStyle(color: Colors.white, fontSize: 15)),
        actions: [
          const SizedBox(width: 10),
          ElevatedButton(
            onPressed: () async {
              if (widget.selectedItem.vcTxnID != null) {
                try {
                  int vcTxnID = int.parse(widget.selectedItem.vcTxnID!);
                  await gvmpc.getVednorMaster(vcTxnID);

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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: VendorDetailsCard(
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
        ),
      ),
    );
  }
}
