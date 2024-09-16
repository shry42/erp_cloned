import 'package:erp_copy/controllers/item_master_controller/get_items_controller.dart';
import 'package:erp_copy/model/item_master/item_master_model.dart';
import 'package:erp_copy/screens/item_master_screens/block_unblock_details_screen.dart';
import 'package:erp_copy/widget/menu_widget/drawer_menu_widget.dart';
import 'package:erp_copy/widget/item_master_cards/item_master_details_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BlockUnblockItemsListScreen extends StatefulWidget {
  const BlockUnblockItemsListScreen({
    super.key,
    required this.openDrawer,
  });
  final VoidCallback openDrawer;

  @override
  State<BlockUnblockItemsListScreen> createState() =>
      _BlockUnblockItemsListScreenState();
}

class _BlockUnblockItemsListScreenState
    extends State<BlockUnblockItemsListScreen> {
  TextEditingController searchController = TextEditingController();

  final GetItemsMastercontroller gimc = GetItemsMastercontroller();

  List<ItemModel> itemList = [];
  List<ItemModel> filteredItemList = [];

  @override
  void initState() {
    super.initState();
    searchController.addListener(_filterItems);
    _loadItemData();
  }

  void _loadItemData() async {
    var data = await gimc.getItemDetails();
    setState(() {
      itemList = data;
      filteredItemList = data;
    });
  }

  void _filterItems() {
    String query = searchController.text.toLowerCase();
    setState(() {
      filteredItemList = itemList.where((item) {
        return item.sapID!.toLowerCase().contains(query) ||
            item.itemName!.toLowerCase().contains(query) ||
            item.itemGroup!.toLowerCase().contains(query);
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
                'Block-unblock Item list',
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
                            Get.to(BlockUnblockItemMasterDetailsScreen(
                              selectedItem: item,
                            ));
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: ItemMasterDetailsCrad(
                              duration: 1,
                              venusid: item.sapID,
                              itemName: item.itemName,
                              itemGroup: item.itemGroup,
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
