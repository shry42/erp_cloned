import 'package:erp_copy/controllers/app_controller.dart';
import 'package:erp_copy/controllers/payment_terms_controller/get_payment_terms_controller.dart';
import 'package:erp_copy/controllers/po_controllers/fetch_exchange_rates_controller.dart';
import 'package:erp_copy/controllers/po_controllers/get_item_details_by_prtxnid_controller.dart';
import 'package:erp_copy/controllers/po_controllers/get_item_details_from_item_id_controller.dart';
import 'package:erp_copy/controllers/po_controllers/get_po_distinct_status_data_controller.dart';
import 'package:erp_copy/controllers/po_controllers/tax_list_controller.dart';
import 'package:erp_copy/controllers/po_controllers/view_po_basket_controller.dart';
import 'package:erp_copy/controllers/vendor_master_controller/vendor_master_list_controller.dart';
import 'package:erp_copy/controllers/delivery_terms_controller/get_delivery_terms_controller.dart'; // Import delivery terms controller
import 'package:erp_copy/model/payment_terms/payment_terms_model.dart';
import 'package:erp_copy/model/vendor_master/vendor_master_model.dart';
import 'package:erp_copy/model/delivery_terms/delivery_terms_model.dart'; // Import delivery terms model
import 'package:erp_copy/models/po_models/get_item_details_by_pr_txnid_model.dart';
import 'package:erp_copy/models/po_models/get_item_details_from_txn_id_model.dart';
import 'package:erp_copy/models/po_models/tax_list_model.dart';
import 'package:erp_copy/screens/po_screens/view_po_basket_screen.dart';
import 'package:erp_copy/widget/menu_widget/drawer_menu_widget.dart';
import 'package:erp_copy/models/po_models/po_basket_item_model.dart'; // Import the PO basket item model
import 'package:file_picker/file_picker.dart'; // Import File Picker
import 'package:flutter/material.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CreatePOScreen extends StatefulWidget {
  const CreatePOScreen({Key? key, required this.openDrawer}) : super(key: key);
  final VoidCallback openDrawer;

  @override
  _CreatePOScreenState createState() => _CreatePOScreenState();
}

