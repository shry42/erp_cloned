import 'package:erp_copy/controllers/delivery_terms_controller/get_delivery_terms_controller.dart';
import 'package:erp_copy/controllers/payment_terms_controller/get_payment_terms_controller.dart';
import 'package:erp_copy/controllers/po_controllers/ammend_po_controller.dart';
import 'package:erp_copy/controllers/po_controllers/po_details_controller.dart';
import 'package:erp_copy/controllers/po_controllers/vendor_datiails_byid_ammendment_controller.dart';
import 'package:erp_copy/controllers/vendor_master_controller/vendor_list_pdf_controller.dart';
import 'package:erp_copy/model/delivery_terms/delivery_terms_model.dart';
import 'package:erp_copy/model/payment_terms/payment_terms_model.dart';
import 'package:erp_copy/screens/pdf_view_screen/pdf_view_screen.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class POAmendmentScreen extends StatefulWidget {
  const POAmendmentScreen({
    Key? key,
    required this.vendorID,
    required this.poTxnid,
    required this.headerNote,
    required this.supplierPOCName,
    required this.poCode,
    required this.poDate,
  }) : super(key: key);
  final String vendorID, headerNote, supplierPOCName, poCode, poDate;
  final int poTxnid;

  @override
  State<POAmendmentScreen> createState() => _POAmendmentScreenState();
}

