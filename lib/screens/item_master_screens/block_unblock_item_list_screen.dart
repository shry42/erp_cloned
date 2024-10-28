import 'package:erp_copy/controllers/item_master_controller/get_items_controller.dart';
import 'package:erp_copy/model/drawer_item.dart';
import 'package:erp_copy/model/item_master/item_master_model.dart';
import 'package:erp_copy/screens/item_master_screens/block_unblock_details_screen.dart';
import 'package:erp_copy/widget/menu_widget/drawer_menu_widget.dart';
import 'package:erp_copy/widget/item_master_cards/item_master_details_card.dart';
import 'package:erp_copy/widget/menu_widget/navigation_controller.dart';
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
  final TextEditingController searchController = TextEditingController();
  final GetItemsMastercontroller gimc = GetItemsMastercontroller();
  final NavigationController navigationController =
      Get.find<NavigationController>();

  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    searchController.addListener(() {
      setState(() {
        searchQuery = searchController.text.toLowerCase();
      });
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
      child: SizedBox(
        height: 35,
        width: 390,
        child: TextField(
          style: const TextStyle(color: Colors.black),
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
              borderSide: const BorderSide(color: Colors.grey),
            ),
            hintText: "Search for items",
            hintStyle: const TextStyle(fontSize: 12, color: Colors.grey),
            suffixIcon: const Icon(Icons.search),
            prefixIconColor: Colors.black,
          ),
        ),
      ),
    );
  }

  Widget _buildItemList(List<dynamic> items) {
    final List<ItemModel> itemModels =
        items.map((item) => item as ItemModel).toList();

    final filteredItems = itemModels.where((item) {
      return item.sapID!.toLowerCase().contains(searchQuery) ||
          item.itemName!.toLowerCase().contains(searchQuery) ||
          item.itemGroup!.toLowerCase().contains(searchQuery);
    }).toList();

    if (filteredItems.isEmpty) {
      return const Center(child: Text('No matching items found'));
    }

    return ListView.builder(
      shrinkWrap: true,
      itemCount: filteredItems.length,
      itemBuilder: (context, index) {
        final item = filteredItems[index];
        return GestureDetector(
          onTap: () {
            Get.to(() => BlockUnblockItemMasterDetailsScreen(
                  selectedItem: item,
                ));
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: ItemMasterDetailsCrad(
              duration: 1,
              venusid: item.sapID,
              itemName: item.itemName,
              itemGroup: item.itemGroup,
            ),
          ),
        );
      },
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
                'Block-unblock Item list',
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
              const SizedBox(width: 80),
              DrawerMenuWidget(onClicked: widget.openDrawer),
              const SizedBox(width: 20),
            ],
          )
        ],
      ),
      body: Column(
        children: [
          _buildSearchBar(),
          Expanded(
            child: FutureBuilder(
              future: gimc.getItemDetails(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                if (!snapshot.hasData || snapshot.data == null) {
                  return const Center(child: Text('No items found'));
                }

                return _buildItemList(snapshot.data);
              },
            ),
          ),
        ],
      ),
    );
  }
}
