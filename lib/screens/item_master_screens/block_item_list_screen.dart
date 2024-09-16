import 'package:erp_copy/controllers/item_master_controller/block_item_list_controller.dart';
import 'package:erp_copy/model/item_master/block_item_list_model.dart';
import 'package:erp_copy/widget/item_master_cards/block_item_list_card.dart';
import 'package:erp_copy/widget/menu_widget/drawer_menu_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BlockItemListScreen extends StatefulWidget {
  const BlockItemListScreen({
    super.key,
    required this.openDrawer,
  });
  final VoidCallback openDrawer;

  @override
  State<BlockItemListScreen> createState() => _BlockItemListScreenState();
}

class _BlockItemListScreenState extends State<BlockItemListScreen> {
  TextEditingController searchController = TextEditingController();
  final GetBlockItemListController gbilc = GetBlockItemListController();

  List<BlockItemListModel> itemList = [];
  List<BlockItemListModel> filteredItemList = [];

  @override
  void initState() {
    super.initState();
    fetchBlockedItems();
  }

  Future<void> fetchBlockedItems() async {
    await gbilc.getBlockList();
    setState(() {
      itemList = gbilc.blockList;
      filteredItemList = itemList;
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void filterSearchResults(String query) {
    if (query.isNotEmpty) {
      setState(() {
        filteredItemList = itemList
            .where((item) =>
                item.itemName?.toLowerCase().contains(query.toLowerCase()) ??
                false)
            .toList();
      });
    } else {
      setState(() {
        filteredItemList = itemList;
      });
    }
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
                'Block Item List',
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
                      onChanged: filterSearchResults,
                      decoration: InputDecoration(
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
                            // Handle tap on item if needed
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: BlockItemListCard(
                              duration: 300,
                              venusId: item.sapID,
                              itemName: item.itemName,
                              itemGroup: item.itemGroup,
                              requestFor: item.isBlockUnblockStatus,
                              reason: item.isBlockUnblockRemarks,
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