class _POAmendmentScreenState extends State<POAmendmentScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = true;

  // Controllers

  // Add AmmendPoController
  final AmmendPoController amendPoController = Get.put(AmmendPoController());
  PlatformFile? selectedFile;

  final GetDeliveryTermsController gdtc = Get.put(GetDeliveryTermsController());
  final GetPaymentTermsController gptc = Get.put(GetPaymentTermsController());
  final VendorDatiailsByidAmmendmentController vdbid =
      Get.put(VendorDatiailsByidAmmendmentController());
  final GetVendorMasterPdfController gvmpdfc =
      Get.put(GetVendorMasterPdfController());
  final PoDetailsSelectByItemIdController podbsidc =
      Get.put(PoDetailsSelectByItemIdController());

  // Vendor Details Controllers
  final _vendorNameController = TextEditingController();
  final _addressLine1Controller = TextEditingController();
  final _addressLine2Controller = TextEditingController();
  final _addressLine3Controller = TextEditingController();
  final _stateNameController = TextEditingController();
  final _codeController = TextEditingController();
  final _gstinController = TextEditingController();
  final _msmeController = TextEditingController();
  final _headerNoteController = TextEditingController();
  final _vendorEmailController = TextEditingController();
  final _vendorTelController = TextEditingController();
  final _vendorMobileController = TextEditingController();

  // PO Details Controllers
  final _poCodeController = TextEditingController();
  final _revNoController = TextEditingController();
  final _poDateController = TextEditingController();
  final _buyerNameController = TextEditingController();
  final _buyerEmailController = TextEditingController();
  final _buyerTelController = TextEditingController();
  final _buyerMobileController = TextEditingController();
  final _quoteDateController = TextEditingController();
  final _basicTotalController = TextEditingController();
  final _taxController = TextEditingController();
  final _grandTotalController = TextEditingController();
  final _refNoController = TextEditingController();
  final _supplierPOCNameController = TextEditingController();

  DeliveryTermsModel? _selectedDeliveryTerm;
  PaymentTermsModel? _selectedPaymentTerm;

  List<Map<String, dynamic>> poItems = [];

  // Add this method to handle file selection
  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx'],
    );

    if (result != null) {
      setState(() {
        selectedFile = result.files.first;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // Load vendor details
      await vdbid.getVendorById(widget.vendorID);
      if (vdbid.PoVendorDetailsObjList.isNotEmpty) {
        final vendorDetails = vdbid.PoVendorDetailsObjList.first;
        _vendorNameController.text = vendorDetails.vendorName ?? '';
        _addressLine1Controller.text = vendorDetails.billToAddressL1 ?? '';
        _addressLine2Controller.text = vendorDetails.billToAddressL2 ?? '';
        _addressLine3Controller.text = vendorDetails.billToAddressL3 ?? '';
        _stateNameController.text = vendorDetails.billToState ?? '';
        _codeController.text = vendorDetails.bankZipCode ?? '';
        _gstinController.text = vendorDetails.gstNumber ?? '';
        _msmeController.text = vendorDetails.msme ?? '';
        _vendorEmailController.text = vendorDetails.emailID ?? '';
        _vendorTelController.text = vendorDetails.telephone ?? '';
        _vendorMobileController.text = vendorDetails.mobilePhone ?? '';
        _headerNoteController.text = widget.headerNote;
        _supplierPOCNameController.text = widget.supplierPOCName;
      }

      // Load PO details
      await podbsidc.getPoDetailsById(widget.poTxnid.toString());
      if (podbsidc.poDetailsById.isNotEmpty) {
        final poDetails = podbsidc.poDetailsById.first;
        _poCodeController.text = widget.poCode;
        _revNoController.text = poDetails.RevisionNumber?.toString() ?? '';
        _poDateController.text = widget.poDate;
        _buyerNameController.text = poDetails.BuyerName ?? '';
        _buyerEmailController.text = poDetails.BuyerEmailID ?? '';
        _buyerTelController.text = poDetails.BuyerTel ?? '';
        _buyerMobileController.text = poDetails.BuyerMob ?? '';
        _quoteDateController.text = poDetails.QuoteDate.split('T')[0] ?? '';
        _basicTotalController.text = poDetails.LineTotal?.toString() ?? '';
        _taxController.text = poDetails.TaxCode?.toString() ?? '';
        _grandTotalController.text = poDetails.LineTotal?.toString() ?? '';
        _refNoController.text = poDetails.RevisionNumber ?? '';
      }

      gvmpdfc.getVednorMaster(widget.poTxnid, 'POTxnID', showPdf: true);

      // Load delivery terms
      await gdtc.getDeliveryTerms();
      if (gdtc.deliveryTermsList.isNotEmpty) {
        _selectedDeliveryTerm = gdtc.selectedTerm.value;
      }

      // Load payment terms
      await gptc.getPaymentTerms();
      if (gptc.paymentTermsList.isNotEmpty) {
        _selectedPaymentTerm = gptc.selectedPaymentTerm.value;
      }
    } catch (e) {
      print('Error loading data: $e');
      // Handle error (e.g., show a snackbar)
      Get.snackbar(
        'Error',
        'Failed to load data. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PO Amendment'),
        backgroundColor: Colors.green,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildVendorDetailsCard(),
                    const SizedBox(height: 16),
                    _buildPODetailsCard(),
                    const SizedBox(height: 16),
                    _buildAttachedDocumentsCard(),
                    const SizedBox(height: 16),
                    _buildPOItemsListCard(),
                    const SizedBox(height: 16),
                    Center(
                      child: ElevatedButton(
                        onPressed: _handleSubmit,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 32,
                            vertical: 16,
                          ),
                        ),
                        child: const Text('Submit'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildVendorDetailsCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Vendor Details',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildTextField('Vendor Name', _vendorNameController,
                readOnly: true),
            Obx(() => Container(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: DropdownButtonFormField<DeliveryTermsModel>(
                    value: gdtc.selectedTerm.value,
                    isExpanded: true, // Makes the dropdown take full width
                    decoration: InputDecoration(
                      labelText: 'Delivery Terms',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                    ),
                    items: gdtc.deliveryTermsList.map((term) {
                      return DropdownMenuItem<DeliveryTermsModel>(
                        value: term,
                        child: Text(
                          term.terms ?? '',
                          overflow:
                              TextOverflow.ellipsis, // Handles text overflow
                          style: const TextStyle(fontSize: 14),
                        ),
                      );
                    }).toList(),
                    onChanged: (DeliveryTermsModel? newValue) {
                      if (newValue != null) {
                        gdtc.selectedTerm.value = newValue;
                      }
                    },
                  ),
                )),
            Obx(() => Container(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: DropdownButtonFormField<PaymentTermsModel>(
                    value: gptc.selectedPaymentTerm.value,
                    isExpanded: true, // Makes the dropdown take full width
                    decoration: InputDecoration(
                      labelText: 'Payment Terms',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                    ),
                    items: gptc.paymentTermsList.map((term) {
                      return DropdownMenuItem<PaymentTermsModel>(
                        value: term,
                        child: Container(
                          constraints:
                              const BoxConstraints(maxWidth: double.infinity),
                          child: Text(
                            term.terms ?? '',
                            overflow:
                                TextOverflow.ellipsis, // Handles text overflow
                            style: const TextStyle(fontSize: 14),
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (PaymentTermsModel? newValue) {
                      if (newValue != null) {
                        gptc.selectedPaymentTerm.value = newValue;
                      }
                    },
                  ),
                )),
            _buildTextField('Address Line 1', _addressLine1Controller,
                readOnly: true),
            _buildTextField('Address Line 2', _addressLine2Controller,
                readOnly: true),
            _buildTextField('Address Line 3', _addressLine3Controller,
                readOnly: true),
            Row(
              children: [
                Expanded(
                  child: _buildTextField('State Name', _stateNameController,
                      readOnly: true),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child:
                      _buildTextField('Code', _codeController, readOnly: true),
                ),
              ],
            ),
            _buildTextField('GSTIN/UIN Code', _gstinController, readOnly: true),
            _buildTextField('MSME No.', _msmeController, readOnly: true),
            _buildTextField('Name', _supplierPOCNameController),
            _buildTextField('Email ID', _vendorEmailController, readOnly: true),
            Row(
              children: [
                Expanded(
                  child: _buildTextField('Tel (O)', _vendorTelController,
                      readOnly: true),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildTextField('Tel (M)', _vendorMobileController,
                      readOnly: true),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text('Header Note:'),
            TextFormField(
              controller: _headerNoteController,
              maxLines: 3,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter header note',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPODetailsCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'PO Details',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildTextField('PO Code', _poCodeController,
                      readOnly: true),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildTextField('Rev. No', _revNoController,
                      readOnly: true),
                ),
              ],
            ),
            _buildTextField('PO Date', _poDateController, readOnly: true),
            _buildTextField('Buyer Name', _buyerNameController, readOnly: true),
            _buildTextField('Email ID', _buyerEmailController, readOnly: true),
            Row(
              children: [
                Expanded(
                  child: _buildTextField('Tel (O)', _buyerTelController,
                      readOnly: true),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildTextField('Tel (M)', _buyerMobileController,
                      readOnly: true),
                ),
              ],
            ),
            // _buildTextField('Quote Date', _quoteDateController),
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: TextFormField(
                controller: _quoteDateController,
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'Quote Date',
                  labelStyle: const TextStyle(color: Colors.black),
                  border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(8.0), // Added border radius
                  ),
                  // Also adding the same border radius to focused and enabled borders for consistency
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(color: Colors.grey.shade400),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(color: Colors.blue, width: 2),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
                onTap: () async {
                  final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(const Duration(days: 365)),
                  );
                  if (picked != null) {
                    _quoteDateController.text =
                        "${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}";
                  }
                },
              ),
            ),
            _buildTextField('Basic Total', _basicTotalController,
                readOnly: true),
            _buildTextField('Tax', _taxController, readOnly: true),
            _buildTextField('Grand Total', _grandTotalController,
                readOnly: true),
            _buildTextField('Ref No.', _refNoController, readOnly: true),
          ],
        ),
      ),
    );
  }

  Widget _buildAttachedDocumentsCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Attached Documents',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Obx(() => DataTable(
                    columns: const [
                      DataColumn(label: Text('SR NO.')),
                      DataColumn(label: Text('File Name')),
                      DataColumn(label: Text('Action')),
                    ],
                    rows: List<DataRow>.generate(
                      gvmpdfc.vendorPdfList.length,
                      (index) => DataRow(
                        cells: [
                          DataCell(Text('${index + 1}')),
                          DataCell(Text(
                              gvmpdfc.vendorPdfList[index].storedFileName ??
                                  '')),
                          DataCell(
                            ElevatedButton(
                              onPressed: () {
                                if (gvmpdfc.vendorPdfList[index].filePath !=
                                    null) {
                                  Get.to(() => PdfViewerScreen(
                                      filePath: gvmpdfc
                                          .vendorPdfList[index].filePath!));
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                              ),
                              child: const Text('View'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )),
              const SizedBox(height: 16),
              Row(
                children: [
                  ElevatedButton.icon(
                    onPressed: _pickFile,
                    icon: const Icon(Icons.upload_file),
                    label: const Text('Choose files'),
                  ),
                  if (selectedFile != null)
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(selectedFile!.name),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPOItemsListCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'PO Items List',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Obx(() => DataTable(
                    columns: const [
                      DataColumn(label: Text('SR NO.')),
                      DataColumn(label: Text('Item Name')),
                      DataColumn(label: Text('Item Group')),
                      DataColumn(label: Text('Venus Id')),
                      DataColumn(label: Text('HSN Code')),
                      DataColumn(label: Text('PO Quantity')),
                      DataColumn(label: Text('Purchase UOM')),
                      DataColumn(label: Text('Delivery Date')),
                      DataColumn(label: Text('Unit Price')),
                      DataColumn(label: Text('Tax Code')),
                      DataColumn(label: Text('Tax Rate')),
                      DataColumn(label: Text('Line Total')),
                      DataColumn(label: Text('Tax Amount')),
                      DataColumn(label: Text('Final Amount')),
                    ],
                    rows: List<DataRow>.generate(
                      podbsidc.poDeatilsObj.length,
                      (index) {
                        final item = podbsidc.poDeatilsObj[index];
                        // Create controllers for editable fields
                        final hsnController =
                            TextEditingController(text: item.HSN_Code ?? '');
                        final qtyController = TextEditingController(
                            text: item.POQty?.toString() ?? '');
                        final unitPriceController = TextEditingController(
                            text: item.UnitPrice?.toString() ?? '');
                        final deliveryDateController = TextEditingController(
                            text: item.DeliveryDate.split('T')[0] ?? '');

                        return DataRow(
                          cells: [
                            DataCell(Text('${index + 1}')),
                            DataCell(Text(item.ItemName ?? '')),
                            DataCell(Text(item.ItemGroup ?? '')),
                            DataCell(Text(item.SAPID ?? '')),
                            // HSN Code TextFormField
                            DataCell(
                              TextFormField(
                                controller: hsnController,
                                decoration: const InputDecoration(
                                  isDense: true,
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 8),
                                ),
                                onChanged: (value) {
                                  item.HSN_Code = value;
                                },
                              ),
                            ),
                            // PO Quantity TextFormField
                            DataCell(
                              TextFormField(
                                controller: qtyController,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  isDense: true,
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 8),
                                ),
                                onChanged: (value) {
                                  // item.POQty = double.tryParse(value);
                                  // // Recalculate line total and other dependent values
                                  // _updateCalculations(item);
                                },
                              ),
                            ),
                            DataCell(Text(item.PurchaseUOM ?? '')),
                            // Delivery Date Picker
                            DataCell(
                              TextFormField(
                                controller: deliveryDateController,
                                readOnly: true,
                                decoration: const InputDecoration(
                                  isDense: true,
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 8),
                                  suffixIcon:
                                      Icon(Icons.calendar_today, size: 20),
                                ),
                                onTap: () async {
                                  final DateTime? picked = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime.now()
                                        .add(const Duration(days: 365)),
                                  );
                                  if (picked != null) {
                                    deliveryDateController.text =
                                        "${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}";
                                    item.DeliveryDate =
                                        deliveryDateController.text;
                                  }
                                },
                              ),
                            ),
                            // Unit Price TextFormField
                            DataCell(
                              TextFormField(
                                controller: unitPriceController,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  isDense: true,
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 8),
                                ),
                                onChanged: (value) {
                                  item.UnitPrice =
                                      double.tryParse(value).toString();
                                  // Recalculate line total and other dependent values
                                  // _updateCalculations(item);
                                },
                              ),
                            ),
                            DataCell(Text(item.TaxCode ?? '')),
                            DataCell(Text(item.TaxPercent?.toString() ?? '')),
                            DataCell(Text(item.LineTotal?.toString() ?? '')),
                            DataCell(Text(item.TaxAmt ?? '')),
                            DataCell(Text(item.FinalAmt ?? '')),
                          ],
                        );
                      },
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller,
      {bool readOnly = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        readOnly: readOnly,
        style: const TextStyle(color: Colors.black),
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.black),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0), // Added border radius
          ),
          // Also adding the same border radius to focused and enabled borders for consistency
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(color: Colors.grey.shade400),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(color: Colors.blue, width: 2),
          ),
          filled: true,
          fillColor: Colors.white,
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter $label';
          }
          return null;
        },
      ),
    );
  }

  void _handleSubmit() async {
    if (_formKey.currentState!.validate()) {
      try {
        // Prepare the item data from the PO details
        List<Map<String, dynamic>> itemData = podbsidc.poDeatilsObj.map((item) {
          return {
            "PODetailsID": item.PODetailsID,
            "POTxnID": item.POTxnID,
            "ItemID": item.ItemID,
            "SAPID": item.SAPID,
            "ItemName": item.ItemName,
            "HSN_Code": item.HSN_Code,
            "POQty": item.POQty,
            "PurchaseUOM": item.PurchaseUOM,
            "DeliveryDate": item.DeliveryDate,
            "UnitPrice": item.UnitPrice,
            "TaxCode": item.TaxCode,
            "TaxPercent": item.TaxPercent,
            "LineTotal": item.LineTotal,
            "TaxAmt": item.TaxAmt,
            "FinalAmt": item.FinalAmt,
            "pdfURL": null,
            "RevisionNumber": _revNoController.text,
            "BuyerName": _buyerNameController.text,
            "BuyerEmailID": _buyerEmailController.text,
            "BuyerTel": _buyerTelController.text,
            "BuyerMob": _buyerMobileController.text,
            "SupplierPOCName": _supplierPOCNameController.text,
            "DeliveryTerms": gdtc.selectedTerm.value?.terms ?? '',
            "PaymentTerms": gptc.selectedPaymentTerm.value?.terms ?? '',
            "QuoteDate": _quoteDateController.text,
            "Item_Group": item.ItemGroup,
            "PRTxnID": item.PRTxnID,
            "ReqQty": item.ReqQty,
            "RemainingQty": item.RemainingQty,
            "totalQty": item.FinalAmt
          };
        }).toList();

        // Call the amendPo method from the controller
        await amendPoController.amendPo(
          pdfURLLink: selectedFile?.path ?? '',
          type: 'goods',
          quoteDate: _quoteDateController.text,
          supplierPOCName: _supplierPOCNameController.text,
          deliveryTerms: gdtc.selectedTerm.value?.terms ?? '',
          paymentTerms: gptc.selectedPaymentTerm.value?.terms ?? '',
          headerNote: _headerNoteController.text,
          poTxnID: widget.poTxnid.toString(),
          itemData: itemData,
          files: selectedFile,
        );
      } catch (e) {
        Get.snackbar(
          'Error',
          'Failed to submit PO Amendment: $e',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    }
  }
}
