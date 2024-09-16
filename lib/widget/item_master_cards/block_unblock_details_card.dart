import 'package:flutter/material.dart';

class BlockUnblockItemDetailsCard extends StatelessWidget {
  BlockUnblockItemDetailsCard({
    super.key,
    this.venusID,
    this.itemsPerPurchase,
    this.itemName,
    this.salesUOM,
    this.casNo,
    this.itemsPerSale,
    this.internalCode,
    this.valuationMethod,
    this.itemGroup,
    this.hsnCode,
    this.inventoryUOM,
    this.threshold,
    this.purchaseUOM,
    this.safetyStock,
    this.batchManagement,
    this.serialManagement,
    this.purchaseItem,
    this.salesItem,
    this.inventoryItem,
    this.qaManagement,
  });

  final String? venusID;
  final String? itemsPerPurchase;
  final String? itemName;
  final String? salesUOM;
  final String? casNo;
  final String? itemsPerSale;
  final String? internalCode;
  final String? valuationMethod;
  final String? itemGroup;
  final String? hsnCode;
  final String? inventoryUOM;
  final String? threshold;
  final String? purchaseUOM;
  final String? safetyStock;
  final bool? batchManagement;
  final bool? serialManagement;
  final bool? purchaseItem;
  final bool? salesItem;
  final bool? inventoryItem;
  final bool? qaManagement;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Center(
            child: Table(
              defaultColumnWidth: const FixedColumnWidth(200.0),
              border: TableBorder.all(
                color: Colors.green[300]!,
                width: 2.0,
                borderRadius: BorderRadius.circular(12),
              ),
              children: [
                _buildTableRow('Venus-ID', '$venusID', isFirstRow: true),
                _buildTableRow('Items per Purchase', '$itemsPerPurchase'),
                _buildTableRow('Item Name', '$itemName'),
                _buildTableRow('Sales UOM', '$salesUOM'),
                _buildTableRow('CAS No.', '$casNo'),
                _buildTableRow('Items per Sale', '$itemsPerSale'),
                _buildTableRow('Internal Code', '$internalCode'),
                _buildTableRow('Valuation Method', '$valuationMethod'),
                _buildTableRow('Item Group', '$itemGroup'),
                _buildTableRow('HSN Code', '$hsnCode'),
                _buildTableRow('Inventory UOM', '$inventoryUOM'),
                _buildTableRow('Threshold (%)', '$threshold'),
                _buildTableRow('Purchase UOM', '$purchaseUOM'),
                _buildTableRow('Safety Stock (%)', '$safetyStock'),
                _buildSwitchRow('Batch Management', batchManagement ?? false),
                _buildSwitchRow('Serial Management', serialManagement ?? false),
                _buildSwitchRow('Purchase Item', purchaseItem ?? false),
                _buildSwitchRow('Sales Item', salesItem ?? false),
                _buildSwitchRow('Inventory Item', inventoryItem ?? false),
                _buildSwitchRow('QA Management', qaManagement ?? false,
                    isLastRow: true),
              ],
            ),
          ),
        ],
      ),
    );
  }

  TableRow _buildTableRow(String title, String value,
      {bool isFirstRow = false, bool isLastRow = false}) {
    return TableRow(
      children: [
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              textAlign: TextAlign.center,
              title,
              style: const TextStyle(
                color: Color.fromARGB(255, 60, 58, 58),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Text(
              textAlign: TextAlign.center,
              value,
              style: const TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }

  TableRow _buildSwitchRow(String title, bool value, {bool isLastRow = false}) {
    return TableRow(
      children: [
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              textAlign: TextAlign.center,
              title,
              style: const TextStyle(
                color: Color.fromARGB(255, 60, 58, 58),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Switch(
              value: value,
              onChanged: (bool newValue) {},
              activeColor: Colors.green,
            ),
          ),
        ),
      ],
    );
  }
}
