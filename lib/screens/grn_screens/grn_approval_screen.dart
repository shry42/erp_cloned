import 'package:erp_copy/controllers/grn_controllers/get_grn_list_controller.dart';
import 'package:erp_copy/model/grn_models/grn_list_model.dart';
import 'package:erp_copy/screens/grn_screens/grn_list_in_approval_screen.dart';
import 'package:erp_copy/widget/grn_cards/grn_list_approval_cards.dart';
import 'package:erp_copy/widget/menu_widget/drawer_menu_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GRNListApprovalScreen extends StatefulWidget {
  const GRNListApprovalScreen({
    super.key,
    required this.openDrawer,
  });
  final VoidCallback openDrawer;

  @override
  State<GRNListApprovalScreen> createState() => _GRNListApprovalScreenState();
}

class _GRNListApprovalScreenState extends State<GRNListApprovalScreen> {
  TextEditingController searchController = TextEditingController();

  final GetGrnListController ggrnlc = GetGrnListController();

  List<GRNListModel> itemList = [];
  List<GRNListModel> filteredItemList = [];

  @override
  void initState() {
    super.initState();
    searchController.addListener(_filterItems);
    _loadItemData();
  }

  void _loadItemData() async {
    var data = await ggrnlc.getGRNList();
    setState(() {
      if (data != null && data.isNotEmpty) {
        itemList = data;
        filteredItemList = data;
      } else {
        // Handle the case where no data is returned from API
        itemList = [];
        filteredItemList = [];
      }
    });
  }

  void _filterItems() {
    String query =
        searchController.text.toLowerCase().trim(); // Trim whitespace
    setState(() {
      if (query.isEmpty) {
        // If the search query is empty, show all items
        filteredItemList = itemList;
      } else {
        filteredItemList = itemList.where((item) {
          return (item.grnTxnID?.toString().toLowerCase().contains(query) ??
              false);
        }).toList();
      }
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
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
                'GRN list Approval',
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
                        hintText: "Search for items",
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
                ? const Center(
                    child: Text('No items found'),
                  )
                : SizedBox(
                    height: MediaQuery.of(context).size.height * 0.75,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: filteredItemList.length,
                      itemBuilder: (context, index) {
                        var item = filteredItemList[index];
                        return GestureDetector(
                          onTap: () {
                            Get.to(GRNListInApprovalScreen(
                              grnTxnID: item.grnTxnID!.toInt(),
                            ));
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: GRNSRNApprovalCard(
                              duration: 1,
                              grnNumber: item.grnTxnID.toString(),
                              invoiceNo: item.invoiceNo,
                              invoiceDate: item.invoiceDate.toString(),
                              challanNo: item.challanNo,
                              submittedOn: item.txnDate.toString(),
                              createdBy: item.fullName,
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
