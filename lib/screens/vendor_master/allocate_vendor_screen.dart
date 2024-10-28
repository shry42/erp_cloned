import 'package:erp_copy/controllers/menu_controllers/create_master_menu_controller.dart';
import 'package:erp_copy/controllers/menu_controllers/insert_sub_menu_controller.dart';
import 'package:erp_copy/controllers/menu_controllers/update_sub_menu_controller.dart';
import 'package:erp_copy/controllers/vendor_master_controller/get_allocated_vendor_controller.dart';
import 'package:erp_copy/controllers/vendor_master_controller/insert_vendor_allocation_controller.dart';
import 'package:erp_copy/controllers/vendor_master_controller/vendor_master_list_controller.dart';
import 'package:erp_copy/widget/menu_widget/drawer_menu_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:intl/intl.dart';

class AllocateVendorScreen extends StatefulWidget {
  const AllocateVendorScreen({
    super.key,
    required this.openDrawer,
  });
  final VoidCallback openDrawer;

  @override
  State<AllocateVendorScreen> createState() => _AllocateVendorScreenState();
}

class _AllocateVendorScreenState extends State<AllocateVendorScreen> {
  TextEditingController searchController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  final advancedDrawerController = AdvancedDrawerController();
  final TextEditingController menuController = TextEditingController();
  final TextEditingController urlController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final CreateMasterMenuController cmmc = CreateMasterMenuController();
  final InsertVendorAllocationController ismc =
      InsertVendorAllocationController();
  final GetVendorMastercontroller gmmlc = GetVendorMastercontroller();
  final GetAllocatedVendorController gsmilc = GetAllocatedVendorController();
  final UpdateSubMenuController usmc = UpdateSubMenuController();

  List<dynamic> masterMenuList = [];
  String? selectedLabel;
  String? selectedMasterMenu;
  int? id = 28;

  @override
  void initState() {
    super.initState();
    fetchMasterMenuList();
    // Set today's date by default
    dateController.text = DateFormat('yyyy-MM-dd').format(DateTime.now());
  }

  void fetchMasterMenuList() async {
    await gmmlc.getVednorMaster();
    setState(() {
      masterMenuList = gmmlc.getVednorlist;
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      setState(() {
        // Update the TextEditingController with the selected date
        dateController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
        // gsmilc.getAllocatedVednors(dateController.text.toString());
      });
    }
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
                'Allocate Vendor',
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
              const SizedBox(width: 85),
              DrawerMenuWidget(
                onClicked: widget.openDrawer,
              ),
              const SizedBox(width: 20),
            ],
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 6),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 6),
                      child: DropdownButtonFormField<String>(
                        dropdownColor: Colors.white,
                        value: selectedMasterMenu,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 6, horizontal: 8),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          labelText: 'Select Vendor',
                        ),
                        items: masterMenuList
                            .map((menu) => menu.vendorName)
                            .toSet() // Ensure unique vendor names
                            .map((vendorName) {
                          return DropdownMenuItem<String>(
                            value: vendorName,
                            child: Text(
                              vendorName,
                              style: const TextStyle(color: Colors.black),
                            ),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedMasterMenu = newValue;
                            final selectedMasterMenuData =
                                masterMenuList.firstWhere(
                              (menu) => menu.vendorName == newValue,
                            );
                            id = selectedMasterMenuData
                                .vendorID; // Ensure this matches your data model
                            print("*****$id");
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please select a vendor";
                          }
                          return null;
                        },
                      )),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: TextFormField(
                      controller: dateController,
                      readOnly: true, // Make the TextFormField read-only
                      onTap: () =>
                          _selectDate(context), // Open date picker on tap
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Colors.grey),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 6, horizontal: 8),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        labelText: 'Date',
                      ),
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter a date";
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        await ismc.insertVendorAllocation(
                          id!.toInt(),
                          selectedMasterMenu.toString(),
                          dateController.text.toString(),
                        );
                      }
                      setState(() {});
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      minimumSize: const Size(120, 40),
                    ),
                    child: const Text(
                      'Add',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            FutureBuilder(
              future:
                  gsmilc.getAllocatedVednors(dateController.text.toString()),
              builder: (BuildContext ctx, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.data == null || snapshot.data == []) {
                  return const Center(
                    child: Text('No record found'),
                  );
                } else if (snapshot.hasError) {
                  return const Center(
                    child: Text('No record found'),
                  );
                } else {
                  // Handle your snapshot data here
                  return SizedBox(
                    height: MediaQuery.of(context).size.height * 0.6,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        var vendorName = snapshot.data[index].vendorName;
                        var date = snapshot.data[index].date;

                        // Format the date to 'yyyy-MM-dd'
                        String formattedDate = '';
                        if (date != null) {
                          formattedDate = DateFormat('yyyy-MM-dd').format(date);
                        }

                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: GestureDetector(
                            onTap: () {
                              // Get.to(UpdateSubMenuScreen(
                              //   id: id,
                              //   name: subMenuName,
                              //   url: url,
                              // ));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 68, 168, 71),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: ListTile(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                tileColor: Colors.transparent,
                                title: Text(
                                  "Name : $vendorName\nDate : $formattedDate",
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
