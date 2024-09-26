import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:erp_copy/controllers/grn_controllers/get_grn_no_controller.dart';
import 'package:erp_copy/controllers/grn_controllers/get_po_items_controller.dart';
import 'package:erp_copy/controllers/grn_controllers/get_po_log_by_vendorid_controller.dart';
import 'package:erp_copy/controllers/grn_controllers/grn_basket/grn_basket_controller.dart';
import 'package:erp_copy/controllers/po_controllers/view_po_basket_controller.dart';
import 'package:erp_copy/controllers/vendor_master_controller/vendor_master_list_controller.dart';
import 'package:erp_copy/model/vendor_master/vendor_master_model.dart';
import 'package:erp_copy/models/po_models/get_item_details_by_pr_txnid_model.dart';
import 'package:erp_copy/screens/grn_screens/basket/view_grn_basket.dart';
import 'package:erp_copy/screens/grn_screens/default_dialog_screen/dialog_screen.dart';
import 'package:erp_copy/widget/menu_widget/drawer_menu_widget.dart';
import 'package:file_picker/file_picker.dart'; // Import File Picker
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CreateGRNScreen extends StatefulWidget {
  const CreateGRNScreen({Key? key, required this.openDrawer}) : super(key: key);
  final VoidCallback openDrawer;

  @override
  _CreateGRNScreenState createState() => _CreateGRNScreenState();
}

class _CreateGRNScreenState extends State<CreateGRNScreen> {
  final _formKey = GlobalKey<FormState>();

  final GetVendorMastercontroller _vendorController =
      Get.put(GetVendorMastercontroller());

  final GetGrnNoController _getGrnNoController = Get.put(GetGrnNoController());
  final GetPoLogByVendoridController _getPoLogByVendoridController =
      Get.put(GetPoLogByVendoridController());

  final GetPoItemsController _getPoItemsController =
      Get.put(GetPoItemsController());

  final GRNBasketController _grnBasketController =
      Get.put(GRNBasketController());

  final POBasketController _poBasketController =
      Get.put(POBasketController()); // Add PO basket controller

  final GRNBasketController _grnbasketcont = Get.put(GRNBasketController());

  var selectedVendor = Rx<VendorModel?>(null); // Reactive vendor variable

  var selectedPRTxnID = RxInt(-1); // Reactive PR Transaction ID
  var selectedItems =
      <GetItemDetailsByPRTxnIDModel>[].obs; // Reactive list for selected items
  var selectedItem =
      Rx<GetItemDetailsByPRTxnIDModel?>(null); // Reactive selected item

  String? currentDate;

  TextEditingController _grnDateController = TextEditingController();
  TextEditingController _invoiceDateController = TextEditingController();

  List<PlatformFile> _selectedFiles = []; // List for selected files

  TextEditingController _grnNoController =
      TextEditingController(); // TextEditingController for GRN No

  TextEditingController _invoiceNumberController = TextEditingController();
  TextEditingController _challanNumberController = TextEditingController();
  TextEditingController _remarkController = TextEditingController();

  void _submitGRN() {
    if (_formKey.currentState?.validate() ?? false) {
      _grnBasketController.submitGRNBasket(
        grnDate: _grnDateController.text,
        invoiceNumber: _invoiceNumberController.text,
        invoiceDate: _invoiceDateController.text,
        challanNumber: _challanNumberController.text,
        remark: _remarkController.text,
        files: _selectedFiles,
      );
    }
  }

  @override
  void initState() {
    super.initState();

    currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    _grnDateController.text = currentDate!; // Set initial date
    _getGrnNoController.getGRNNumber();

    _vendorController.getVednorMaster(); // Fetch the vendor data

    // Listen to changes in gateEntryNumber and update the controller
    _getGrnNoController.grnNo.listen((entryNumber) {
      _grnNoController.text = entryNumber ?? '';
    });
  }

