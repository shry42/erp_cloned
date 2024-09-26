import 'package:erp_copy/controllers/item_master_controller/get_item_master_list_controller.dart';
import 'package:erp_copy/controllers/pr_controllers/add_to_basket_controller.dart';
import 'package:erp_copy/controllers/pr_controllers/get_project_code_list_controller.dart';
import 'package:erp_copy/controllers/pr_controllers/get_single_data_controller.dart';
import 'package:erp_copy/model/item_master/item_master_list_model.dart';
import 'package:erp_copy/model/pr_models_new/view_basket_model.dart';
import 'package:erp_copy/screens/pr_screens/view_basket_screen.dart';
import 'package:erp_copy/widget/menu_widget/drawer_menu_widget.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

class CreatePRScreen extends StatefulWidget {
  const CreatePRScreen({
    super.key,
    required this.openDrawer,
  });
  final VoidCallback openDrawer;

  @override
  State<CreatePRScreen> createState() => _CreatePRScreenState();
}

class _CreatePRScreenState extends State<CreatePRScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _remarkController = TextEditingController();
  final TextEditingController _requiredByController = TextEditingController();
  final TextEditingController _uomController = TextEditingController();
  final TextEditingController _prNoController = TextEditingController();

  String? _selectedProjectCode;
  String? _selectedItemCode;
  final String _prDate = DateFormat('dd/MM/yyyy').format(DateTime.now());

  final SingleDataController singleDataController =
      Get.put(SingleDataController());
  final GetProjectCodeListcontroller projectCodeController =
      Get.put(GetProjectCodeListcontroller());
  final GetItemsMastersListcontroller itemsMasterController =
      Get.put(GetItemsMastersListcontroller());

  final BasketController basketController = Get.put(BasketController());

  void _addToBasket() {
    if (_formKey.currentState!.validate()) {
      final item = BasketItem(
        srNo: (basketController.basketItems.length + 1).toString(),
        prNumber: _prNoController.text,
        requiredBy: _requiredByController.text,
        venusId: _selectedProjectCode ?? '',
        internalCode: _selectedItemCode ?? '',
        quantity: _quantityController.text,
        uom: _uomController.text,
        remark: _remarkController.text,
      );
      basketController.addItemToBasket(item);
      Get.snackbar('Success', 'Item added to basket');
      _clearForm();
    }
  }

  void _clearForm() {
    _quantityController.clear();
    _remarkController.clear();
    setState(() {
      _selectedItemCode = null;
      _uomController.clear();
    });
  }

  @override
  void initState() {
    super.initState();
    _loadPRNo(); // Load PR No. from API
    projectCodeController.getProjectcodeList(); // Fetch project codes
    itemsMasterController.getItemDetails(); // Fetch item details
  }

  @override
  void dispose() {
    _quantityController.dispose();
    _remarkController.dispose();
    _requiredByController.dispose();
    _uomController.dispose();
    _prNoController.dispose();
    super.dispose();
  }

  Future<void> _loadPRNo() async {
    await singleDataController.fetchSingleData();
    setState(() {
      _prNoController.text =
          singleDataController.singleData?.data?.toString() ?? 'N/A';
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime(2025),
    );
    if (pickedDate != null) {
      setState(() {
        _requiredByController.text =
            DateFormat('yyyy-MM-dd').format(pickedDate);
      });
    }
  }

  void _updateUOM(String selectedItemCode) {
    // Find the UOM for the selected item code and update the UOM controller
    final selectedItem = itemsMasterController.getItemslist.firstWhere(
      (item) => item.internalCode == selectedItemCode,
      orElse: () => ItemMasterListModel(purchaseUOM: 'N/A'),
    );
    setState(() {
      _uomController.text = selectedItem.purchaseUOM ?? 'N/A';
    });
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: Colors.black),
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.grey),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.grey),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.blue),
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
    );
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
                'Create PR',
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
              const SizedBox(width: 75),
              ElevatedButton(
                onPressed: () {
                  Get.to(() =>
                      ViewBasketScreen()); // Navigate to View Basket Screen
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(8), // Adjust the radius as needed
                    side: const BorderSide(
                        color: Colors.grey), // Light border color
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
              const SizedBox(
                width: 20,
              ),
            ],
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // PR Number & PR Date
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _prNoController,
                      style: const TextStyle(color: Colors.grey),
                      decoration: _inputDecoration("PR No."),
                      enabled: false, // Keep it disabled but with visible text
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      initialValue: _prDate,
                      style: const TextStyle(color: Colors.grey),
                      decoration: _inputDecoration("PR Date"),
                      enabled: false, // Keep it disabled but with visible text
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Required By Date
              TextFormField(
                controller: _requiredByController,
                decoration: _inputDecoration("Required By").copyWith(
                  hintText: "dd/mm/yyyy",
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.calendar_today),
                    onPressed: () => _selectDate(context),
                  ),
                ),
                readOnly: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a required by date';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Project Code Dropdown
              DropdownButtonFormField<String>(
                decoration: _inputDecoration("Select Project Code"),
                value: _selectedProjectCode,
                dropdownColor:
                    Colors.white, // Set dropdown background color to white
                items: projectCodeController.getProjectCodelist
                    .map((project) => DropdownMenuItem(
                          value: project.projectCode,
                          child: Text(
                            project.projectCode ?? '',
                            style: const TextStyle(
                                color: Colors.black), // Set text color to black
                          ),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedProjectCode = value;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Please select a project code';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              // Item Internal Code Dropdown
              DropdownButtonFormField<String>(
                decoration: _inputDecoration("Select Item Internal Code"),
                isExpanded: true, // Ensures the dropdown takes full width
                value: _selectedItemCode,
                dropdownColor: Colors.white,
                items: itemsMasterController.getItemslist.map((item) {
                  return DropdownMenuItem<String>(
                    value: item.internalCode,
                    child: Tooltip(
                      message:
                          item.internalCode ?? '', // Shows full text on hover
                      child: Container(
                        constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width - 100),
                        child: Text(
                          item.internalCode ?? '',
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontSize: 14, color: Colors.black),
                        ),
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedItemCode = value;
                    _updateUOM(value!); // Update UOM based on the selected item
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Please select an item internal code';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              // Quantity and UOM
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      style: const TextStyle(color: Colors.black),
                      controller: _quantityController,
                      decoration: _inputDecoration("Quantity"),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter quantity';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      controller: _uomController,
                      style: const TextStyle(color: Colors.grey),
                      decoration: _inputDecoration("UOM"),
                      enabled: false,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Remark
              TextFormField(
                style: const TextStyle(color: Colors.black),
                controller: _remarkController,
                decoration: _inputDecoration("Remark"),
              ),
              const SizedBox(height: 16),

              // Add to Basket Button
              Center(
                child: ElevatedButton(
                  onPressed: _addToBasket,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: const BorderSide(color: Colors.grey),
                    ),
                  ),
                  child: const Text(
                    'Add to Basket',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
