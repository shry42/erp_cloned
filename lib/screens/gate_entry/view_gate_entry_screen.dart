import 'package:erp_copy/controllers/gate_entry/get_gate_entry_log_details_controller.dart';
import 'package:erp_copy/model/gate_entry/get_entry_log_details_model.dart';
import 'package:erp_copy/widget/gate_entry_list_cards/gate_entry_list_card.dart';
import 'package:erp_copy/widget/menu_widget/drawer_menu_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart'; // Import for date formatting

class ViewGateEntryScreen extends StatefulWidget {
  const ViewGateEntryScreen({
    super.key,
    required this.openDrawer,
  });
  final VoidCallback openDrawer;

  @override
  State<ViewGateEntryScreen> createState() => _ViewGateEntryScreenState();
}

class _ViewGateEntryScreenState extends State<ViewGateEntryScreen> {
  TextEditingController searchController = TextEditingController();
  DateTime? startDate;
  DateTime? endDate;

  final GetGateEntryLogDetailsController ggeldc =
      Get.put(GetGateEntryLogDetailsController());

  List<GetGateEntryLogModel> filteredItemList = [];

  @override
  void initState() {
    super.initState();
    _loadItemData();
    searchController.addListener(_filterItems);
  }

  void _loadItemData() async {
    try {
      await ggeldc.getLogData();
      _filterItems(); // Initial filter
    } catch (e) {
      print('Error fetching gate entry log data: $e');
    }
  }

  DateTime _parseDateString(String dateString) {
    // Parse the date string into a DateTime object
    return DateTime.parse(dateString).toLocal();
  }

  void _filterItems() {
    String query = searchController.text.toLowerCase();
    setState(() {
      filteredItemList = ggeldc.getLogDetails.where((item) {
        bool matchesDateRange = true;

        if (startDate != null && endDate != null) {
          if (item.challanDate != null) {
            DateTime challanDate =
                _parseDateString(item.challanDate.toString());
            matchesDateRange = challanDate.isAfter(startDate!) &&
                challanDate.isBefore(endDate!.add(Duration(days: 1)));
          } else {
            matchesDateRange = false;
          }
        }

        bool matchesSearch = query.isEmpty ||
            item.gateEntryID.toString().toLowerCase().contains(query);
        return matchesDateRange && matchesSearch;
      }).toList();
    });
  }

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: isStartDate
          ? (startDate ?? DateTime.now())
          : (endDate ?? DateTime.now()),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null &&
        pickedDate != (isStartDate ? startDate : endDate)) {
      setState(() {
        if (isStartDate) {
          startDate = pickedDate;
        } else {
          endDate = pickedDate;
        }
        _filterItems();
      });
    }
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
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
                'View Gate Entry list',
                style: TextStyle(color: Colors.white, fontSize: 15),
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
      body: Obx(() {
        if (ggeldc.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 80.0, vertical: 10),
                      child: Row(
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              shadowColor: Colors.black,
                            ),
                            onPressed: () => _selectDate(context, true),
                            child: Text(
                              startDate != null
                                  ? DateFormat('yyyy-MM-dd').format(startDate!)
                                  : 'Select Start Date',
                              style: const TextStyle(color: Colors.black),
                            ),
                          ),
                          const SizedBox(width: 10),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              shadowColor: Colors.black,
                            ),
                            onPressed: () => _selectDate(context, false),
                            child: Text(
                              endDate != null
                                  ? DateFormat('yyyy-MM-dd').format(endDate!)
                                  : 'Select End Date',
                              style: const TextStyle(color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 20),
                    child: SizedBox(
                      height: 35,
                      width: 390,
                      child: TextField(
                        controller: searchController,
                        decoration: InputDecoration(
                          focusColor: Colors.black,
                          filled: true,
                          fillColor: const Color(0xfff1f1f1),
                          border: OutlineInputBorder(
                            gapPadding: 20,
                            borderRadius: BorderRadius.circular(8),
                            borderSide:
                                const BorderSide(width: 1, color: Colors.green),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(color: Colors.grey)),
                          hintText: "Search by Gate Entry ID",
                          hintStyle:
                              const TextStyle(fontSize: 12, color: Colors.grey),
                          suffixIcon: const Icon(Icons.search),
                          prefixIconColor: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              filteredItemList.isEmpty
                  ? const Center(child: Text('No items found'))
                  : SizedBox(
                      height: MediaQuery.of(context).size.height * 0.75,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: filteredItemList.length,
                        itemBuilder: (context, index) {
                          var item = filteredItemList[index];
                          return GestureDetector(
                            onTap: () {
                              // Handle item tap if needed
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              child: GateEntryCard(
                                duration: 1,
                                gateEntryID: item.gateEntryID,
                                challanNo: item.challanNo,
                                challanDate: item.challanDate,
                                poCode: item.poCode,
                                itemCount: item.itemCount,
                                receivedDate: item.receivedDate,
                                receivedByUser: item.receivedByUser,
                                authorizerUserName: item.authorizerUserName,
                                grnDone: item.grnDone,
                                remarks: item.remarks,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
            ],
          ),
        );
      }),
    );
  }
}
