import 'package:erp_copy/controllers/gis_controllers/basket/gis_basket_controller.dart';
import 'package:erp_copy/controllers/gis_controllers/get_gis_number_controller.dart';
import 'package:erp_copy/controllers/gis_controllers/get_item_from_item_and_pcode_controller.dart';
import 'package:erp_copy/controllers/gis_controllers/get_item_from_project_code_controller.dart';
import 'package:erp_copy/controllers/gis_controllers/get_project_code_controller.dart';
import 'package:erp_copy/controllers/gis_controllers/get_wo_details_status_controller.dart';
import 'package:erp_copy/model/gis_model/basket/gis_basket_item_model.dart';
import 'package:erp_copy/screens/gis_screens/basket/view_gis_basket_screens.dart';
import 'package:erp_copy/widget/menu_widget/drawer_menu_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateGISScreen extends StatefulWidget {
  const CreateGISScreen({super.key, required this.openDrawer});
  final VoidCallback openDrawer;

  @override
  _CreateGISScreenState createState() => _CreateGISScreenState();
}

class _CreateGISScreenState extends State<CreateGISScreen> {
  final _formKey = GlobalKey<FormState>();
  bool isWastage = false;
  bool isWorkOrder = false;
  String? projectCode;
  String? woList = '0';
  String? itemName;
  String? userName;
  String? department;
  int? itemId;
  var selectedBatch = RxString('');

  List<String> allProjectCodes = [];

  DateTime gisDate = DateTime.now();
  DateTime issueDate = DateTime.now();

  final GetGisNumberController ggnc = Get.put(GetGisNumberController());
  final GetProjectCodeGISController gpcgc =
      Get.put(GetProjectCodeGISController());

  final TextEditingController _searchController = TextEditingController();
  final GISBasketController basketController = Get.put(GISBasketController());

  final GetItemFromProjectCodeController gifpc =
      Get.put(GetItemFromProjectCodeController());

  final GetItemFromItemAndPcodeController getItemFromItemAndPcodeController =
      Get.put(GetItemFromItemAndPcodeController());

  final GetWoDetailsStatusController gwodslc =
      Get.put(GetWoDetailsStatusController());

  final TextEditingController departmentController = TextEditingController();

  final TextEditingController batchNoController = TextEditingController();
  final TextEditingController serialNoController = TextEditingController();
  final TextEditingController uomController = TextEditingController();

  final TextEditingController _issueToController = TextEditingController();

  final TextEditingController _remarksController = TextEditingController();
  final TextEditingController _reqQtyController = TextEditingController();
  final TextEditingController _issuedQtyController = TextEditingController();

