import 'package:erp_copy/controllers/item_groups_controller.dart/get_item_groups_controller.dart';
import 'package:erp_copy/controllers/item_master_controller/get_uom_data_controller.dart';
import 'package:erp_copy/controllers/item_master_controller/get_venus_id_controller.dart';
import 'package:erp_copy/controllers/item_master_controller/insert_item_controller.dart';
import 'package:erp_copy/utils/toast_notify.dart';
import 'package:erp_copy/widget/menu_widget/drawer_menu_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddItemScreen extends StatefulWidget {
  const AddItemScreen({super.key, required this.openDrawer});
  final VoidCallback openDrawer;

  @override
  State<AddItemScreen> createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  final _formKey = GlobalKey<FormState>();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  final InsertDataController insertController = InsertDataController();
  final GetVenusIdController gvic = GetVenusIdController();
  final GetUomController guc = GetUomController();
  final GetItemGroupsController gigc = GetItemGroupsController();

  // Form field controllers
  final TextEditingController itemNameController = TextEditingController();
  final TextEditingController casNoController = TextEditingController();
  final TextEditingController internalCodeController = TextEditingController();
  final TextEditingController itemsPerPurchaseController =
      TextEditingController();
  final TextEditingController itemsPerSaleController = TextEditingController();
  final TextEditingController hsnCodeController = TextEditingController();
  final TextEditingController thresholdController = TextEditingController();
  final TextEditingController venusIdController = TextEditingController();

  // Dropdown values
  String? selectedItemGroup;
  String? selectedInventoryUOM;
  String? selectedPurchaseUOM;
  String? selectedSalesUOM;
  String? selectedValuationMethod;
  String? selectedSafetyStock;

  // Checkbox values
  bool inventoryItemChecked = false;
  bool batchManagementChecked = false;
  bool serialManagementChecked = false;
  bool qaManagementChecked = false;
  bool purchaseItemChecked = false;
  bool salesItemChecked = false;

  // Validation functions
