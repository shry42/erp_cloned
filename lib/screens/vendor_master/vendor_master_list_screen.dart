import 'package:erp_copy/controllers/vendor_master_controller/vendor_master_list_controller.dart';
import 'package:erp_copy/model/vendor_master/vendor_master_model.dart';
import 'package:erp_copy/screens/vendor_master/block_unblock_vendor_details_screen.dart';
import 'package:erp_copy/screens/vendor_master/vendor_master_details_screen.dart';
import 'package:erp_copy/widget/menu_widget/drawer_menu_widget.dart';
import 'package:erp_copy/widget/vendor_cards/vendor_master_cards.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VendorMasterListScreen extends StatefulWidget {
  const VendorMasterListScreen({
    super.key,
    required this.openDrawer,
  });
  final VoidCallback openDrawer;

  @override
  State<VendorMasterListScreen> createState() => _VendorMasterListScreenState();
}

class _VendorMasterListScreenState extends State<VendorMasterListScreen> {
  TextEditingController searchController = TextEditingController();
  final GetVendorMastercontroller gvmc = GetVendorMastercontroller();
  final _formKey = GlobalKey<FormState>();

  List<VendorModel> vendorList = [];
  List<VendorModel> filteredVendorList = [];

  @override
  void initState() {
    super.initState();
    searchController.addListener(_filterVendors);
    _loadVendorData();
  }

  void _loadVendorData() async {
    var data = await gvmc.getVednorMaster();
    setState(() {
      vendorList = data;
      filteredVendorList = data;
    });
  }

  void _filterVendors() {
    String query = searchController.text.toLowerCase();
    setState(() {
      filteredVendorList = vendorList.where((vendor) {
        return vendor.vendorID.toString().toLowerCase().contains(query) ||
            vendor.vendorName!.toLowerCase().contains(query) ||
            vendor.vendorGroup!.toLowerCase().contains(query) ||
            vendor.paymentTerms!.toLowerCase().contains(query) ||
            vendor.vendorCurrency!.toLowerCase().contains(query);
      }).toList();
    });
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
                'Vendor Master list',
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
              const SizedBox(width: 80),
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                          borderSide: const BorderSide(
                            width: 1,
                            color: Colors.green,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Colors.grey)),
                        hintText: "Search for vendor",
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
            filteredVendorList.isEmpty
                ? const Center(
                    child: Text('No vendors found'),
                  )
                : SizedBox(
                    height: MediaQuery.of(context).size.height * 0.75,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: filteredVendorList.length,
                      itemBuilder: (context, index) {
                        var vendor = filteredVendorList[index];
                        return GestureDetector(
                          onTap: () {
                            Get.to(VendorMasterDetailsScreen(
                              selectedItem: vendor,
                            ));
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: VendorMasterCard(
                              duration: 1,
                              vendorId: vendor.vendorID.toString(),
                              vendorName: vendor.vendorName,
                              Group: vendor.vendorGroup,
                              PaymentTerm: vendor.paymentTerms,
                              Currency: vendor.vendorCurrency,
                              Telephone: vendor.telephone,
                              mobile: vendor.mobilePhone,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
