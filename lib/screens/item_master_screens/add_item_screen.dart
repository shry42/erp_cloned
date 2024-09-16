import 'package:erp_copy/controllers/item_groups_controller.dart/get_item_groups_controller.dart';
import 'package:erp_copy/controllers/item_master_controller/get_uom_data_controller.dart';
import 'package:erp_copy/controllers/item_master_controller/get_venus_id_controller.dart';
import 'package:erp_copy/widget/menu_widget/drawer_menu_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddItemScreen extends StatefulWidget {
  const AddItemScreen({
    super.key,
    required this.openDrawer,
  });
  final VoidCallback openDrawer;

  @override
  State<AddItemScreen> createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  final _formKey = GlobalKey<FormState>();

  final GetVenusIdController gvic = GetVenusIdController();
  final GetUomController guc = GetUomController();
  final GetItemGroupsController gigc = GetItemGroupsController();

  // Form field controllers
  TextEditingController itemNameController = TextEditingController();
  TextEditingController casNoController = TextEditingController();
  TextEditingController internalCodeController = TextEditingController();
  TextEditingController itemsPerPurchaseController = TextEditingController();
  TextEditingController itemsPerSaleController = TextEditingController();
  TextEditingController hsnCodeController = TextEditingController();
  TextEditingController thresholdController = TextEditingController();
  TextEditingController venusIdController = TextEditingController();

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

  @override
  void initState() {
    super.initState();
    fetchItemGroups();
    fetchUom();
  }

  Future<void> fetchItemGroups() async {
    await gigc.getItemsGroups();
    setState(() {}); // Trigger UI update after fetching data
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
                  ),
                ),
              ),
              // Item Name
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
                child: TextFormField(
                  controller: itemNameController,
                  decoration: InputDecoration(
                    labelText: 'Item Name',
                    hintText: 'Please enter item name',
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter item name';
                    }
                    return null;
                  },
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
                    hintText: 'Please enter cas number',
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter CAS number';
                    }
                    return null;
                  },
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
                    hintText: 'Please enter internal code',
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
              // Select Item Group
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
                child: DropdownButtonFormField<String>(
                  value: selectedItemGroup,
                  decoration: InputDecoration(
                    labelText: 'Select Item Group',
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 6, horizontal: 2),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  items: gigc.itemGroupList.map((group) {
                    return DropdownMenuItem<String>(
                      value: group.itemGroups,
                      child: Text(group.itemGroups ?? ''),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedItemGroup = newValue;
                      gvic.getVenusid(selectedItemGroup.toString());
                    });
                    if (newValue != null) {
                      updateVenusId(
                          newValue); // Update Venus ID when an item group is selected
                      setState(() {});
                    }
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select an item group';
                    }
                    return null;
                  },
                ),
              ),
              // Venus ID (Uneditable TextField)
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
                child: TextFormField(
                  controller: venusIdController,
                  decoration: InputDecoration(
                    labelText: 'Venus ID',
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
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
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
                  value: selectedInventoryUOM,
                  decoration: InputDecoration(
                    labelText: 'Inventory UOM',
                    hintText: 'Select inventory UOM',
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  items: guc.getUomList.map((uom) {
                    return DropdownMenuItem<String>(
                      value: uom.code,
                      child: Text(uom.code ?? ''),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedInventoryUOM = newValue;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select an inventory UOM';
                    }
                    return null;
                  },
                ),
              ),
              // Purchase UOM
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
                child: DropdownButtonFormField<String>(
                  value: selectedPurchaseUOM,
                  decoration: InputDecoration(
                    labelText: 'Purchase UOM',
                    hintText: 'Select purchase UOM',
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  items: guc.getUomList.map((uom) {
                    return DropdownMenuItem<String>(
                      value: uom.code,
                      child: Text(uom.code ?? ''),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedPurchaseUOM = newValue;
                    });
                  },
                ),
              ),
              // Sales UOM
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
                child: DropdownButtonFormField<String>(
                  value: selectedSalesUOM,
                  decoration: InputDecoration(
                    labelText: 'Sales UOM',
                    hintText: 'Select sales UOM',
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  items: guc.getUomList.map((uom) {
                    return DropdownMenuItem<String>(
                      value: uom.code,
                      child: Text(uom.code ?? ''),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedSalesUOM = newValue;
                    });
                  },
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
                    hintText: 'Please enter items per purchase',
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  style: const TextStyle(
                    color: Colors.black,
                  ),
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
                    hintText: 'Please enter items per sale',
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
              // Valuation Method
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
                child: DropdownButtonFormField<String>(
                  value: selectedValuationMethod,
                  decoration: InputDecoration(
                    labelText: 'Valuation Method',
                    hintText: 'Select valuation method',
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
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
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedValuationMethod = newValue;
                    });
                  },
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
                    hintText: 'Please enter hsn code',
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  style: const TextStyle(
                    color: Colors.black,
                  ),
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
                    hintText: 'Please enter threshold (%)',
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
              // Safety Stock
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
                child: DropdownButtonFormField<String>(
                  value: selectedSafetyStock,
                  decoration: InputDecoration(
                    labelText: 'Safety Stock (%)',
                    hintText: 'Select safety stock',
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  items: List.generate(11, (index) => (index * 5).toString())
                      .map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedSafetyStock = newValue;
                    });
                  },
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
                  ),
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
                    if (_formKey.currentState?.validate() ?? false) {
                      // Submit the form
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
