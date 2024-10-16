import 'package:erp_copy/controllers/grn_controllers/get_srn_list_in_approval_controller.dart';
import 'package:erp_copy/controllers/grn_controllers/srn_acceptance_controller.dart';
import 'package:erp_copy/model/grn_models/grn_acceptance_model.dart';
import 'package:erp_copy/screens/grn_screens/srn_acceptance_inside_screen.dart';
import 'package:erp_copy/widget/grn_cards/srn_acceptance_card.dart';
import 'package:erp_copy/widget/menu_widget/drawer_menu_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SRNAcceptanceScreen extends StatefulWidget {
  const SRNAcceptanceScreen({
    super.key,
    required this.openDrawer,
  });
  final VoidCallback openDrawer;

  @override
  State<SRNAcceptanceScreen> createState() => _SRNAcceptanceScreenState();
}

class _SRNAcceptanceScreenState extends State<SRNAcceptanceScreen> {
  TextEditingController searchController = TextEditingController();

  final SrnAcceptanceController ggrnlc = SrnAcceptanceController();

  final GetSrnListInApprovalController gsliac =
      Get.put(GetSrnListInApprovalController());

  List<GRNAcceptanceModel> itemList = [];
  List<GRNAcceptanceModel> filteredItemList = [];

  @override
  void initState() {
    super.initState();
    // searchController.addListener(_filterItems);
    _loadItemData();
  }

  void _loadItemData() async {
    var data = await ggrnlc.getSRNList();
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

  // void _filterItems() {
  //   String query =
  //       searchController.text.toLowerCase().trim(); // Trim whitespace
  //   setState(() {
  //     if (query.isEmpty) {
  //       // If the search query is empty, show all items
  //       filteredItemList = itemList;
  //     } else {
  //       filteredItemList = itemList.where((item) {
  //         return (item.grnTxID?.toString().toLowerCase().contains(query) ??
  //             false);
  //       }).toList();
  //     }
  //   });
  // }

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
                'SRN Acceptance',
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
                          onTap: () async {
                            await gsliac.getSRNList(item.grnTxnID);
                            Get.to(SRNItemsScreen(
                              GRNTxnID: item.grnTxnID,
                            ));
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: SRNAcceptanceCard(
                              duration: 1,
                              srnNumber: item.grnTxnID.toString(),
                              submittedOn: item.txnDate.toString(),
                              createdBy: item.username,
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
