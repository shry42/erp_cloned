import 'package:erp_copy/controllers/stock_posting_controllers/allocate_stock_posting_controller.dart';
import 'package:erp_copy/widget/menu_widget/drawer_menu_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:erp_copy/controllers/stock_posting_controllers/na_stock_posting_list_controller.dart';

class GISStatusListScreen extends StatefulWidget {
  const GISStatusListScreen({super.key, required this.openDrawer});

  final VoidCallback openDrawer;

  @override
  _GISStatusListScreenState createState() => _GISStatusListScreenState();
}

class _GISStatusListScreenState extends State<GISStatusListScreen> {
  final NaStockPostingListController controller =
      Get.put(NaStockPostingListController());

  final AllocateStockPostingController aspc =
      Get.put(AllocateStockPostingController());

  List<StockItem> pilotStores = [];
  List<StockItem> warehouse = [];
  List<StockItem> rndStores = [];
  List<StockItem> nonAllocatedPool = []; // State for non-allocated pool

  @override
  void initState() {
    super.initState();
    // Fetch data on initialization
    controller.getAllGRNList().then((_) {
      // Update nonAllocatedPool after fetching
      nonAllocatedPool = controller.naStockList
          .map((apiItem) => StockItem(
                apiItem.sapID,
                apiItem.itemID.toString(),
                apiItem.batchNo,
                apiItem.serialNo,
                apiItem.internalCode,
                apiItem.naStock,
                itemGroup: "Anode - Raw materials", // Default value
                purchaseUOM: "KGS", // Default value
                id: apiItem.id,
              ))
          .toList();
      setState(() {}); // Update UI
    });
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
                'Stock Posting',
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
              const SizedBox(width: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                onPressed: () async {
                  // Ensure UI data is synchronized with controller before posting
                  aspc.warehouseItems.clear();
                  aspc.pilotStoreItems.clear();
                  aspc.rndPoolItems.clear();

                  // Convert StockItems to Maps and assign to controller
                  aspc.warehouseItems.addAll(warehouse
                      .map((item) => item.toJsonForAllocation())
                      .toList());
                  aspc.pilotStoreItems.addAll(pilotStores
                      .map((item) => item.toJsonForAllocation())
                      .toList());
                  aspc.rndPoolItems.addAll(rndStores
                      .map((item) => item.toJsonForAllocation())
                      .toList());

                  await aspc.allocateStockPosting();
                },
                child: const Text(
                  'Allocate',
                  style: TextStyle(color: Colors.black),
                ),
              ),
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
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        if (nonAllocatedPool.isEmpty) {
          return Center(child: Text("No data available"));
        }

        return SingleChildScrollView(
          child: Column(
            children: [
              buildStockSection('Non Allocated Pool', nonAllocatedPool),
              buildStockSection('Pilot Stores', pilotStores),
              buildStockSection('Warehouse', warehouse),
              buildStockSection('RnD Stores', rndStores),
            ],
          ),
        );
      }),
    );
  }

  Widget buildStockSection(String title, List<StockItem> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          height: 200,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8),
          ),
          margin: EdgeInsets.symmetric(horizontal: 8),
          child: DragTarget<StockItem>(
            builder: (context, candidateData, rejectedData) {
              return ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return buildDraggableStockItem(items[index], items);
                },
              );
            },
            onWillAccept: (data) => data != null && !items.contains(data),
            onAccept: (StockItem item) {
              setState(() {
                items.add(item); // Add to the new section
                nonAllocatedPool.remove(item); // Remove from Non Allocated Pool
              });
            },
          ),
        ),
        SizedBox(height: 16),
      ],
    );
  }

  Widget buildDraggableStockItem(StockItem item, List<StockItem> sourceList) {
    return Draggable<StockItem>(
      data: item,
      child: buildStockItemTile(item),
      feedback: Material(
        elevation: 4.0,
        child: ConstrainedBox(
          constraints:
              BoxConstraints(maxWidth: MediaQuery.of(context).size.width - 32),
          child: buildStockItemTile(item),
        ),
      ),
      childWhenDragging: Opacity(
        opacity: 0.5,
        child: buildStockItemTile(item),
      ),
      onDragCompleted: () {
        setState(() {
          sourceList.remove(item); // Remove from the original list
        });
      },
    );
  }

  Widget buildStockItemTile(StockItem item) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: ListTile(
        tileColor: Color.fromARGB(255, 56, 95, 56),
        title: Text('${item.internalCode} - Stock: ${item.stock}'),
        subtitle: Text('Venus ID: ${item.venusId}, Item ID: ${item.itemId}'),
        dense: true,
      ),
    );
  }
}

class StockItem {
  final String venusId;
  final String itemId;
  final String batchNo;
  final String serialNo;
  final String internalCode;
  final int stock;
  final String itemGroup; // New property
  final String purchaseUOM; // New property
  final int id; // New property

  StockItem(
    this.venusId,
    this.itemId,
    this.batchNo,
    this.serialNo,
    this.internalCode,
    this.stock, {
    this.itemGroup = "Anode - Raw materials", // Default value
    this.purchaseUOM = "KGS", // Default value
    this.id = 0, // Default placeholder
  });

  Map<String, dynamic> toJsonForAllocation() {
    return {
      'ItemID': int.parse(itemId), // Assuming ItemID is an integer
      'ItemName': internalCode, // Adjust as necessary
      'BatchNo': batchNo,
      'SerialNo': serialNo,
      'InternalCode': internalCode,
      'ItemGroup': itemGroup,
      'PurchaseUOM': purchaseUOM,
      'NAStock': stock,
      'PostDate': DateTime.now()
          .toIso8601String(), // Set it to the correct date if needed
      'id': id, // Use actual ID if available
      'SAP_ID': venusId, // Adjust as necessary
    };
  }
}