  Future<void> _chooseFiles() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: true,
      );

      if (result != null && result.files.isNotEmpty) {
        setState(() {
          _selectedFiles = result.files.length > 5
              ? result.files.sublist(0, 5)
              : result.files;
        });
      }
    } catch (e) {
      print("Error picking files: $e");
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != DateTime.now()) {
      setState(() {
        _grnDateController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  //
  Future<void> _selectDateInvoice(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != DateTime.now()) {
      setState(() {
        _invoiceDateController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  void _removeFile(int index) {
    setState(() {
      _selectedFiles.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 245, 245, 245),
      appBar: AppBar(
        title: const Text('Create GRN '),
        backgroundColor: const Color.fromARGB(255, 29, 169, 32),
        actions: [
          ElevatedButton(
            onPressed: () {
              Get.to(() => ViewGRNBasketScreen(
                    invoiceNumber: _invoiceNumberController.text,
                    invoiceDate: _invoiceDateController.text,
                    grnNumber: _grnNoController.text,
                    grnDate: _grnDateController.text,
                    challanNumber: _challanNumberController.text,
                    remark: _remarkController.text,
                    files: _selectedFiles,
                  ));
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(8), // Adjust the radius as needed
                side:
                    const BorderSide(color: Colors.grey), // Light border color
              ),
            ),
            child: const Text(
              'View basket',
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
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeaderSection(),
              const SizedBox(height: 20),
              _buildVendorDetailsSection(),
              const SizedBox(height: 20),
              _buildInvoiceNumberField(),
              const SizedBox(height: 20),
              _buildInvoiceDateField(),
              const SizedBox(height: 20),
              _buildChallannumber(),
              const SizedBox(height: 20),
              _buildRemark(),
              const SizedBox(height: 20),
              _buildButtonsTabBarSection(),
              // _buildPOListSection(),
              // const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGRNDateField() {
    return GestureDetector(
      onTap: () => _selectDate(context), // Open the date picker
      child: AbsorbPointer(
        child: TextFormField(
          style: const TextStyle(color: Colors.black),
          controller: _grnDateController,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            labelText: 'GRN Date',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6.0), // Border radius of 6
              borderSide: const BorderSide(
                color: Colors.grey, // Grey border color
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6.0), // Border radius of 6
              borderSide: const BorderSide(
                color: Color.fromARGB(
                    255, 206, 200, 200), // Grey border color for enabled state
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6.0), // Border radius of 6
              borderSide: const BorderSide(
                color: Color.fromARGB(
                    255, 229, 226, 226), // Grey border color for focused state
              ),
            ),
            suffixIcon: const Icon(Icons.calendar_today),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please select a date';
            }
            return null;
          },
        ),
      ),
    );
  }

  Widget _buildInvoiceDateField() {
    return GestureDetector(
      onTap: () => _selectDateInvoice(context), // Open the date picker
      child: AbsorbPointer(
        child: TextFormField(
          style: TextStyle(color: Colors.black),
          controller: _invoiceDateController,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            labelText: 'Invoice Date',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6.0), // Border radius of 6
              borderSide: const BorderSide(
                color: Colors.grey, // Grey border color
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6.0), // Border radius of 6
              borderSide: const BorderSide(
                color: Color.fromARGB(
                    255, 206, 200, 200), // Grey border color for enabled state
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6.0), // Border radius of 6
              borderSide: const BorderSide(
                color: Color.fromARGB(
                    255, 229, 226, 226), // Grey border color for focused state
              ),
            ),
            suffixIcon: const Icon(Icons.calendar_today),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please select a date';
            }
            return null;
          },
        ),
      ),
    );
  }

  Widget _buildHeaderSection() {
    return Row(
      children: [
        // Obx(() {
        Expanded(
          child: _buildReadOnlyField('GRN No', _grnNoController),
        ),
        // }),
        const SizedBox(width: 10),
        Expanded(
          child: _buildGRNDateField(),
        ),
      ],
    );
  }

  Widget _buildVendorDetailsSection() {
    return Obx(() {
      return Row(
        children: [
          Expanded(
            child: DropdownButtonFormField<VendorModel>(
              decoration: InputDecoration(
                labelText: 'Vendor Name',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.white),
                ),
              ),
              dropdownColor: Colors.white,
              style: const TextStyle(color: Colors.black),
              items: _vendorController.getVendorList.map((vendor) {
                return DropdownMenuItem<VendorModel>(
                  value: vendor,
                  child: Text(vendor.vendorName ?? '',
                      style: const TextStyle(color: Colors.black)),
                );
              }).toList(),
              onChanged: (value) {
                _grnbasketcont.resetBasket();
                selectedVendor.value = value;
                _getPoLogByVendoridController.getPoLog(
                    selectedVendor.value!.vendorID!.toInt(), 'goods');
              },
              validator: (value) {
                if (value == null) {
                  return 'Please select a vendor';
                }
                return null;
              },
            ),
          ),
          IconButton(
            icon: const Icon(Icons.info_outline, color: Colors.blueGrey),
            onPressed: _showVendorDetailsDialog,
          ),
        ],
      );
    });
  }

  void _showVendorDetailsDialog() {
    if (selectedVendor.value != null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Color.fromARGB(255, 213, 222, 222),
            title: const Text(
              'Vendor Details',
              style: TextStyle(color: Colors.black),
            ),
            content: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDialogTextField(
                      'Vendor Name', selectedVendor.value?.vendorName),
                  _buildDialogTextField(
                      'Email ID', selectedVendor.value?.emailID),
                  _buildDialogTextField(
                      'Mobile Phone', selectedVendor.value?.mobilePhone),
                  _buildDialogTextField(
                      'GST Number', selectedVendor.value?.gstNumber),
                  _buildDialogTextField(
                      'Address Line 1', selectedVendor.value?.billToAddressL1),
                  _buildDialogTextField(
                      'Address Line 2', selectedVendor.value?.billToAddressL2),
                  _buildDialogTextField(
                      'Address Line 3', selectedVendor.value?.billToAddressL3),
                  _buildDialogTextField(
                      'State Name', selectedVendor.value?.billToState),
                  _buildDialogTextField(
                      'Code', selectedVendor.value?.billToZipCode),
                  _buildDialogTextField(
                      'GSTIN/UIN Code', selectedVendor.value?.gstNumber),
                  _buildDialogTextField('MSME', selectedVendor.value?.msme),
                  _buildDialogTextField(
                      'Tel (O)', selectedVendor.value?.telephone),
                  _buildDialogTextField(
                      'Tel (M)', selectedVendor.value?.mobilePhone),
                ],
              ),
            ),
            actions: [
              TextButton(
                child: const Text('Close'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  Widget _buildInvoiceNumberField() {
    return _buildTextField('Invoice Number', _invoiceNumberController);
  }

  // Widget _buildInvoiceDateField() {
  //   return _buildTextField('Invoice date', null);
  // }

  Widget _buildChallannumber() {
    return _buildTextField(
        'HAWB/MAWB/Bill of Lading/Challan No', _challanNumberController);
  }

  Widget _buildRemark() {
    return _buildTextField('remark', _remarkController);
  }

  Widget _buildButtonsTabBarSection() {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          ButtonsTabBar(
            backgroundColor: Colors.blue,
            unselectedBackgroundColor: Colors.grey[300],
            unselectedLabelStyle: const TextStyle(color: Colors.black),
            labelStyle: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold),
            tabs: const [
              Tab(text: 'Purchase Order list'),
              Tab(text: 'Attachments'),
            ],
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 700, // Adjust height as needed
            child: TabBarView(
              children: [
                _buildPOListSection(),
                _buildAttachmentsTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPOListSection() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Purchase Order List',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          ),
          const SizedBox(height: 10),
          Obx(() {
            // Make sure getApprovedPoList is an observable list
            final dataToShow = _getPoLogByVendoridController.poLog.toList();

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
                        label: Text('SR NO.',
                            style: TextStyle(color: Colors.black))),
                    DataColumn(
                        label: Text('POTxnID',
                            style: TextStyle(color: Colors.black))),
                    DataColumn(
                        label: Text('PO Code',
                            style: TextStyle(color: Colors.black))),
                    DataColumn(
                        label: Text('PO Date',
                            style: TextStyle(color: Colors.black))),
                    DataColumn(
                        label: Text('Info',
                            style: TextStyle(color: Colors.black))),
                  ],
                  rows: List.generate(dataToShow.length, (index) {
                    final poData = dataToShow[index];
                    return DataRow(
                      cells: [
                        DataCell(Text((index + 1).toString(),
                            style: const TextStyle(color: Colors.black))),
                        DataCell(Text(poData.poTxnID.toString() ?? '',
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

                              if (poData.poTxnID != null) {
                                _getPoItemsController
                                    .getPoItems(poData.poTxnID!.toInt());
                                Get.defaultDialog(
                                  title: 'Item List',
                                  content: ItemListDialog(),
                                );
                              } else {
                                Get.snackbar(
                                    'Error', 'PO Transaction ID is missing',
                                    snackPosition: SnackPosition.BOTTOM);
                              }
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
      ),
    );
  }

  // Helper function to create a TextFormField
  Widget _buildTextField(String label, TextEditingController? controller,
      {String hintText = '', bool isDateField = false, bool readOnly = false}) {
    return TextFormField(
      controller: controller,
      readOnly: readOnly || isDateField,
      decoration: InputDecoration(
        labelText: label,
        hintText: hintText,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade400),
        ),
        suffixIcon: isDateField
            ? const Icon(Icons.calendar_today)
            : null, // Calendar icon for date fields
      ),
      style: const TextStyle(color: Colors.black),
      onTap: isDateField && !readOnly
          ? () async {
              DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
              );
              if (pickedDate != null) {
                // Format the date and set it to the controller
                String formattedDate =
                    '${pickedDate.day}/${pickedDate.month}/${pickedDate.year}';
                controller?.text =
                    formattedDate; // Set the selected date to the TextField
              }
            }
          : null,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return '$label is required';
        }
        return null;
      },
    );
  }

  Widget _buildAttachmentsTab() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ElevatedButton(
            onPressed: _chooseFiles,
            child: const Text('Choose Files'),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8.0,
            runSpacing: 4.0,
            children: List<Widget>.generate(_selectedFiles.length, (int index) {
              return Chip(
                label: Text(_selectedFiles[index].name),
                deleteIcon: const Icon(Icons.close),
                onDeleted: () => _removeFile(index),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildReadOnlyField(String label, TextEditingController controller) {
    return TextFormField(
      controller: controller,
      readOnly: true,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade400),
        ),
      ),
      style: const TextStyle(color: Colors.black),
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
          labelStyle: TextStyle(color: Colors.black),
          filled: true,
          fillColor: Colors.grey[100],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.grey),
          ),
        ),
        style: const TextStyle(color: Colors.black),
      ),
    );
  }
}
