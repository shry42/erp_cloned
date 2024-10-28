import 'package:erp_copy/controllers/item_master_controller/approve_blocked_list_controller.dart';
import 'package:erp_copy/controllers/item_master_controller/block_item_list_controller.dart';
import 'package:erp_copy/model/drawer_item.dart';
import 'package:erp_copy/model/item_master/block_item_list_model.dart';
import 'package:erp_copy/screens/item_master_screens/block_unblock_details_screen.dart';
import 'package:erp_copy/widget/item_master_cards/block_item_list_card.dart';
import 'package:erp_copy/widget/menu_widget/drawer_items.dart';
import 'package:erp_copy/widget/menu_widget/drawer_menu_widget.dart';
import 'package:erp_copy/widget/menu_widget/navigation_controller.dart';
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
  final TextEditingController searchController = TextEditingController();
  final GetBlockItemListController gbilc = GetBlockItemListController();
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

  Widget _buildItemList(List<BlockItemListModel> items) {
    final filteredItems = items.where((item) {
      return item.sapID?.toLowerCase().contains(searchQuery) == true ||
          item.itemName?.toLowerCase().contains(searchQuery) == true ||
          item.itemGroup?.toLowerCase().contains(searchQuery) == true;
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
            showBlockItemListDialog(item);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                'Block Item List',
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
            child: FutureBuilder<void>(
              future: gbilc.getBlockList(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                final items = gbilc.blockList;
                if (items.isEmpty) {
                  return const Center(child: Text('No items found'));
                }

                return _buildItemList(items);
              },
            ),
          ),
        ],
      ),
    );
  }
}

void showBlockItemListDialog(BlockItemListModel item) {
  final NavigationController navigationController =
      Get.put(NavigationController());

  void navigateToScreen(DrawerItem screen) {
    navigationController.directNavigateToScreen(screen);
  }

  final ApproveBlockedListController approveblc =
      ApproveBlockedListController();
  Get.defaultDialog(
    title: "Block list Dialog",
    titleStyle: const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
    content: const Column(
      children: [
        Text(
          "Please choose one of the options below:",
          style: TextStyle(fontSize: 16, color: Colors.black54),
        ),
        SizedBox(height: 20),
      ],
    ),
    radius: 10, // Rounded corners for the dialog

    backgroundColor: Colors.white,
    actions: [
      ElevatedButton(
        onPressed: () async {
          // Action for "Assign Item Group"
          Get.back(); // Close the dialog
          approveblc.approve(item.itemID!.toInt(), 1);
          navigationController
              .directNavigateToScreen(DrawerItems.blockItemsList);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        ),
        child: const Text(
          "Approve",
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
      ),
      ElevatedButton(
        onPressed: () async {
          // Action for "Assign Item Group"
          Get.back(); // Close the dialog
          approveblc.approve(item.itemID!.toInt(), 2);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 215, 93, 56),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        ),
        child: const Text(
          "Reject",
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
      ),
      ElevatedButton(
        onPressed: () {
          // Action for "View Item Group"
          Get.back(); // Close the dialog
          Get.to(BlockUnblockItemMasterDetailsScreen(selectedItem: item));
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.grey,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        ),
        child: const Text(
          "View Items",
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
      ),
    ],
  );
}
