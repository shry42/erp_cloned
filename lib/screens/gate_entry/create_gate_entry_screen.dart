import 'dart:async';
import 'package:erp_copy/controllers/gate_entry/get_entry_by_user_controller.dart';
import 'package:erp_copy/controllers/gate_entry/get_po_generated_data_controller.dart';
import 'package:erp_copy/controllers/gate_entry/get_receiving_by_user_controller.dart';
import 'package:erp_copy/controllers/gate_entry/get_entry_number_controller.dart';
import 'package:erp_copy/controllers/gate_entry/insert_gate_entry_controller.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:erp_copy/widget/menu_widget/drawer_menu_widget.dart';

class CreateGateEntryScreen extends StatefulWidget {
  const CreateGateEntryScreen({
    super.key,
    required this.openDrawer,
  });
  final VoidCallback openDrawer;

  @override
  State<CreateGateEntryScreen> createState() => _CreateGateEntryScreenState();
}

class _CreateGateEntryScreenState extends State<CreateGateEntryScreen> {
  final _formKey = GlobalKey<FormState>();
  final GetEntryByUserController _getEntryByUserController =
      Get.put(GetEntryByUserController());
  final GetReceivingByUserController _getReceivingByUserController =
      Get.put(GetReceivingByUserController());
  final GetEntryNumberController _getEntryNumberController =
      Get.put(GetEntryNumberController());

  final GetPoGeneratedDataController _getPoGeneratedDataController =
      Get.put(GetPoGeneratedDataController());

  final TextEditingController _gateEntryNumberController =
      TextEditingController();

  final TextEditingController _quantityController = TextEditingController();

  final TextEditingController _challanNoController = TextEditingController();

  final TextEditingController _remarksController = TextEditingController();

  String? _entryBy;
  String? _receivedBy;
  String? _isPOItem = 'Yes';
  String? _selectedPO;

  @override
  void initState() {
    super.initState();
    _getEntryByUserController.fetchEntryByUsers();
    _getReceivingByUserController.getReceivingUser();
    _getEntryNumberController.fetchEntryNumber();
    _getPoGeneratedDataController.getPOGeneratedData();

    // Listen to changes in gateEntryNumber and update the controller
    _getEntryNumberController.gateEntryNumber.listen((entryNumber) {
      _gateEntryNumberController.text = entryNumber ?? '';
    });
  }

