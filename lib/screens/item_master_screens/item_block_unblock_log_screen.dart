import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:erp_copy/controllers/item_master_controller/block_unblock_items/item_block_unblock_log_controller.dart';
import 'package:erp_copy/model/item_master/item_block_unblock_log_model.dart';
import 'package:erp_copy/widget/menu_widget/drawer_menu_widget.dart';
import 'package:erp_copy/widget/item_master_cards/item_block_unblock_log_cards.dart';
import 'package:flutter/material.dart';

class ItemBlockUnblockLogScreen extends StatefulWidget {
  const ItemBlockUnblockLogScreen({
    super.key,
    required this.openDrawer,
  });
  final VoidCallback openDrawer;

  @override
  State<ItemBlockUnblockLogScreen> createState() =>
      _ItemBlockUnblockLogScreenState();
}

class _ItemBlockUnblockLogScreenState extends State<ItemBlockUnblockLogScreen> {
  TextEditingController searchController = TextEditingController();
  final GetItemBlockUnblockLogcontroller gibulc =
      GetItemBlockUnblockLogcontroller();

  List<ItemBlockUnblockLogModel> itemList = [];
  List<ItemBlockUnblockLogModel> filteredItemList = [];
  List<ItemBlockUnblockLogModel>? mainDataList;
  List<dynamic>? dataList;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) async {
      await gibulc.getItemDetails().then((value) {
        setState(() {
          mainDataList = value;
          dataList = mainDataList; // Show all items initially
          filteredItemList = mainDataList ?? [];
        });
      });
    });

    // Add listener to search controller
    searchController.addListener(_filterItems);
  }

  void _filterItems() {
    String query = searchController.text.toLowerCase();
    setState(() {
      filteredItemList = mainDataList?.where((item) {
            return item.itemId!.toString().contains(query) ||
                item.itemName!.toLowerCase().contains(query) ||
                item.itemGroup!.toLowerCase().contains(query);
          }).toList() ??
          [];
      dataList = filteredItemList; // Update dataList based on search query
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  Widget _buildTabContent(List<dynamic>? dataList) {
    if (dataList == null || dataList.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/loaderr.gif', height: 200, width: 350),
            const Text('No records found'),
          ],
        ),
      );
    }
    return ListView.builder(
      itemCount: dataList.length,
      itemBuilder: (context, index) {
        var item = dataList[index];
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: ItemBlockUnblockLogCard(
            duration: 1,
            itemId: item.id.toString(),
            venusid: item.venusId,
            itemName: item.itemName,
            itemGroup: item.itemGroup,
            status: item.status,
            blockUnblockAt: item.isBlockUnBlockAt,
            superAdminstatus: item.superadminStatus,
            remark: item.isBlockUnblockRemarks,
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
              const Text('Block-unblock Item Log list',
                  style: TextStyle(color: Colors.white, fontSize: 15)),
              const SizedBox(width: 80),
              DrawerMenuWidget(onClicked: widget.openDrawer),
              const SizedBox(width: 20),
            ],
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
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
                        borderSide: const BorderSide(color: Colors.grey)),
                    hintText: "Search for items",
                    hintStyle:
                        const TextStyle(fontSize: 12, color: Colors.black),
                    suffixIcon: const Icon(Icons.search),
                    prefixIconColor: Colors.black,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: DefaultTabController(
                length: 4,
                child: Column(
                  children: <Widget>[
                    ButtonsTabBar(
                      onTap: (index) {
                        setState(() {
                          if (index == 0) {
                            dataList = mainDataList
                                ?.where((element) => element.superadminStatus
                                    .toString()
                                    .contains('2'))
                                .toList();
                          } else if (index == 1) {
                            dataList = mainDataList
                                ?.where((element) => element.superadminStatus
                                    .toString()
                                    .contains('1'))
                                .toList();
                          } else if (index == 2) {
                            dataList = mainDataList
                                ?.where((element) => element.status
                                    .toString()
                                    .contains('Blocked'))
                                .toList();
                          } else if (index == 3) {
                            dataList = mainDataList
                                ?.where((element) => element.status
                                    .toString()
                                    .contains('UnBlocked'))
                                .toList();
                          }
                          searchController.clear();
                        });
                      },
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 10),
                      unselectedBackgroundColor:
                          const Color.fromARGB(255, 125, 141, 122),
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 68, 168, 71),
                      ),
                      unselectedLabelStyle:
                          const TextStyle(color: Colors.white),
                      labelStyle: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      tabs: const [
                        Tab(text: "Approved"),
                        Tab(text: "Rejected"),
                        Tab(text: "Blocked"),
                        Tab(text: "Unblocked"),
                      ],
                    ),
                    SizedBox(
                      height: 700, // Define a height for the TabBarView
                      child: TabBarView(
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          _buildTabContent(dataList),
                          _buildTabContent(dataList),
                          _buildTabContent(dataList),
                          _buildTabContent(dataList),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
