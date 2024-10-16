import 'package:erp_copy/controllers/delivery_terms_controller/get_delivery_terms_controller.dart';
import 'package:erp_copy/controllers/payment_terms_controller/get_payment_terms_controller.dart';
import 'package:erp_copy/controllers/po_controllers/po_details_controller.dart';
import 'package:erp_copy/controllers/po_controllers/vendor_datiails_byid_ammendment_controller.dart';
import 'package:erp_copy/controllers/vendor_master_controller/vendor_list_pdf_controller.dart';
import 'package:erp_copy/model/delivery_terms/delivery_terms_model.dart';
import 'package:erp_copy/model/payment_terms/payment_terms_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class POAmendmentScreen extends StatefulWidget {
  const POAmendmentScreen(
      {Key? key, required this.vendorID, required this.poTxnid})
      : super(key: key);
  final String vendorID;
  final int poTxnid;

  @override
  State<POAmendmentScreen> createState() => _POAmendmentScreenState();
}

class _POAmendmentScreenState extends State<POAmendmentScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = true;

  // Controllers
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

  DeliveryTermsModel? _selectedDeliveryTerm;
  PaymentTermsModel? _selectedPaymentTerm;

  List<Map<String, dynamic>> poItems = [];

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
        _stateNameController.text = vendorDetails.bankState ?? '';
        _codeController.text = vendorDetails.bankZipCode ?? '';
        _gstinController.text = vendorDetails.gstNumber ?? '';
        _msmeController.text = vendorDetails.msme ?? '';
        _vendorEmailController.text = vendorDetails.emailID ?? '';
        _vendorTelController.text = vendorDetails.telephone ?? '';
        _vendorMobileController.text = vendorDetails.mobilePhone ?? '';
      }

      // Load PO details
      await podbsidc.getPoDetailsById(widget.poTxnid.toString());
      if (podbsidc.poDetailsById.isNotEmpty) {
        final poDetails = podbsidc.poDetailsById.first;
        _poCodeController.text = poDetails.PODetailsID ?? '';
        _revNoController.text = poDetails.RevisionNumber?.toString() ?? '';
        _poDateController.text = poDetails.QuoteDate ?? '';
        _buyerNameController.text = poDetails.BuyerName ?? '';
        _buyerEmailController.text = poDetails.BuyerEmailID ?? '';
        _buyerTelController.text = poDetails.BuyerTel ?? '';
        _buyerMobileController.text = poDetails.BuyerMob ?? '';
        _quoteDateController.text = poDetails.QuoteDate ?? '';
        _basicTotalController.text = poDetails.LineTotal?.toString() ?? '';
        _taxController.text = poDetails.TaxCode?.toString() ?? '';
        _grandTotalController.text = poDetails.LineTotal?.toString() ?? '';
        _refNoController.text = poDetails.RevisionNumber ?? '';
      }

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
            _buildTextField('Vendor Name', _vendorNameController),
            Obx(() => DropdownButtonFormField<DeliveryTermsModel>(
                  value: gdtc.selectedTerm.value,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  items: gdtc.deliveryTermsList.map((term) {
                    return DropdownMenuItem<DeliveryTermsModel>(
                      value: term,
                      child: Text(term.terms ?? ''),
                    );
                  }).toList(),
                  onChanged: (DeliveryTermsModel? newValue) {
                    if (newValue != null) {
                      gdtc.selectedTerm.value = newValue;
                    }
                  },
                )),
            const SizedBox(height: 8),
            Obx(() => DropdownButtonFormField<PaymentTermsModel>(
                  value: gptc.selectedPaymentTerm.value,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  items: gptc.paymentTermsList.map((term) {
                    return DropdownMenuItem<PaymentTermsModel>(
                      value: term,
                      child: Text(term.terms ?? ''),
                    );
                  }).toList(),
                  onChanged: (PaymentTermsModel? newValue) {
                    if (newValue != null) {
                      gptc.selectedPaymentTerm.value = newValue;
                    }
                  },
                )),
            _buildTextField('Address Line 1', _addressLine1Controller),
            _buildTextField('Address Line 2', _addressLine2Controller),
            _buildTextField('Address Line 3', _addressLine3Controller),
            Row(
              children: [
                Expanded(
                  child: _buildTextField('State Name', _stateNameController),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildTextField('Code', _codeController),
                ),
              ],
            ),
            _buildTextField('GSTIN/UIN Code', _gstinController),
            _buildTextField('MSME No.', _msmeController),
            _buildTextField('Email ID', _vendorEmailController),
            Row(
              children: [
                Expanded(
                  child: _buildTextField('Tel (O)', _vendorTelController),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildTextField('Tel (M)', _vendorMobileController),
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
                  child: _buildTextField('PO Code', _poCodeController),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildTextField('Rev. No', _revNoController),
                ),
              ],
            ),
            _buildTextField('PO Date', _poDateController),
            _buildTextField('Buyer Name', _buyerNameController),
            _buildTextField('Email ID', _buyerEmailController),
            Row(
              children: [
                Expanded(
                  child: _buildTextField('Tel (O)', _buyerTelController),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildTextField('Tel (M)', _buyerMobileController),
                ),
              ],
            ),
            _buildTextField('Quote Date', _quoteDateController),
            _buildTextField('Basic Total', _basicTotalController),
            _buildTextField('Tax', _taxController),
            _buildTextField('Grand Total', _grandTotalController),
            _buildTextField('Ref No.', _refNoController),
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
              DataTable(
                columns: const [
                  DataColumn(label: Text('SR NO.')),
                  DataColumn(label: Text('File Name')),
                  DataColumn(label: Text('Action')),
                ],
                rows: [
                  DataRow(cells: [
                    const DataCell(Text('1')),
                    const DataCell(Text('2024-bentley-3840x2160-17316.jpg')),
                    DataCell(
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                        ),
                        child: const Text('View'),
                      ),
                    ),
                  ]),
                ],
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.upload_file),
                label: const Text('Choose files'),
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
              child: DataTable(
                columns: const [
                  DataColumn(label: Text('SR NO.')),
                  DataColumn(label: Text('Item Name')),
                  DataColumn(label: Text('Item Group')),
                  DataColumn(label: Text('Venus Id')),
                  DataColumn(label: Text('HSN Code')),
                  DataColumn(label: Text('PO Quantity')),
                  DataColumn(label: Text('Purchase UOM')),
                  DataColumn(label: Text('Delivery Date')),
                ],
                rows: const [
                  DataRow(cells: [
                    DataCell(Text('1')),
                    DataCell(Text('Xanthan Gum')),
                    DataCell(Text('Anode - Raw materials')),
                    DataCell(Text('1000001301')),
                    DataCell(Text('39139090')),
                    DataCell(Text('1')),
                    DataCell(Text('KGS')),
                    DataCell(Text('15/09/2024')),
                  ]),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
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

  void _handleSubmit() {
    if (_formKey.currentState!.validate()) {
      // Handle form submission
      print('Form is valid. Processing submission...');
    }
  }
}
