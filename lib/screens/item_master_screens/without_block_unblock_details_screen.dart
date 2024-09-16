import 'package:erp_copy/controllers/item_master_controller/get_items_controller.dart';
import 'package:erp_copy/model/item_master/item_master_model.dart';
import 'package:erp_copy/widget/item_master_cards/block_unblock_details_card.dart';
import 'package:erp_copy/widgets/remark_dilaogs/block_item_remark_dialog.dart';
import 'package:flutter/material.dart';

class WithoutBlockUnblockItemMasterDetailsScreen extends StatefulWidget {
  const WithoutBlockUnblockItemMasterDetailsScreen({
    super.key,
    required this.selectedItem,
  });

  final ItemModel selectedItem;

  @override
  State<WithoutBlockUnblockItemMasterDetailsScreen> createState() =>
      _WithoutBlockUnblockItemMasterDetailsScreenState();
}

class _WithoutBlockUnblockItemMasterDetailsScreenState
    extends State<WithoutBlockUnblockItemMasterDetailsScreen> {
  TextEditingController searchController = TextEditingController();

  final GetItemsMastercontroller gimc = GetItemsMastercontroller();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 68, 168, 71),
        automaticallyImplyLeading: true,
        actions: const [
          Spacer(),
          Text(
            'Item details',
            style: TextStyle(color: Colors.white, fontSize: 15),
          ),
          Spacer(),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: BlockUnblockItemDetailsCard(
                venusID: widget.selectedItem.sapID,
                itemsPerPurchase:
                    widget.selectedItem.itemsPerPurchase.toString(),
                itemName: widget.selectedItem.itemName,
                salesUOM: widget.selectedItem.salesUOM ?? "N/A",
                casNo: widget.selectedItem.casNo,
                internalCode: widget.selectedItem.internalCode,
                valuationMethod: widget.selectedItem.valuationMethod ??
                    "Please enter Valuation Method",
                itemGroup: widget.selectedItem.itemGroup,
                hsnCode: widget.selectedItem.hsnCode,
                inventoryUOM: widget.selectedItem.inventoryUOM,
                threshold: widget.selectedItem.threshold?.toString() ?? "N/A",
                purchaseUOM: widget.selectedItem.purchaseUOM,
                safetyStock:
                    widget.selectedItem.safetyStock?.toString() ?? "N/A",
                batchManagement: widget.selectedItem.manageBatch,
                serialManagement: widget.selectedItem.serialManagement,
                purchaseItem: widget.selectedItem.purchaseItem,
                salesItem: widget.selectedItem.salesItem,
                inventoryItem: widget.selectedItem.inventoryItem,
                qaManagement: widget.selectedItem.qaManagement,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
