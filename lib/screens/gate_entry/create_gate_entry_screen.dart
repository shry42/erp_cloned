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

  // Validation helpers
  bool _isNumeric(String? str) {
    if (str == null) return false;
    return double.tryParse(str) != null;
  }

  String? _validateRequired(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  String? _validateQuantity(String? value) {
    if (value == null || value.isEmpty) {
      return 'Quantity is required';
    }
    if (!_isNumeric(value)) {
      return 'Please enter a valid number';
    }
    if (double.parse(value) <= 0) {
      return 'Quantity must be greater than 0';
    }
    return null;
  }

  String? _validateChallanNo(String? value) {
    if (value == null || value.isEmpty) {
      return 'Challan/Invoice number is required';
    }
    if (value.length < 3) {
      return 'Challan/Invoice number must be at least 3 characters';
    }
    return null;
  }

  String? _validateDropdown(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return 'Please select $fieldName';
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
    _getEntryByUserController.fetchEntryByUsers();
    _getReceivingByUserController.getReceivingUser();
    _getEntryNumberController.fetchEntryNumber();
    _getPoGeneratedDataController.getPOGeneratedData();

    _getEntryNumberController.gateEntryNumber.listen((entryNumber) {
      _gateEntryNumberController.text = entryNumber ?? '';
    });
  }

  @override
  void dispose() {
    _gateEntryNumberController.dispose();
    _quantityController.dispose();
    _challanNoController.dispose();
    _remarksController.dispose();
    super.dispose();
  }

  void _showErrorSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  void _submitForm() {
    if (!_formKey.currentState!.validate()) {
      _showErrorSnackbar('Please fill all required fields correctly');
      return;
    }

    try {
      final entryByUser = _getEntryByUserController.entryByUsers
          .firstWhere((user) => user.fullName == _entryBy);
      final receivingUser = _getReceivingByUserController.approvedPoList
          .firstWhere((user) => user.fullName == _receivedBy);
      final poData = _getPoGeneratedDataController.getPOData
          .firstWhere((po) => po.poCode == _selectedPO);

      InsertGateEntryController().insertGateEntry(
        authorizerUserID: entryByUser.userID,
        authorizerUserName: _entryBy ?? '',
        challanDate: DateFormat('yyyy-MM-dd').format(DateTime.now()),
        challanNo: _challanNoController.text,
        isPOLinked: _isPOItem == 'Yes' ? '1' : '0',
        itemCount: _quantityController.text,
        poCode: _selectedPO ?? '',
        poID: poData.potxnID,
        rcvdByUser: _receivedBy ?? '',
        rcvdByUserID: receivingUser.userID,
        rcvdDate: DateFormat('yyyy-MM-dd').format(DateTime.now()),
        remarks: _remarksController.text,
      );

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Gate entry submitted successfully'),
          backgroundColor: Colors.green,
        ),
      );

      // Clear form
      _formKey.currentState!.reset();
      _quantityController.clear();
      _challanNoController.clear();
      _remarksController.clear();
      setState(() {
        _entryBy = null;
        _receivedBy = null;
        _isPOItem = 'Yes';
        _selectedPO = null;
      });
    } catch (e) {
      _showErrorSnackbar('Error submitting form: ${e.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
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
              DrawerMenuWidget(onClicked: widget.openDrawer),
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
                          validator: (value) =>
                              _validateDropdown(value, 'Entry By'),
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
                          validator: (value) =>
                              _validateDropdown(value, 'Received By'),
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
                      items: ['Yes', 'No'],
                      onChanged: (value) => setState(() => _isPOItem = value),
                      validator: (value) => _validateDropdown(value, 'PO Item'),
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
                          validator: _isPOItem == 'Yes'
                              ? (value) => _validateDropdown(value, 'PO')
                              : null,
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
                      validator: _validateChallanNo,
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
                      validator: _validateQuantity,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _remarksController,
                label: 'Remarks',
                maxLines: 3,
                validator: (value) => _validateRequired(value, 'Remarks'),
              ),
              const SizedBox(height: 24),
              Center(
                child: ElevatedButton(
                  onPressed: _submitForm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 44, 165, 54),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Submit',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
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
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      initialValue: initialValue,
      readOnly: readOnly,
      maxLines: maxLines,
      keyboardType: keyboardType,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(fontSize: 16, color: Colors.black87),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        filled: true,
        fillColor: Colors.grey[200],
        errorStyle: const TextStyle(color: Colors.red),
      ),
      style: const TextStyle(fontSize: 16, color: Colors.black),
    );
  }

  Widget _buildDropdown({
    required String label,
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
    String? Function(String?)? validator,
  }) {
    return DropdownButtonFormField<String>(
        dropdownColor: Colors.white,
        value: value,
        items: items.map((String item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(
              item,
              style: const TextStyle(fontSize: 16, color: Colors.black),
            ),
          );
        }).toList(),
        onChanged: onChanged,
        validator: validator,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(fontSize: 16, color: Colors.black87),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          filled: true,
          fillColor: Colors.grey[200],
          errorStyle: const TextStyle(color: Colors.red),
        ));
  }
}
