import 'package:erp_copy/controllers/po_controllers/generate_po_getpdf_controller.dart';
import 'package:erp_copy/controllers/po_controllers/get_approved_po_controllers.dart';
import 'package:erp_copy/controllers/po_controllers/po_details_controller.dart';
import 'package:erp_copy/controllers/vendor_master_controller/vendor_master_list_controller.dart';
import 'package:erp_copy/model/vendor_master/vendor_master_model.dart';
import 'package:erp_copy/models/po_models/get_approved_po_%20model.dart';
import 'package:erp_copy/screens/pdf_view_screen/pdf_view_screen.dart';
import 'package:erp_copy/widget/menu_widget/drawer_menu_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GeneratePOScreen extends StatefulWidget {
  const GeneratePOScreen({Key? key, required this.openDrawer})
      : super(key: key);
  final VoidCallback openDrawer;

  @override
  _GeneratePOScreenState createState() => _GeneratePOScreenState();
}

class _GeneratePOScreenState extends State<GeneratePOScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _searchController = TextEditingController();
  final GetApprovedPOController _controller =
      Get.put(GetApprovedPOController());
  final GeneratePOGetPdfController _pdfController =
      Get.put(GeneratePOGetPdfController());
  final GetVendorMastercontroller _gvmc = Get.put(GetVendorMastercontroller());
  final PoDetailsSelectByItemIdController _poDetailsController =
      PoDetailsSelectByItemIdController();

  // State variable to keep track of the selected PO
  GetApprovedPoModel? _selectedPO;
  String tax = '';
  String grandTotal = '';
  String basicTotal = "";
  String vendorName = "";
  String addressLine1 = '';
  String addressLine2 = '';
  String addressLine3 = '';
  String stateName = "";
  String code = "";
  String GSTIN = "";
  String MSME = "";
  String DeliveryTerms = "";
  String PaymentTerms = "";
  String name = "";
  String emailID = "";
  String telo = "";
  String telm = "";

  Future<void> _fetchPoDetails(String poTxnID) async {
    var poDetails = await _poDetailsController.getPoDetailsById(poTxnID);
    if (poDetails.isNotEmpty) {
      setState(() {
        // Assuming tax and grandTotal are part of the model
        tax = poDetails.first.TaxAmt
            .toString(); // Replace 'tax' with the actual field name
        basicTotal = poDetails.first.LineTotal.toString();
        grandTotal = poDetails.first.FinalAmt
            .toString(); // Replace 'grandTotal' with the actual field name
      });
    }
  }

  Future<void> _fetchVendorList() async {
    try {
      // Fetch vendor list from the controller
      await _gvmc.getVednorMaster();

      // Ensure the vendor list is updated
      var vendorList = _gvmc.getVendorList;

      // Check if vendor list is not empty and set the state accordingly
      if (vendorList.isNotEmpty) {
        // Find the selected vendor from the list
        VendorModel? selectedVendor = vendorList.firstWhereOrNull(
          (vendor) => vendor.vendorID == _selectedPO?.vendorID,
        );

        if (selectedVendor != null) {
          setState(() {
            // Update the state variables with the selected vendor details
            vendorName = selectedVendor.vendorName ?? '';
            addressLine1 = selectedVendor.billToAddressL1 ?? '';
            addressLine2 = selectedVendor.billToAddressL2 ?? '';
            addressLine3 = selectedVendor.billToAddressL3 ?? '';
            stateName = selectedVendor.billToState ?? '';
            code = selectedVendor.billToZipCode ?? '';
            GSTIN = selectedVendor.gstNumber ?? '';
            MSME = selectedVendor.msme ?? '';
            PaymentTerms = selectedVendor.paymentTerms ?? '';
            name = selectedVendor.accountName ?? '';
            emailID = selectedVendor.emailID ?? '';
            telo = selectedVendor.telephone ?? '';
            telm = selectedVendor.mobilePhone ?? '';
          });
        } else {
          print("Selected vendor not found");
        }
      } else {
        print("No vendors found");
      }
    } catch (e) {
      print("Error fetching vendor list: $e");
      // Handle error gracefully, maybe show a snackbar or alert
    }
  }

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      // Add search filter logic here if needed
    });

    // Fetch data from API
    _controller.getVednorMaster();
    _fetchVendorList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 245, 245, 245),
      appBar: AppBar(
        title: const Text('Generate PO'),
        backgroundColor: const Color.fromARGB(255, 29, 169, 32),
        actions: [
          ElevatedButton(
            onPressed: () {
              if (_selectedPO != null) {
                _generatePO(_selectedPO!.poTxnID!);
              } else {
                Get.snackbar(
                  "No PO Selected",
                  "Please select a PO to generate.",
                  snackPosition: SnackPosition.BOTTOM,
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: const BorderSide(color: Colors.grey),
              ),
            ),
            child: const Text(
              'Generate PO',
              style: TextStyle(fontSize: 12, color: Colors.black),
            ),
          ),
          DrawerMenuWidget(
            onClicked: widget.openDrawer,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPOListSection(), // PO List Table
            const SizedBox(height: 16),
            _buildRow('PO Code', '${_selectedPO?.poCode ?? ''}', 'Rev. No',
                '${_selectedPO?.revisionNumber ?? ''}'),
            _buildSingleField('PO Date', '${_selectedPO?.poDate ?? ''}'),
            _buildSingleField('Buyer Name', '${_selectedPO?.buyerName ?? ''}'),
            _buildSingleField('Email ID', '${_selectedPO?.buyerEmailID ?? ''}'),
            _buildRow('Tel (O)', '${_selectedPO?.buyerMob}', 'Tel (M)',
                '${_selectedPO?.buyerTel ?? ''}'),
            _buildRow('Quote Date', '${_selectedPO?.quoteDate ?? ''}',
                'Basic Total', basicTotal),
            _buildRow(
                'Email ID', '${_selectedPO?.buyerEmailID ?? ''}', 'Tax', tax),
            _buildRow('Ref No.', 'ref no.', 'Grand Total', grandTotal),
            const SizedBox(height: 24),
            const Padding(
              padding: EdgeInsets.only(left: 12),
              child: Text('Vendor Details',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black)),
            ),
            SizedBox(height: 16),

            // New vendor details fields
            Obx(() {
              // Get the selected vendor ID from _selectedPO
              int? selectedVendorId = _selectedPO?.vendorID;

              // Find the matching vendor from the list
              VendorModel? selectedVendor = _gvmc.getVendorList
                  .firstWhereOrNull(
                      (vendor) => vendor.vendorID == selectedVendorId);

              return selectedVendor != null
                  ? Column(
                      children: [
                        _buildSingleField('Vendor Name',
                            '${selectedVendor.vendorName ?? ''}'),
                        _buildSingleField('Address Line 1',
                            '${selectedVendor.billToAddressL1 ?? ''}'),
                        _buildSingleField('Address Line 2',
                            '${selectedVendor.billToAddressL2 ?? ''}'),
                        _buildSingleField('Address Line 3',
                            '${selectedVendor.billToAddressL3 ?? ''}'),
                        _buildRow(
                            'State Name',
                            '${selectedVendor.billToState ?? ''}',
                            'Code',
                            '${selectedVendor.billToZipCode ?? ''}'),
                        _buildSingleField('GSTIN/UIN Code',
                            '${selectedVendor.gstNumber ?? ''}'),
                        _buildSingleField(
                            'MSME No.', '${selectedVendor.msme ?? ''}'),
                        _buildSingleField('Payment Terms',
                            '${selectedVendor.paymentTerms ?? ''}'),
                        _buildSingleField(
                            'Name', '${selectedVendor.accountName ?? 'N/A'}'),
                        _buildSingleField(
                            'Email ID', '${selectedVendor.emailID ?? ''}'),
                        _buildRow(
                            'Tel (O)',
                            '${selectedVendor.telephone ?? ''}',
                            'Tel (M)',
                            '${selectedVendor.mobilePhone ?? ''}'),
                      ],
                    )
                  : Center(child: Text('No vendor selected or found'));
            }),
          ],
        ),
      ),
    );
  }

  Future<void> _generatePO(int poTxnID) async {
    final response = await _pdfController.generatePO(poTxnID);

    if (response != null && response['status'] == true) {
      final pdfPath = response['data'];
      if (pdfPath != null) {
        Get.defaultDialog(
          title: "PDF Ready",
          middleText: "Do you want to view the PDF?",
          textConfirm: "View",
          textCancel: "Cancel",
          confirmTextColor: Colors.white,
          onConfirm: () {
            Get.to(() => PdfViewerScreen(filePath: pdfPath));
          },
          onCancel: () {
            Get.back();
          },
        );
      }
    }
  }

  Widget _buildPOListSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'PO List',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _searchController,
          style: const TextStyle(color: Colors.black),
          onChanged: (text) {
            setState(() {
              // Trigger a rebuild when search text changes
            });
          },
          decoration: InputDecoration(
            labelText: 'Search by PO Code',
            prefixIcon: const Icon(Icons.search, color: Colors.grey),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(
                  color: Color(0xFF333333)), // Blackish grey border color
            ),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            filled: true,
            fillColor: Colors.white,
          ),
        ),
        const SizedBox(height: 10),
        Obx(() {
          // Make sure getApprovedPoList is an observable list
          final dataToShow = _controller.getApprovedPoList
              .where((poData) =>
                  _searchController.text.isEmpty ||
                  (poData.poCode ?? '').contains(_searchController.text))
              .take(4)
              .toList();

          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columnSpacing: 20,
                headingRowColor: MaterialStateColor.resolveWith(
                    (states) => Colors.grey.shade300),
                dataRowColor:
                    MaterialStateColor.resolveWith((states) => Colors.white),
                dividerThickness: 1,
                columns: const [
                  DataColumn(
                      label: Text('Select',
                          style: TextStyle(color: Colors.black))),
                  DataColumn(
                      label: Text('SR NO.',
                          style: TextStyle(color: Colors.black))),
                  DataColumn(
                      label: Text('PO Code',
                          style: TextStyle(color: Colors.black))),
                  DataColumn(
                      label: Text('PO Date',
                          style: TextStyle(color: Colors.black))),
                  DataColumn(
                      label:
                          Text('Info', style: TextStyle(color: Colors.black))),
                ],
                rows: List.generate(dataToShow.length, (index) {
                  final poData = dataToShow[index];
                  return DataRow(
                    cells: [
                      DataCell(
                        Checkbox(
                          value: _selectedPO == poData,
                          onChanged: (bool? value) {
                            setState(() {
                              if (value == true) {
                                _selectedPO = poData;
                                _fetchPoDetails(
                                    _selectedPO!.poTxnID.toString());
                              } else {
                                _selectedPO = null;
                              }
                            });
                          },
                        ),
                      ),
                      DataCell(Text((index + 1).toString(),
                          style: const TextStyle(color: Colors.black))),
                      DataCell(Text(poData.poCode ?? '',
                          style: const TextStyle(color: Colors.black))),
                      DataCell(Text(
                          poData.poDate != null
                              ? '${poData.poDate!.month}/${poData.poDate!.day}/${poData.poDate!.year}'
                              : '',
                          style: const TextStyle(color: Colors.black))),
                      DataCell(
                        IconButton(
                          icon: const Icon(Icons.info_outline,
                              color: Colors.blueGrey),
                          onPressed: () {
                            // Implement info button functionality here
                          },
                        ),
                      ),
                    ],
                  );
                }),
              ),
            ),
          );
        }),
      ],
    );
  }

  Widget _buildDialogTextField(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        initialValue: value,
        readOnly: true,
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(
                color: Color(0xFF333333)), // Blackish grey border color
          ),
        ),
        style: const TextStyle(color: Colors.black), // Ensure text is visible
      ),
    );
  }

  Widget _buildRow(String label1, String value1, String label2, String value2) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(child: _buildTextField(label1, value1)),
          SizedBox(width: 16),
          Expanded(child: _buildTextField(label2, value2)),
        ],
      ),
    );
  }

  Widget _buildSingleField(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: _buildTextField(label, value),
    );
  }

  Widget _buildTextField(String label, String value) {
    return TextField(
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(
              color: Color(0xFF333333)), // Blackish grey border color
        ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        filled: true,
        fillColor: Colors.white,
        labelStyle:
            const TextStyle(color: Colors.black), // Ensure label is visible
      ),
      controller: TextEditingController(text: value),
      style: const TextStyle(color: Colors.black), // Ensure text is visible
      enabled: false,
    );
  }
}