  @override
  void dispose() {
    _gateEntryNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.sizeOf(context).height * 0.18;
    double _width = MediaQuery.sizeOf(context).width * 0.90;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 68, 168, 71),
        automaticallyImplyLeading: true,
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text(
                'Create Gate Entry',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 80),
              DrawerMenuWidget(
                onClicked: widget.openDrawer,
              ),
              const SizedBox(width: 20),
            ],
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: _buildTextField(
                      label: 'Gate Entry No.',
                      controller: _gateEntryNumberController,
                      readOnly: true,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildTextField(
                      label: 'Gate Entry Date',
                      initialValue:
                          DateFormat('dd/MM/yyyy').format(DateTime.now()),
                      readOnly: true,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: Obx(() {
                      if (_getEntryByUserController.isLoading.value) {
                        return const CircularProgressIndicator();
                      } else if (_getEntryByUserController
                          .entryByUsers.isNotEmpty) {
                        return _buildDropdown(
                          label: 'Entry By',
                          value: _entryBy,
                          items: _getEntryByUserController.entryByUsers
                              .map((user) => user.fullName)
                              .toList(),
                          onChanged: (value) =>
                              setState(() => _entryBy = value),
                        );
                      } else {
                        return const Text('No data available');
                      }
                    }),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Obx(() {
                      if (_getReceivingByUserController.isLoading.value) {
                        return const CircularProgressIndicator();
                      } else if (_getReceivingByUserController
                          .approvedPoList.isNotEmpty) {
                        return _buildDropdown(
                          label: 'Received By',
                          value: _receivedBy,
                          items: _getReceivingByUserController.approvedPoList
                              .map((po) => po.fullName)
                              .toList(),
                          onChanged: (value) =>
                              setState(() => _receivedBy = value),
                        );
                      } else {
                        return const Text('No data available');
                      }
                    }),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: _buildDropdown(
                      label: 'Is it a PO Item?',
                      value: _isPOItem,
                      items: [
                        'Yes',
                        'No',
                      ],
                      onChanged: (value) => setState(() => _isPOItem = value),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Obx(() {
                      if (_getPoGeneratedDataController.isLoading.value) {
                        return const CircularProgressIndicator();
                      } else if (_getPoGeneratedDataController
                          .getPOData.isNotEmpty) {
                        return _buildDropdown(
                          label: 'Select PO',
                          value: _selectedPO,
                          items: _getPoGeneratedDataController.getPOData
                              .map((po) => po.poCode)
                              .toList(),
                          onChanged: (value) =>
                              setState(() => _selectedPO = value),
                        );
                      } else {
                        return const Text('No data available');
                      }
                    }),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: _buildTextField(
                      controller: _challanNoController,
                      label: 'Challan/Invoice No.',
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildTextField(
                      label: 'Challan/Invoice Date',
                      initialValue:
                          DateFormat('dd/MM/yyyy').format(DateTime.now()),
                      readOnly: true,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildTextField(
                      controller: _quantityController,
                      label: 'Quantity/Packages',
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _remarksController,
                label: 'Remarks',
                maxLines: 3,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    int authorizerUserID = _getEntryByUserController
                        .entryByUsers
                        .firstWhere((user) => user.fullName == _entryBy)
                        .userID;
                    int rcvdByUserID = _getReceivingByUserController
                        .approvedPoList
                        .firstWhere((user) => user.fullName == _receivedBy)
                        .userID;
                    int poID = _getPoGeneratedDataController.getPOData
                        .firstWhere((po) => po.poCode == _selectedPO)
                        .potxnID;
                    String isPOLinked = _isPOItem == 'Yes' ? '1' : '0';
                    String itemCount = _quantityController
                        .text; // Assuming you have a TextEditingController for quantity

                    InsertGateEntryController().insertGateEntry(
                      authorizerUserID: authorizerUserID,
                      authorizerUserName: _entryBy ?? '',
                      challanDate: DateFormat('yyyy-MM-dd')
                          .format(DateTime.now()), // Format the date as needed
                      challanNo: _challanNoController
                          .text, // Assuming you have a TextEditingController for Challan/Invoice No.
                      isPOLinked: isPOLinked,
                      itemCount: itemCount,
                      poCode: _selectedPO ?? '',
                      poID: poID,
                      rcvdByUser: _receivedBy ?? '',
                      rcvdByUserID: rcvdByUserID,
                      rcvdDate: DateFormat('yyyy-MM-dd')
                          .format(DateTime.now()), // Format the date as needed
                      remarks: _remarksController
                          .text, // Assuming you have a TextEditingController for Remarks
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 44, 165, 54),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Center(
                  child: Text(
                    'Submit',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    String? initialValue,
    TextEditingController? controller,
    bool readOnly = false,
    int maxLines = 1,
    TextInputType? keyboardType,
  }) {
    return TextFormField(
      controller: controller,
      initialValue: initialValue,
      readOnly: readOnly,
      maxLines: maxLines,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(fontSize: 16, color: Colors.black87),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        filled: true,
        fillColor: Colors.grey[200],
      ),
      style: TextStyle(fontSize: 16, color: Colors.black26),
    );
  }

  Widget _buildDropdown({
    required String label,
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return DropdownButtonFormField<String>(
      value: value,
      items: items.map((String item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(
            item,
            style: const TextStyle(
                fontSize: 16, color: Colors.black), // Set text color to black
          ),
        );
      }).toList(),
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(fontSize: 16, color: Colors.black87),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        filled: true,
        fillColor: Colors.grey[200],
      ),
      style: const TextStyle(
          fontSize: 16,
          color: Colors.black), // Set dropdown selected text color to black
      dropdownColor: Colors.white, // Set dropdown background color to white
    );
  }
}