  Future<void> _selectDate(BuildContext context, bool isGisDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isGisDate ? gisDate : issueDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        if (isGisDate) {
          gisDate = picked;
        } else {
          issueDate = picked;
        }
      });
    }
  }

  void _addToBasket() {
    if (_formKey.currentState!.validate()) {
      final newItem = GISBasketItem(
        venusId: 'V${ggnc.gisNo.value}',
        itemId: itemId ?? 0,
        internalCode: itemName ?? '',
        batchNo: batchNoController.text,
        serialNo: serialNoController.text,
        reqQuantity: double.tryParse(_reqQtyController.text) ?? 0,
        issuedQuantity: double.tryParse(_issuedQtyController.text) ?? 0,
        uom: uomController.text,
        remarks: _remarksController.text,
      );

      basketController.addToBasket(newItem);
      Get.snackbar('Success', 'Item added to basket');

      _clearForm();
    }
  }

  void _clearForm() {
    batchNoController.clear();
    serialNoController.clear();
    _reqQtyController.clear();
    _issuedQtyController.clear();
    uomController.clear();
    _remarksController.clear();
  }

  @override
  void initState() {
    super.initState();
    ggnc.getGISNumber();
    _issueToController.text = 'W astage';
    gpcgc.getProjectcodeList();
    gpcgc.getProjectcodeList().then((_) {
      setState(() {
        allProjectCodes = gpcgc.getProjectCodelist
            .map((project) => project.projectCode)
            .toList();
      });
    });
  }

  @override
  void dispose() {
    _issueToController.dispose();
    departmentController.dispose();
    batchNoController.dispose();
    serialNoController.dispose();
    super.dispose();
  }

  Widget buildProductionOrderField() {
    if (isWorkOrder) {
      return Obx(() {
        return _buildDropdownField(
          'Select Production Order',
          woList,
          (newValue) {
            setState(() {
              woList = newValue;
            });
          },
          gwodslc.woStatusList.map((e) => e.woTxnID.toString()).toList(),
        );
      });
    } else {
      return _buildReadOnlyTextField(
        'toggle if work Order',
        woList ?? '',
        controller: TextEditingController(text: woList ?? ''),
      );
    }
  }

  Widget buildIssueToField() {
    if (isWastage) {
      return _buildReadOnlyTextField(
        'Issue To',
        'Wastage',
        controller: _issueToController,
      );
    } else if (isWorkOrder) {
      setState(() {
        _issueToController.clear();
        // userName = '';
      });
      return _buildReadOnlyTextField('Issue To', '',
          controller: _issueToController);
    } else {
      return Obx(() {
        return _buildDropdownField(
          'Good issue to',
          userName,
          (newValue) {
            setState(() {
              userName = newValue;
              _issueToController.text = newValue ?? '';
            });
          },
          gifpc.userList.map((i) => i.username.toString()).toList(),
        );
      });
    }
  }

  Widget buildProjectCodeDropdown() {
    return Obx(() {
      if (gpcgc.getProjectCodelist.isEmpty) {
        return const CircularProgressIndicator();
      }

      final filteredList = isWorkOrder
          ? gpcgc.getProjectCodelist
              .where((project) => project.projectDepartment == "Production")
              .toList()
          : gpcgc.getProjectCodelist;

      final projectCodes =
          filteredList.map((project) => project.projectCode).toList();

      if (projectCode != null && !projectCodes.contains(projectCode)) {
        projectCode = null;
      }

      return _buildDropdownField(
        'Select Project Code',
        projectCode,
        (newValue) {
          setState(() {
            projectCode = newValue;
            final selectedProject = filteredList.firstWhere(
              (project) => project.projectCode == projectCode,
              orElse: () => gpcgc.getProjectCodelist.first,
            );
            department = selectedProject.projectDepartment;
            departmentController.text = department.toString();
            gifpc.getItemList(newValue.toString());
          });
        },
        projectCodes,
      );
    });
  }

  Widget _buildDropdownField(String label, String? value,
      ValueChanged<String?> onChanged, List<String> items) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(color: Color.fromARGB(255, 68, 168, 71)),
        ),
      ),
      dropdownColor: Colors.white,
      value: value,
      onChanged: onChanged,
      items: items.toSet().map((String item) {
        return DropdownMenuItem<String>(
          value: item,
          child: SizedBox(
            width: 300,
            child: Text(
              item,
              style: const TextStyle(color: Colors.black),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildTextField(String label,
      {int maxLines = 1, required TextEditingController controller}) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(color: Color.fromARGB(255, 68, 168, 71)),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'This field is required';
        }
        return null;
      },
    );
  }

  Widget _buildReadOnlyTextField(String label, String initialValue,
      {TextEditingController? controller}) {
    return TextFormField(
      readOnly: true,
      controller: controller ?? TextEditingController(text: initialValue),
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(color: Color.fromARGB(255, 68, 168, 71)),
        ),
      ),
    );
  }

  Widget _buildDateTextField(
      String label, VoidCallback onPressed, String initialValue) {
    return TextFormField(
      readOnly: true,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        labelText: label,
        suffixIcon: IconButton(
          icon: const Icon(Icons.calendar_today),
          onPressed: onPressed,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(color: Color.fromARGB(255, 68, 168, 71)),
        ),
      ),
      controller: TextEditingController(text: initialValue),
    );
  }

  Widget _buildSwitchListTile(
      String title, bool value, ValueChanged<bool> onChanged) {
    return Container(
      width: 195,
      child: SwitchListTile(
        title: Text(
          title,
          style: const TextStyle(color: Colors.black),
        ),
        value: value,
        onChanged: onChanged,
      ),
    );
  }

  Widget _buildListSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'PR List',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        const SizedBox(height: 8),
        Obx(() {
          final dataToShow =
              getItemFromItemAndPcodeController.itemlist.toList();
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
                      label: Text('Select',
                          style: TextStyle(color: Colors.black))),
                  DataColumn(
                      label: Text('Batch NO.',
                          style: TextStyle(color: Colors.black))),
                  DataColumn(
                      label: Text('Serial No',
                          style: TextStyle(color: Colors.black))),
                  DataColumn(
                      label: Text('Unrestricted Stock',
                          style: TextStyle(color: Colors.black))),
                  DataColumn(
                      label: Text('Purchase UOM',
                          style: TextStyle(color: Colors.black))),
                  DataColumn(
                      label: Text('Inventory UOM',
                          style: TextStyle(color: Colors.black))),
                ],
                rows: dataToShow.map((items) {
                  return DataRow(
                    cells: [
                      DataCell(Checkbox(
                        value: selectedBatch.value == items.batchNo.toString(),
                        onChanged: (value) {
                          if (value == true) {
                            selectedBatch.value =
                                items.batchNo?.toString() ?? '';
                            batchNoController.text =
                                items.batchNo?.toString() ?? '';
                            serialNoController.text =
                                items.serialNo?.toString() ?? '';
                            uomController.text = items.inventoryUOM.toString();
                          } else {
                            if (selectedBatch.value ==
                                items.batchNo.toString()) {
                              selectedBatch.value = '';
                              batchNoController.clear();
                              serialNoController.clear();
                            }
                          }
                        },
                      )),
                      DataCell(Text(
                          items.batchNo != null ? '${items.batchNo}' : '',
                          style: const TextStyle(color: Colors.black))),
                      DataCell(Text(
                          items.serialNo != null ? '${items.serialNo}' : '',
                          style: const TextStyle(color: Colors.black))),
                      DataCell(Text(items.unrestrictedStock.toString(),
                          style: const TextStyle(color: Colors.black))),
                      DataCell(Text(items.purchaseUOM.toString(),
                          style: const TextStyle(color: Colors.black))),
                      DataCell(Text(items.inventoryUOM ?? '',
                          style: const TextStyle(color: Colors.black))),
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
                'Goods Issue Slip',
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
              const SizedBox(width: 90),
              DrawerMenuWidget(
                onClicked: widget.openDrawer,
              ),
              const SizedBox(width: 20),
            ],
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: [
                _buildSwitchListTile('Is Wastage?', isWastage, (value) {
                  setState(() {
                    isWastage = value;
                    if (isWastage) {
                      _issueToController.text = 'Wastage';
                      userName = null;
                    } else {
                      _issueToController.text = userName ?? '';
                    }
                  });
                }),
                _buildSwitchListTile('Is Work Order?', isWorkOrder, (value) {
                  setState(() {
                    isWorkOrder = value;
                    if (isWorkOrder) {
                      gwodslc.getWOStatusList();
                    } else {
                      woList = null;
                    }
                  });
                }),
              ]),
              const SizedBox(height: 10),
              Obx(() {
                if (ggnc.gisNo.isEmpty) {
                  return const CircularProgressIndicator();
                }
                return _buildReadOnlyTextField('GIS No.', ggnc.gisNo.value);
              }),
              const SizedBox(height: 10),
              _buildDateTextField('GIS Date', () => _selectDate(context, true),
                  "${gisDate.toLocal()}".split(' ')[0]),
              const SizedBox(height: 10),
              buildProjectCodeDropdown(),
              const SizedBox(height: 10),
              _buildReadOnlyTextField(
                'department',
                departmentController.text,
              ),
              const SizedBox(height: 10),
              buildProductionOrderField(),
              const SizedBox(height: 10),
              buildIssueToField(),
              const SizedBox(height: 10),
              _buildDateTextField(
                  'Issue Date',
                  () => _selectDate(context, false),
                  "${issueDate.toLocal()}".split(' ')[0]),
              const SizedBox(height: 10),
              const Divider(),
              const SizedBox(height: 10),
              Obx(() {
                return _buildDropdownField(
                  'select item name',
                  itemName,
                  (newValue) {
                    setState(() {
                      itemName = newValue;
                      final selectedItemID = gifpc.itemlist.firstWhere(
                        (i) => i.internalCode == itemName,
                      );
                      itemId = selectedItemID.itemId;
                      getItemFromItemAndPcodeController.getItemList(
                          projectCode.toString(), itemId!.toInt());
                    });
                  },
                  gifpc.itemlist.map((item) => item.internalCode).toList(),
                );
              }),
              const SizedBox(height: 10),
              _buildListSection(),
              const SizedBox(height: 10),
              _buildTextField('Batch No.', controller: batchNoController),
              const SizedBox(height: 10),
              _buildTextField('Serial No.', controller: serialNoController),
              const SizedBox(height: 10),
              _buildTextField('Req Qty', controller: _reqQtyController),
              const SizedBox(height: 10),
              _buildTextField('Issued Qty', controller: _issuedQtyController),
              const SizedBox(height: 10),
              _buildTextField('UOM', controller: uomController),
              const SizedBox(height: 10),
              _buildTextField('Remarks', controller: _remarksController),
              const SizedBox(height: 20),
              Obx(() {
                if (getItemFromItemAndPcodeController.isBlocked == 2) {
                  return ElevatedButton(
                    onPressed: null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black26,
                    ),
                    child: const Text(
                      'This item is blocked',
                      style: TextStyle(color: Colors.black),
                    ),
                  );
                } else if (getItemFromItemAndPcodeController.isBlocked == 1) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white),
                          onPressed: _addToBasket,
                          child: const Text(
                            'Add to Basket',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white),
                          onPressed: () {
                            Get.to(() => ViewBasketGISScreen(
                                  department: isWorkOrder
                                      ? ''
                                      : departmentController.text,
                                  issuedTo: isWastage
                                      ? 'Wastage'
                                      : (_issueToController.text ?? ''),
                                  projectCode: projectCode.toString(),
                                  gisDate: gisDate,
                                  isWorkOrder: isWorkOrder,
                                  workOrderId:
                                      int.parse(woList.toString()) ?? 0,
                                ));
                          },
                          child: const Text(
                            'View Basket',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return Container();
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}
