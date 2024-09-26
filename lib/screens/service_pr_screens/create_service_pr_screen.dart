import 'package:erp_copy/controllers/pr_controllers/get_project_code_list_controller.dart';
import 'package:erp_copy/controllers/pr_controllers/get_single_data_controller.dart';
import 'package:erp_copy/controllers/service_pr_controllers/add_to_service_pr_basket_controller.dart';
import 'package:erp_copy/controllers/service_pr_controllers/get_uom_data_controllers.dart';
import 'package:erp_copy/controllers/service_pr_controllers/get_user_item_groups_controller.dart';
import 'package:erp_copy/model/item_master/item_master_list_model.dart';
import 'package:erp_copy/model/service_pr_models/service_pr_basket_model.dart';
import 'package:erp_copy/screens/service_pr_screens/view_service_basket_screen.dart';
import 'package:erp_copy/widget/menu_widget/drawer_menu_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

class CreateServicePRScreen extends StatefulWidget {
  const CreateServicePRScreen({
    super.key,
    required this.openDrawer,
  });
  final VoidCallback openDrawer;

  @override
  State<CreateServicePRScreen> createState() => _CreateServicePRScreenState();
}

class _CreateServicePRScreenState extends State<CreateServicePRScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _serviceNameController = TextEditingController();
  final TextEditingController _serviceDescriptionController =
      TextEditingController();

  final TextEditingController _remarkController = TextEditingController();
  final TextEditingController _requiredByController = TextEditingController();
  final TextEditingController _uomController = TextEditingController();
  final TextEditingController _prNoController = TextEditingController();

  String? _selectedProjectCode;
  String? _selectedUOM;
  String? _selectedServiceGroup;
  final String _prDate = DateFormat('dd/MM/yyyy').format(DateTime.now());

  final SingleDataController singleDataController =
      Get.put(SingleDataController());
  final GetProjectCodeListcontroller projectCodeController =
      Get.put(GetProjectCodeListcontroller());
  final GetUserItemGroupsController _userItemGrpCont =
      Get.put(GetUserItemGroupsController());

  final GetUomDataControllers guomdc = Get.put(GetUomDataControllers());

  final ServicePRBasketController basketController =
      Get.put(ServicePRBasketController());

  void _addToBasket() {
    if (_formKey.currentState!.validate()) {
      final item = ServicePRBasket(
        srNo: (basketController.basketItems.length + 1).toString(),
        prNumber: _prNoController.text,
        requiredBy: _requiredByController.text,
        projectCode: _selectedProjectCode ?? '',
        serviceGroup: _selectedServiceGroup ?? '',
        serviceName: _serviceNameController.text,
        quantity: _quantityController.text,
        purchaseUOM: _selectedUOM.toString(),
        remark: _remarkController.text,
        description: _serviceDescriptionController.text,
        prDate: _prDate,
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
      _selectedServiceGroup = null;
      _uomController.clear();
    });
  }

  @override
  void initState() {
    super.initState();
    _loadPRNo(); // Load PR No. from API
    projectCodeController.getProjectcodeList(); // Fetch project codes
    guomdc.getUomData();
    _userItemGrpCont.getItemGroups(); // Fetch item details
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
    final selectedItem = _userItemGrpCont.getItemGroups().firstWhere(
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
                'Create Service PR',
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
              const SizedBox(width: 75),
              ElevatedButton(
                onPressed: () {
                  Get.to(() =>
                      ViewServicePRBasketScreen()); // Navigate to View Basket Screen
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
                decoration: _inputDecoration("Select Service Group"),
                isExpanded: true, // Ensures the dropdown takes full width
                value: _selectedServiceGroup,
                dropdownColor: Colors.white,
                items: _userItemGrpCont.itemGroups.map((item) {
                  return DropdownMenuItem<String>(
                    value: item.itemGroups,
                    child: Tooltip(
                      message:
                          item.itemGroups ?? '', // Shows full text on hover
                      child: Container(
                        constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width - 100),
                        child: Text(
                          item.itemGroups ?? '',
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
                    _selectedServiceGroup = value;
                    // _updateUOM(value!); // Update UOM based on the selected item
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

              //
              TextFormField(
                style: const TextStyle(color: Colors.black),
                controller: _serviceNameController,
                decoration: _inputDecoration("Service Name"),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter service name';
                  }
                  return null;
                },
              ),
              //
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
                  //UOM Dropdown
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      decoration: _inputDecoration("Select UOM"),
                      value: _selectedUOM,
                      dropdownColor: Colors
                          .white, // Set dropdown background color to white
                      items: guomdc.uomData
                          .map((e) => DropdownMenuItem(
                                value: e.code,
                                child: Text(
                                  e.code ?? '',
                                  style: const TextStyle(
                                      color: Colors
                                          .black), // Set text color to black
                                ),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedUOM = value;
                        });
                      },
                      validator: (value) {
                        if (value == null) {
                          return 'Please select uom';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              TextFormField(
                style: const TextStyle(color: Colors.black),
                controller: _serviceDescriptionController,
                decoration: _inputDecoration("Service description"),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter service description';
                  }
                  return null;
                },
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