class _CreatePOScreenState extends State<CreatePOScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _searchController = TextEditingController();
  final GetPODistinctStatusDataController _controller =
      Get.put(GetPODistinctStatusDataController());
  final GetVendorMastercontroller _vendorController =
      Get.put(GetVendorMastercontroller());
  final GetDeliveryTermsController _deliveryTermsController =
      Get.put(GetDeliveryTermsController()); // Add delivery terms controller
  final GetPaymentTermsController _paymentTermsController =
      Get.put(GetPaymentTermsController()); // Add payment terms controller

  final GetItemDetailsByPrtxnidController _itemDetailsController = Get.put(
      GetItemDetailsByPrtxnidController()); // Add item details controller

  final GetItemDetailsFromItemIdController _getItemDetailsFromItemIdController =
      Get.put(GetItemDetailsFromItemIdController());

  final FetchExchangeRatesController _exchangeRatesController =
      Get.put(FetchExchangeRatesController()); // Add exchange rates controller

  final POBasketController _poBasketController =
      Get.put(POBasketController()); // Add PO basket controller

  final TaxListController _taxListController = Get.put(TaxListController());
  final Rx<TaxListModel?> selectedTax =
      Rx<TaxListModel?>(null); // To hold the selected value

  String? _selectedTax;
  double _taxRate = 0;

  dynamic _selectedItemId;

  var selectedVendor = Rx<VendorModel?>(null); // Reactive vendor variable
  var selectedDeliveryTerm =
      Rx<DeliveryTermsModel?>(null); // Reactive delivery term
  var selectedPaymentTerm =
      Rx<PaymentTermsModel?>(null); // Reactive payment term
  var selectedPRTxnID = RxInt(-1); // Reactive PR Transaction ID
  var selectedItems =
      <GetItemDetailsByPRTxnIDModel>[].obs; // Reactive list for selected items
  var selectedItem =
      Rx<GetItemDetailsByPRTxnIDModel?>(null); // Reactive selected item

  String? currentDate;

  List<PlatformFile> _selectedFiles = []; // List for selected files

  // Controllers for populating fields automatically
  final TextEditingController _itemGroupController = TextEditingController();
  final TextEditingController _venusIDController = TextEditingController();
  final TextEditingController _uomController = TextEditingController();
  final TextEditingController _remainingQuantityController =
      TextEditingController();
  final TextEditingController _unitPriceController = TextEditingController();
  final TextEditingController _hsnController = TextEditingController();
  final TextEditingController _deliveryDateController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();

  final TextEditingController _itemIdController = TextEditingController();
  final TextEditingController _quotationDateController =
      TextEditingController();
  final TextEditingController _headerNotecController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _finalAmountController = TextEditingController();

  @override
  void initState() {
    super.initState();
    currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    _controller
        .getPODistinctStatus(); // Fetch the data on screen initialization
    loadData();

    // Fetch the exchange rates when the screen is initialized
    _exchangeRatesController.fetchExchangeRates();

    // Listen to changes in the search input to dynamically filter data
    _searchController.addListener(() {
      _filterData(_searchController.text);
    });
  }

  loadData() async {
    await _vendorController.getVednorMaster(); // Fetch the vendor data
    _deliveryTermsController
        .getDeliveryTerms(); // Fetch the delivery terms data
    await _paymentTermsController
        .getPaymentTerms(); // Fetch the payment terms data
  }

  void _filterData(String query) {
    if (query.isEmpty) {
      // Reset to show the first four items from the initial list
      _controller.poDistinctDataList.value =
          _controller.initialPoDistinctDataList.take(4).toList();
    } else {
      // Filter based on the query
      _controller.poDistinctDataList.value = _controller
          .initialPoDistinctDataList
          .where((element) => element.prTxnID.toString().contains(query))
          .toList();
    }
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
        title: const Text('Create PO'),
        backgroundColor: const Color.fromARGB(255, 29, 169, 32),
        actions: [
          ElevatedButton(
            onPressed: () {
              // Gather all required data
              String poDate = currentDate ?? '';
              String prTxnID = selectedPRTxnID.value.toString();
              String vendorId =
                  selectedVendor.value?.vendorID?.toString() ?? '';
              String supplierQuoteNo = '';
              String quoteDate =
                  ''; // This needs to be added to the form if required
              String revNo = '0'; // From the Rev. No. field
              String buyerName =
                  AppController.Username; // This needs to be added to the form
              String buyerEmailID =
                  AppController.EmailID; // This needs to be added to the form
              String buyerTel = AppController
                  .MobileNumber; // This needs to be added to the form
              String buyerMob = AppController
                  .MobileNumber; // This needs to be added to the form
              String supplierPOCName = _nameController.text ?? '';
              String supplierPOCEmailID = selectedVendor.value?.emailID ?? '';
              String supplierPOCTel = selectedVendor.value?.telephone ?? '';
              String supplierPOCMob = selectedVendor.value?.mobilePhone ?? '';
              String deliveryTerms = selectedDeliveryTerm.value?.terms ?? '';
              String paymentTerms = selectedPaymentTerm.value?.terms ?? '';
              String headerNote = _headerNotecController
                  .text; // This needs to be added to the form
              String approvalStatus =
                  '0'; // This needs to be determined based on your logic
              String revisionNumber = '0'; // Same as revNo
              PlatformFile? filePath =
                  _selectedFiles.isNotEmpty ? _selectedFiles.first : null;

              Get.to(() => ViewPOBasketScreen(
                    PODate: poDate,
                    pRTxnID: prTxnID,
                    vendorId: vendorId,
                    supplierQuoteNo: supplierQuoteNo,
                    quoteDate: _quotationDateController.text,
                    rev_NO: revNo,
                    buyerName: buyerName,
                    buyerEmailID: buyerEmailID,
                    buyerTel: buyerTel,
                    buyerMob: buyerMob,
                    supplierPOCName: supplierPOCName,
                    supplierPOCEmailID: supplierPOCEmailID,
                    supplierPOCTel: supplierPOCTel,
                    supplierPOCMob: supplierPOCMob,
                    deliveryTerms: deliveryTerms,
                    paymentTerms: paymentTerms,
                    headerNote: headerNote,
                    approvalStatus: approvalStatus,
                    revisionNumber: revisionNumber,
                    filePath: filePath,
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
              _buildDropdownSection(), // Delivery Terms and Payment Terms
              const SizedBox(height: 20),
              _buildNameField(), // Name Field
              const SizedBox(height: 20),
              _buildHeaderNoteField(),
              const SizedBox(height: 20),
              _buildPRListSection(), // PR List Table
              const SizedBox(height: 20),
              _buildButtonsTabBarSection(), // Tabs Section
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderSection() {
    return Row(
      children: [
        Expanded(
          child: _buildReadOnlyField('Rev. No.', '0'),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _buildReadOnlyField('Po Date', '$currentDate'),
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
                selectedVendor.value = value;
                _taxListController
                    .getTaxList(selectedVendor.value!.vendorID as int);
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
            backgroundColor: Colors.white,
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
                child: const Text(
                  'Close',
                  style: TextStyle(color: Colors.black),
                ),
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

  Widget _buildDropdownSection() {
    return Column(
      children: [
        Obx(() {
          return Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context)
                  .size
                  .width, // Use full width of the screen
            ),
            child: DropdownButtonFormField<DeliveryTermsModel>(
              isExpanded:
                  true, // Ensures dropdown button expands within its container
              decoration: InputDecoration(
                labelText: 'Delivery Terms',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey.shade400),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 16,
                ),
              ),
              value: selectedDeliveryTerm.value,
              dropdownColor: Colors.white,
              style: const TextStyle(color: Colors.black),
              items: _deliveryTermsController.deliveryTermsList.map((term) {
                return DropdownMenuItem<DeliveryTermsModel>(
                  value: term,
                  child: Container(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.8,
                    ),
                    child: Text(
                      term.terms ?? '',
                      style: const TextStyle(color: Colors.black),
                      overflow:
                          TextOverflow.ellipsis, // Add ellipsis for long text
                      maxLines: 1, // Ensure single line
                    ),
                  ),
                );
              }).toList(),
              onChanged: (value) {
                selectedDeliveryTerm.value = value;
              },
              validator: (value) {
                if (value == null) {
                  return 'Please select a delivery term';
                }
                return null;
              },
            ),
          );
        }),
        const SizedBox(height: 10),
        Obx(() {
          return Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width,
            ),
            child: DropdownButtonFormField<PaymentTermsModel>(
              isExpanded: true,
              decoration: InputDecoration(
                labelText: 'Payment Terms',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey.shade400),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 16,
                ),
              ),
              value: selectedPaymentTerm.value,
              dropdownColor: Colors.white,
              style: const TextStyle(color: Colors.black),
              items: _paymentTermsController.paymentTermsList.map((term) {
                return DropdownMenuItem<PaymentTermsModel>(
                  value: term,
                  child: Container(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.8,
                    ),
                    child: Text(
                      term.terms ?? '',
                      style: const TextStyle(color: Colors.black),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                );
              }).toList(),
              onChanged: (value) {
                selectedPaymentTerm.value = value;
              },
              validator: (value) {
                if (value == null) {
                  return 'Please select a payment term';
                }
                return null;
              },
            ),
          );
        }),
      ],
    );
  }

  Widget _buildHeaderNoteField() {
    return _buildTextField('Header Note', _headerNotecController);
  }

  Widget _buildNameField() {
    return _buildTextField('Name', _nameController);
  }

  Widget _buildPRListSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'PR List',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _searchController,
          style: const TextStyle(color: Colors.black),
          decoration: InputDecoration(
            labelText: 'Search by PR Txn ID',
            prefixIcon: const Icon(Icons.search, color: Colors.grey),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey.shade400),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Obx(() {
          final dataToShow = _controller.poDistinctDataList.take(4).toList();
          return Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade400),
              borderRadius: BorderRadius.circular(8),
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
                      label: Text('Select',
                          style: TextStyle(color: Colors.black))),
                  DataColumn(
                      label: Text('PR Txn ID',
                          style: TextStyle(color: Colors.black))),
                  DataColumn(
                      label: Text('Txn Date',
                          style: TextStyle(color: Colors.black))),
                  DataColumn(
                      label: Text('Request Date',
                          style: TextStyle(color: Colors.black))),
                  DataColumn(
                      label: Text('Project Code',
                          style: TextStyle(color: Colors.black))),
                  DataColumn(
                      label: Text('Approval Status',
                          style: TextStyle(color: Colors.black))),
                  DataColumn(
                      label: Text('PR Status',
                          style: TextStyle(color: Colors.black))),
                  DataColumn(
                      label:
                          Text('Info', style: TextStyle(color: Colors.black))),
                ],
                rows: dataToShow.map((prData) {
                  return DataRow(
                    cells: [
                      DataCell(Text(prData.prTxnID.toString(),
                          style: const TextStyle(color: Colors.black))),
                      DataCell(Checkbox(
                        value: selectedPRTxnID.value == prData.prTxnID,
                        onChanged: (value) {
                          if (value == true) {
                            selectedPRTxnID.value = prData.prTxnID!;
                            _itemDetailsController
                                .getItemList(prData.prTxnID!.toInt())
                                .then((items) {
                              selectedItems.value = items;
                              selectedItem.value = null; // Reset selected item
                              if (items.isNotEmpty) {
                                // Fetch detailed item info for the first item

                                _getItemDetailsFromItemIdController
                                    .getItemDetails(items.first.itemID!);
                                setState(() {
                                  _selectedItemId = items.first.itemID;
                                });
                                print(_selectedItemId);
                              }
                            });
                          } else {
                            selectedPRTxnID.value = -1;
                            selectedItems.clear();
                            selectedItem.value = null; // Reset selected item
                          }
                        },
                      )),
                      DataCell(Text(prData.prTxnID.toString(),
                          style: const TextStyle(color: Colors.black))),
                      DataCell(Text(
                          prData.txnDate != null
                              ? '${prData.txnDate!.month}/${prData.txnDate!.day}/${prData.txnDate!.year}'
                              : '',
                          style: const TextStyle(color: Colors.black))),
                      DataCell(Text(
                          prData.reqDate != null
                              ? '${prData.reqDate!.month}/${prData.reqDate!.day}/${prData.reqDate!.year}'
                              : '',
                          style: const TextStyle(color: Colors.black))),
                      DataCell(Text(prData.projectCode ?? '',
                          style: const TextStyle(color: Colors.black))),
                      DataCell(Text(prData.approvalStatus.toString(),
                          style: const TextStyle(color: Colors.black))),
                      DataCell(Text(prData.prStatus ?? '',
                          style: const TextStyle(color: Colors.black))),
                      DataCell(
                        IconButton(
                          icon: const Icon(Icons.info_outline,
                              color: Colors.blueGrey),
                          onPressed: () {},
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
          );
        }),
      ],
    );
  }

  Widget _buildButtonsTabBarSection() {
    return DefaultTabController(
      length: 4,
      child: Column(
        children: [
          ButtonsTabBar(
            backgroundColor: Colors.blue,
            unselectedBackgroundColor: Colors.grey[300],
            unselectedLabelStyle: const TextStyle(color: Colors.black),
            labelStyle: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold),
            tabs: const [
              Tab(text: 'Item Addition'),
              Tab(text: 'Attachments'),
              Tab(text: 'Currency Conversion'),
              Tab(text: 'Details'),
            ],
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 700, // Adjust height as needed
            child: TabBarView(
              children: [
                _buildItemAdditionTab(),
                _buildAttachmentsTab(),
                _buildCurrencyConversionTab(),
                _buildDetailsTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItemAdditionTab() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Item Addition',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Obx(() {
              // Fetch the updated item details from the controller
              GetItemDetailsFromItemIdModel itemDetails =
                  _getItemDetailsFromItemIdController.itemDetails.value;
              // Define the default item separately to avoid duplication
              GetItemDetailsByPRTxnIDModel defaultItem =
                  GetItemDetailsByPRTxnIDModel(
                itemName: 'Freight Cost/ Other Expenses',
                itemGroup: '',
                sapID: '',
                purchaseUOM: '',
                remainingQty: 0,
              );

              // Combine the default item with the fetched items
              List<GetItemDetailsByPRTxnIDModel> dropdownItems = [
                defaultItem,
                ...selectedItems
                    .where((item) => item.itemName != defaultItem.itemName)
              ];

              // Ensure selectedItem is in dropdownItems
              if (!dropdownItems.contains(selectedItem.value)) {
                selectedItem.value =
                    defaultItem; // Set to default if current is not in list
              }

              return DropdownButtonFormField<GetItemDetailsByPRTxnIDModel>(
                isExpanded: true,
                decoration: InputDecoration(
                  labelText: 'PR Items',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.grey.shade400),
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                ),
                value:
                    selectedItem.value, // Set default value if no item selected
                style: const TextStyle(color: Colors.black),
                dropdownColor: Colors.white,
                items: dropdownItems.map((item) {
                  return DropdownMenuItem<GetItemDetailsByPRTxnIDModel>(
                    value: item,
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: Text(
                        item.itemName ?? '',
                        style: const TextStyle(color: Colors.black),
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  selectedItem.value = value;
                  if (value?.itemName == 'Freight Cost/ Other Expenses') {
                    // Set predefined values for specific fields
                    _itemGroupController.text = 'Other Expenses';
                    _venusIDController.text = '1111111111';
                    _remainingQuantityController.text = '1';
                    _uomController.text = '-';
                    _hsnController.text = itemDetails.hsnCode ?? '';
                    _itemIdController.text =
                        itemDetails.itemID?.toString() ?? '';
                    // setState(() {
                    //   _selectedItemId = itemDetails.itemID?.toString() ?? '';
                    // });
                    // print('**************${_itemIdController.text}');
                  } else {
                    // Populate the text fields when other PR items are selected
                    _itemGroupController.text = value?.itemGroup ?? '';
                    _venusIDController.text = value?.sapID ?? '';
                    _uomController.text = value?.purchaseUOM ?? '';
                    _remainingQuantityController.text =
                        value?.remainingQty.toString() ?? '';
                    _hsnController.text = itemDetails.hsnCode ?? '';
                    _itemIdController.text =
                        itemDetails.itemID?.toString() ?? '';
                    // setState(() {
                    //   _selectedItemId = itemDetails.itemID?.toString() ?? '';
                    // });
                  }
                },
                validator: (value) {
                  if (value == null) {
                    return 'Please select a PR item';
                  }
                  return null;
                },
              );
            }),
            const SizedBox(height: 10),
            _buildTextField('Item Group', _itemGroupController, readOnly: true),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: _buildTextField('Venus-ID', _venusIDController,
                      readOnly: true),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _buildTextField('Unit Price', _unitPriceController,
                      hintText: 'Please enter Unit Price'),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: _buildTextField(
                      'Delivery Date', _deliveryDateController,
                      hintText: '26/08/2024', isDateField: true),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _buildTextField(
                      'Remaining Quantity', _remainingQuantityController,
                      readOnly: true),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: _buildTextField('HSN', _hsnController,
                      hintText: 'Please enter HSN'),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _buildTextField('UOM', _uomController, readOnly: true),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: _buildTextField('Quantity', _quantityController,
                      hintText: 'Quantity'),
                ),
                const SizedBox(width: 10),
              ],
            ),
            const SizedBox(height: 20),
            const SizedBox(height: 10),

            // Tax List Dropdown Field
            Obx(() {
              // Reset the selected value if the list is updated
              if (_taxListController.taxList.isEmpty ||
                  !_taxListController.taxList.contains(selectedTax.value)) {
                selectedTax.value = null; // Clear the selected value
              }
              return DropdownButtonFormField<TaxListModel>(
                isExpanded: true,
                decoration: InputDecoration(
                  labelText: 'Tax List',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.grey.shade400),
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                ),
                value: selectedTax.value,
                style: TextStyle(
                  color: _taxListController.taxList.isEmpty
                      ? Colors.grey
                      : Colors.black,
                ),
                dropdownColor: Colors.white,
                hint: Text(
                  _taxListController.taxList.isEmpty
                      ? 'No taxes available'
                      : 'Select a tax',
                  style: TextStyle(
                    color: _taxListController.taxList.isEmpty
                        ? Colors.grey
                        : Colors.black,
                  ),
                ),
                items: _taxListController.taxList.map((tax) {
                  return DropdownMenuItem<TaxListModel>(
                    value: tax,
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: Text(
                        tax.taxName ?? '',
                        style: const TextStyle(color: Colors.black),
                      ),
                    ),
                  );
                }).toList(),
                onChanged: _taxListController.taxList.isNotEmpty
                    ? (value) {
                        selectedTax.value = value; // Update selected tax
                        setState(() {
                          _selectedTax = value?.taxName;
                          _taxRate = value?.taxRate ?? 0;
                        });
                      }
                    : null, // Disable if there are no tax items
                validator: (value) {
                  if (value == null && _taxListController.taxList.isNotEmpty) {
                    return 'Please select a tax';
                  }
                  return null;
                },
              );
            }),

            const SizedBox(height: 20),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: _addToPO,
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                  textStyle: const TextStyle(fontSize: 16),
                ),
                child: const Text('Add To Po'),
              ),
            ),
          ],
        ),
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
                    '${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')} 00:00:00:000';

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

  void _addToPO() {
    if (_formKey.currentState?.validate() ?? false) {
      // Validation passed, proceed to add item to PO basket
      // Validation passed, proceed to add item to PO basket

      // Parse the quantity and unit price from text controllers
      double quantity = double.tryParse(_quantityController.text) ?? 0;
      double unitPrice = double.tryParse(_unitPriceController.text) ?? 0;

      // Calculate line total
      double lineTotal = quantity * unitPrice;

      // Calculate tax amount
      double taxAmount = (lineTotal * _taxRate) / 100;

      // Calculate final amount
      double finalAmount = lineTotal + taxAmount;

      POBasketItem newItem = POBasketItem(
        itemName: selectedItem.value?.itemName ?? '',
        itemGroup: _itemGroupController.text,
        venusId: _venusIDController.text,
        uom: _uomController.text,
        unitPrice: _unitPriceController.text,
        deliveryDate: _deliveryDateController.text,
        poQuantity: _quantityController.text,
        srNo: '1',
        itemId: _selectedItemId.toString(),
        hsnCode: _hsnController.text,
        taxCode: _selectedTax.toString(),
        taxRate: _taxRate.toString(),
        lineTotal: lineTotal.toStringAsFixed(2),
        taxAmount: taxAmount.toStringAsFixed(2),
        finalAmount: finalAmount.toStringAsFixed(2),
      );

      _poBasketController.addItemToBasket(newItem);

      // Clear the fields after adding the item
      _itemGroupController.clear();
      _venusIDController.clear();
      _uomController.clear();
      _remainingQuantityController.clear();
      _unitPriceController.clear();
      _hsnController.clear();
      _deliveryDateController.clear();
      _quantityController.clear();

      Get.snackbar('Success', 'Item added to PO successfully!',
          snackPosition: SnackPosition.BOTTOM);
    }
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

  Widget _buildCurrencyConversionTab() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Currency Conversion',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Obx(() => _buildTextField(
                  'USD-INR',
                  TextEditingController(
                      text: _exchangeRatesController.usdInr.value.toString()),
                  readOnly: true,
                )),
            const SizedBox(height: 10),
            Obx(() => _buildTextField(
                  'EUR-INR',
                  TextEditingController(
                      text: _exchangeRatesController.eurInr.value.toString()),
                  readOnly: true,
                )),
            const SizedBox(height: 10),
            Obx(() => _buildTextField(
                  'CNY-INR',
                  TextEditingController(
                      text: _exchangeRatesController.cnyInr.value.toString()),
                  readOnly: true,
                )),
            const SizedBox(height: 10),
            Obx(() => _buildTextField(
                  'JPY-INR',
                  TextEditingController(
                      text: _exchangeRatesController.jpyInr.value.toString()),
                  readOnly: true,
                )),
            const SizedBox(height: 10),
            Obx(() => _buildTextField(
                  'Last Update',
                  TextEditingController(
                      text: _exchangeRatesController.fetchedOn.value),
                  readOnly: true,
                )),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailsTab() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Details',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            _buildTextField('Quotation Date', _quotationDateController,
                hintText: '26/08/2024', isDateField: true),
            const SizedBox(height: 10),
            _buildTextField(
              'Email ID',
              TextEditingController(text: AppController.EmailID),
              readOnly: true,
            ),
            const SizedBox(height: 10),
            const SizedBox(height: 10),
            Obx(() => _buildTextField(
                  'Basic Total',
                  TextEditingController(
                      text: _exchangeRatesController.jpyInr.value.toString()),
                  readOnly: true,
                )),
            const SizedBox(height: 10),
            Obx(() => _buildTextField(
                  'Tax',
                  TextEditingController(
                      text: _exchangeRatesController.fetchedOn.value),
                  readOnly: true,
                )),
            Obx(() => _buildTextField(
                  'Grand Total',
                  TextEditingController(
                      text: _exchangeRatesController.fetchedOn.value),
                  readOnly: true,
                )),
          ],
        ),
      ),
    );
  }

  Widget _buildReadOnlyField(String label, String value) {
    return TextFormField(
      initialValue: value,
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
          labelStyle: const TextStyle(color: Colors.black),
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
