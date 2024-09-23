import 'package:erp_copy/controllers/gis_controllers/get_gis_number_controller.dart';
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
  String? itemName;
  DateTime gisDate = DateTime.now();
  DateTime issueDate = DateTime.now();

  final GetGisNumberController ggnc = Get.put(GetGisNumberController());

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

  @override
  void initState() {
    super.initState();
    ggnc.getGISNumber();
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
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // GIS Number and Date
              Obx(() => _buildReadOnlyTextField('GIS No.', ggnc.gisNo.value)),
              SizedBox(height: 10),
              _buildDateTextField('GIS Date', () => _selectDate(context, true),
                  "${gisDate.toLocal()}".split(' ')[0]),
              SizedBox(height: 10),
              // Project Code Dropdown
              _buildDropdownField('Project Code', projectCode, (newValue) {
                setState(() {
                  projectCode = newValue;
                });
              }, ['PR042023', 'PR052023']),
              SizedBox(height: 10),
              // Department (Read-only)
              _buildReadOnlyTextField('Department', 'RnD'),
              SizedBox(height: 10),
              // Production Order
              _buildTextField('Production Order'),
              SizedBox(height: 10),
              // Good Issue To
              _buildTextField('Good Issue To'),
              SizedBox(height: 10),
              // Issue Date
              _buildDateTextField(
                  'Issue Date',
                  () => _selectDate(context, false),
                  "${issueDate.toLocal()}".split(' ')[0]),
              SizedBox(height: 10),
              // Item Name Dropdown
              _buildDropdownField('Item Name', itemName, (newValue) {
                setState(() {
                  itemName = newValue;
                });
              }, ['Item 1', 'Item 2', 'Item 3']),
              SizedBox(height: 10),
              // Switches for Wastage and Work Order
              _buildSwitchListTile('Is Wastage?', isWastage, (value) {
                setState(() {
                  isWastage = value;
                });
              }),
              _buildSwitchListTile('Is Work Order?', isWorkOrder, (value) {
                setState(() {
                  isWorkOrder = value;
                });
              }),
              // Additional Fields: Batch, Serial, Req Qty, Issued Qty, UOM
              _buildTextField('Batch No.'),
              SizedBox(height: 10),
              _buildTextField('Serial No.'),
              SizedBox(height: 10),
              _buildTextField('Req Qty'),
              SizedBox(height: 10),
              _buildTextField('Issued Qty'),
              SizedBox(height: 10),
              _buildTextField('UOM'),
              SizedBox(height: 10),
              _buildTextField('Remarks', maxLines: 3),
              SizedBox(height: 20),
              // Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Process data
                      }
                    },
                    child: Text('Add to Basket'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Navigate to Basket screen
                    },
                    child: Text('View Basket'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, {int maxLines = 1}) {
    return TextFormField(
      maxLines: maxLines,
      style: TextStyle(color: Colors.black), // Set text color to black
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: Color.fromARGB(255, 68, 168, 71)),
        ),
      ),
    );
  }

  Widget _buildReadOnlyTextField(String label, String initialValue) {
    return TextFormField(
      readOnly: true,
      initialValue: initialValue,
      style: TextStyle(color: Colors.black), // Set text color to black
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: Color.fromARGB(255, 68, 168, 71)),
        ),
      ),
    );
  }

  Widget _buildDateTextField(
      String label, VoidCallback onPressed, String initialValue) {
    return TextFormField(
      readOnly: true,
      style: TextStyle(color: Colors.black), // Set text color to black
      decoration: InputDecoration(
        labelText: label,
        suffixIcon: IconButton(
          icon: Icon(Icons.calendar_today),
          onPressed: onPressed,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: Color.fromARGB(255, 68, 168, 71)),
        ),
      ),
      controller: TextEditingController(text: initialValue),
    );
  }

  Widget _buildDropdownField(String label, String? value,
      ValueChanged<String?> onChanged, List<String> items) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: Color.fromARGB(255, 68, 168, 71)),
        ),
      ),
      value: value,
      onChanged: onChanged,
      items: items.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value,
              style: TextStyle(color: Colors.black)), // Set text color to black
        );
      }).toList(),
    );
  }

  Widget _buildSwitchListTile(
      String title, bool value, ValueChanged<bool> onChanged) {
    return SwitchListTile(
      title: Text(title),
      value: value,
      onChanged: onChanged,
    );
  }
}