// Enhanced validation function
  String? validateField(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }

    switch (fieldName.toLowerCase()) {
      case 'cas number':
        if (!RegExp(r'^[0-9-]+$').hasMatch(value)) {
          return 'Please enter a valid CAS number';
        }
        break;

      case 'items per purchase':
      case 'items per sale':
        if (int.tryParse(value) == null) {
          return 'Please enter a valid number';
        }
        break;

      case 'threshold (%)':
        final number = double.tryParse(value);
        if (number == null || number < 0 || number > 100) {
          return 'Please enter a valid percentage (0-100)';
        }
        break;

      case 'hsn code':
        if (!RegExp(r'^\d{4,8}$').hasMatch(value)) {
          return 'Please enter a valid HSN code';
        }
        break;
    }

    return null;
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate() ?? false) {
      try {
        await insertController.insertData(
          itemName: itemNameController.text,
          sapId: venusIdController.text,
          casNo: casNoController.text,
          internalCode: internalCodeController.text,
          category: selectedItemGroup,
          hsnCode: hsnCodeController.text,
          inventoryItem: inventoryItemChecked ? 1 : 0,
          inventoryUom: selectedInventoryUOM ?? '',
          itemGroup: selectedItemGroup ?? '',
          itemsPerPurchase: int.tryParse(itemsPerPurchaseController.text) ?? 0,
          itemsPerSales: itemsPerSaleController.text,
          manageBatch: batchManagementChecked ? 1 : 0,
          purchaseItem: purchaseItemChecked ? 1 : 0,
          purchaseUom: selectedPurchaseUOM ?? '',
          qaManagement: qaManagementChecked ? 1 : 0,
          safetyStock: selectedSafetyStock ?? '0',
          salesItem: salesItemChecked ? 1 : 0,
          salesUom: selectedSalesUOM ?? '',
          serialManagement: serialManagementChecked ? 1 : 0,
          threshold: thresholdController.text,
          valuationMethod: selectedValuationMethod ?? 'NA',
        );

        _clearForm();
      } catch (e) {
        Get.snackbar(
          'Error',
          'Failed to add item: ${e.toString()}',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } else {
      // Show a message that form validation failed
      Get.snackbar(
        'Validation Error',
        'Please fill in all required fields',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );

      // Force the form to show all validation errors
      setState(() {
        _autovalidateMode = AutovalidateMode.always;
      });
    }
  }

  void _clearForm() {
    itemNameController.clear();
    casNoController.clear();
    internalCodeController.clear();
    itemsPerPurchaseController.clear();
    itemsPerSaleController.clear();
    hsnCodeController.clear();
    thresholdController.clear();
    venusIdController.clear();

    setState(() {
      selectedItemGroup = null;
      selectedInventoryUOM = null;
      selectedPurchaseUOM = null;
      selectedSalesUOM = null;
      selectedValuationMethod = null;
      selectedSafetyStock = null;

      inventoryItemChecked = false;
      batchManagementChecked = false;
      serialManagementChecked = false;
      qaManagementChecked = false;
      purchaseItemChecked = false;
      salesItemChecked = false;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchItemGroups();
    fetchUom();
  }

  Future<void> fetchItemGroups() async {
    await gigc.getItemsGroups();
    setState(() {});
  }

  Future<void> fetchUom() async {
    await guc.getUom();
    setState(() {});
  }

  Future<void> updateVenusId(String itemGroup) async {
    await gvic.getVenusid(itemGroup);
    venusIdController.text = gvic.venusId ?? 'No Venus ID';
    setState(() {});
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
                'Add item',
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
              const SizedBox(width: 100),
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
          child: ListView(
            children: [
              // Section Heading
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 6),
                child: Text(
                  'Item Details',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
              // Item Name
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
                child: TextFormField(
                  controller: itemNameController,
                  decoration: InputDecoration(
                    labelText: 'Item name',
                    labelStyle: const TextStyle(color: Colors.black),
                    hintText: 'Please enter item name',
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 6,
                      horizontal: 8,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                  validator: (value) => validateField(value, 'item name'),
                ),
              ),

              // CAS No.
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
                child: TextFormField(
                  controller: casNoController,
                  decoration: InputDecoration(
                    labelText: 'CAS No.',
                    labelStyle: const TextStyle(color: Colors.black),
                    hintText: 'Please enter cas number',
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 6,
                      horizontal: 8,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                  validator: (value) => validateField(value, 'cas number'),
                ),
              ),
              // Internal Code
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
                child: TextFormField(
                  controller: internalCodeController,
                  decoration: InputDecoration(
                    labelText: 'Internal Code',
                    labelStyle: const TextStyle(color: Colors.black),
                    hintText: 'Please enter internal code',
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 6,
                      horizontal: 8,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                  validator: (value) => validateField(value, 'internal code'),
                ),
              ),
              // Select Item Group
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
                child: DropdownButtonFormField<String>(
                  dropdownColor: Colors.white,
                  value: selectedItemGroup,
                  isExpanded: true, // Add this to prevent overflow
                  decoration: InputDecoration(
                    labelText: 'Select Item Group',
                    labelStyle: const TextStyle(color: Colors.black),
                    hintText: 'Select item group',
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    enabledBorder: OutlineInputBorder(
                      // Add this for consistent border style
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 6,
                      horizontal: 8,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  items: gigc.itemGroupList.map((group) {
                    return DropdownMenuItem<String>(
                      value: group.itemGroups,
                      child: Text(
                        group.itemGroups ?? '',
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 14, // Add this to control text size
                        ),
                        overflow: TextOverflow
                            .ellipsis, // Add this to handle text overflow
                      ),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedItemGroup = newValue;
                      gvic.getVenusid(selectedItemGroup.toString());
                    });
                    if (newValue != null) {
                      updateVenusId(newValue);
                      setState(() {});
                    }
                  },
                  validator: (value) => validateField(value, 'item group'),
                ),
              ), // Venus ID (Uneditable TextField)
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
                child: TextFormField(
                  controller: venusIdController,
                  decoration: InputDecoration(
                    labelText: 'Venus ID',
                    labelStyle: const TextStyle(color: Colors.black),
                    hintText: 'Venus ID will be auto-filled',
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                          color: Colors.grey), // Same border as enabled
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 6,
                      horizontal: 8,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                  enabled: false, // Make the field uneditable
                ),
              ),
              // Inventory UOM
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
                child: DropdownButtonFormField<String>(
                  dropdownColor: Colors.white,
                  value: selectedInventoryUOM,
                  decoration: InputDecoration(
                    labelText: 'Inventory UOM',
                    labelStyle: const TextStyle(color: Colors.black),
                    hintText: 'Select inventory UOM',
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 6,
                      horizontal: 8,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  items: guc.getUomList.map((uom) {
                    return DropdownMenuItem<String>(
                      value: uom.code,
                      child: Text(
                        uom.code ?? '',
                        style: const TextStyle(color: Colors.black),
                      ),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedInventoryUOM = newValue;
                    });
                  },
                  validator: (value) => validateField(value, 'inventory UOM'),
                ),
              ),
              // Purchase UOM
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
                child: DropdownButtonFormField<String>(
                  dropdownColor: Colors.white,
                  value: selectedPurchaseUOM,
                  decoration: InputDecoration(
                    labelText: 'Purchase UOM',
                    labelStyle: const TextStyle(color: Colors.black),
                    hintText: 'Select purchase UOM',
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 6,
                      horizontal: 8,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  items: guc.getUomList.map((uom) {
                    return DropdownMenuItem<String>(
                      value: uom.code,
                      child: Text(
                        uom.code ?? '',
                        style: const TextStyle(color: Colors.black),
                      ),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedPurchaseUOM = newValue;
                    });
                  },
                  validator: (value) => validateField(value, 'purchase UOM'),
                ),
              ),
              // Sales UOM
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
                child: DropdownButtonFormField<String>(
                  dropdownColor: Colors.white,
                  value: selectedSalesUOM,
                  decoration: InputDecoration(
                    labelText: 'Sales UOM',
                    labelStyle: const TextStyle(color: Colors.black),
                    hintText: 'Select sales UOM',
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 6,
                      horizontal: 8,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  items: guc.getUomList.map((uom) {
                    return DropdownMenuItem<String>(
                      value: uom.code,
                      child: Text(
                        uom.code ?? '',
                        style: const TextStyle(color: Colors.black),
                      ),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedSalesUOM = newValue;
                    });
                  },
                  validator: (value) => validateField(value, 'sales UOM'),
                ),
              ),
              // Items per Purchase
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
                child: TextFormField(
                  controller: itemsPerPurchaseController,
                  decoration: InputDecoration(
                    labelText: 'Items per Purchase',
                    labelStyle: const TextStyle(color: Colors.black),
                    hintText: 'Please enter items per purchase ',
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 6,
                      horizontal: 8,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                  validator: (value) =>
                      validateField(value, 'items per purchase'),
                ),
              ),
              // Items per Sale
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
                child: TextFormField(
                  controller: itemsPerSaleController,
                  decoration: InputDecoration(
                    labelText: 'Items per Sale',
                    labelStyle: const TextStyle(color: Colors.black),
                    hintText: 'Please enter items per sale',
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 6,
                      horizontal: 8,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                  validator: (value) => validateField(value, 'items per sale'),
                ),
              ),
              // Valuation Method
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
                child: DropdownButtonFormField<String>(
                  dropdownColor: Colors.white,
                  value: selectedValuationMethod,
                  decoration: InputDecoration(
                    labelText: 'Valuation Method',
                    labelStyle: const TextStyle(color: Colors.black),
                    hintText: 'Select valuation method',
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 6,
                      horizontal: 8,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  items: <String>[
                    'NA',
                    'Batch',
                    'FIFO',
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: const TextStyle(color: Colors.black),
                      ),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedValuationMethod = newValue;
                    });
                  },
                  validator: (value) =>
                      validateField(value, 'valuation method'),
                ),
              ),
              // HSN Code
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
                child: TextFormField(
                  controller: hsnCodeController,
                  decoration: InputDecoration(
                    labelText: 'HSN Code',
                    labelStyle: const TextStyle(color: Colors.black),
                    hintText: 'Please enter hsn code',
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 6,
                      horizontal: 8,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                  validator: (value) => validateField(value, 'hsn code'),
                ),
              ),
              // Threshold (%)
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
                child: TextFormField(
                  controller: thresholdController,
                  decoration: InputDecoration(
                    labelText: 'Threshold (%)',
                    labelStyle: const TextStyle(color: Colors.black),
                    hintText: 'Please enter threshold (%)',
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 6,
                      horizontal: 8,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                  validator: (value) => validateField(value, 'threshold (%)'),
                ),
              ),
              // Safety Stock
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
                child: DropdownButtonFormField<String>(
                  dropdownColor: Colors.white,
                  value: selectedSafetyStock,
                  decoration: InputDecoration(
                    labelText: 'Safety Stock (%)',
                    labelStyle: const TextStyle(color: Colors.black),
                    hintText: 'Select safety stock',
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 6,
                      horizontal: 8,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  items: List.generate(11, (index) => (index * 5).toString())
                      .map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: const TextStyle(color: Colors.black),
                      ),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedSafetyStock = newValue;
                    });
                  },
                  validator: (value) => validateField(value, 'safety stock'),
                ),
              ),
              // Section Heading
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 6),
                child: Text(
                  'Item Management Options',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
              // Checkboxes
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
                child: CheckboxListTile(
                  title: const Text(
                    'Inventory Item',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  value: inventoryItemChecked,
                  onChanged: (bool? value) {
                    setState(() {
                      inventoryItemChecked = value ?? false;
                      if (!inventoryItemChecked) {
                        batchManagementChecked = false;
                        serialManagementChecked = false;
                        qaManagementChecked = false;
                      }
                    });
                  },
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
                child: CheckboxListTile(
                  title: Text(
                    'Batch Management',
                    style: TextStyle(
                      color: inventoryItemChecked
                          ? Colors.black
                          : Colors.grey, // Greying out if unchecked
                      fontWeight: inventoryItemChecked
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                  value: batchManagementChecked,
                  onChanged: inventoryItemChecked
                      ? (bool? value) {
                          setState(() {
                            batchManagementChecked = value ?? false;
                          });
                        }
                      : null,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
                child: CheckboxListTile(
                  title: Text(
                    'Serial Management',
                    style: TextStyle(
                      color: inventoryItemChecked
                          ? Colors.black
                          : Colors.grey, // Greying out if unchecked
                      fontWeight: inventoryItemChecked
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                  value: serialManagementChecked,
                  onChanged: inventoryItemChecked
                      ? (bool? value) {
                          setState(() {
                            serialManagementChecked = value ?? false;
                          });
                        }
                      : null,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
                child: CheckboxListTile(
                  title: Text(
                    'QA Management',
                    style: TextStyle(
                      color: inventoryItemChecked
                          ? Colors.black
                          : Colors.grey, // Greying out if unchecked
                      fontWeight: inventoryItemChecked
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                  value: qaManagementChecked,
                  onChanged: inventoryItemChecked
                      ? (bool? value) {
                          setState(() {
                            qaManagementChecked = value ?? false;
                          });
                        }
                      : null,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
                child: CheckboxListTile(
                  title: const Text(
                    'Purchase Item',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  value: purchaseItemChecked,
                  onChanged: (bool? value) {
                    setState(() {
                      purchaseItemChecked = value ?? false;
                    });
                  },
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
                child: CheckboxListTile(
                  title: const Text(
                    'Sales Item',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  value: salesItemChecked,
                  onChanged: (bool? value) {
                    setState(() {
                      salesItemChecked = value ?? false;
                    });
                  },
                ),
              ),
              // Add button
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
                child: ElevatedButton(
                  onPressed: () {
                    if (itemNameController.text.isEmpty ||
                        itemNameController.text == '') {
                      Get.snackbar(
                        'Validation Error',
                        'Please enter item name',
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.red,
                        colorText: Colors.white,
                      );
                    } else if (casNoController.text.isEmpty ||
                        casNoController.text == '') {
                      Get.snackbar(
                        'Validation Error',
                        'Please enter cas number',
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.red,
                        colorText: Colors.white,
                      );
                    } else if (internalCodeController.text.isEmpty ||
                        internalCodeController.text == '') {
                      Get.snackbar(
                        'Validation Error',
                        'Please enter internal code',
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.red,
                        colorText: Colors.white,
                      );
                    } else if (selectedItemGroup == null) {
                      Get.snackbar(
                        'Validation Error',
                        'Please select item group',
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.red,
                        colorText: Colors.white,
                      );
                    } else if (selectedSafetyStock == null) {
                      Get.snackbar(
                        'Validation Error',
                        'Please select safety stock',
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.red,
                        colorText: Colors.white,
                      );
                    } else {
                      _submitForm();
                    }
                  },
                  child: const Text('Add'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
