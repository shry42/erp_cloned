import 'package:erp_copy/controllers/gis_controllers/basket/gis_basket_controller.dart';
import 'package:erp_copy/controllers/gis_controllers/submit_gis_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ViewBasketGISScreen extends StatelessWidget {
  final GISBasketController basketController = Get.find();
  final SubmitGisController submitController = Get.put(SubmitGisController());

  final String department;
  final String issuedTo;
  final String projectCode;
  final DateTime gisDate;
  final bool isWorkOrder;
  final int? workOrderId;

  ViewBasketGISScreen({
    required this.department,
    required this.issuedTo,
    required this.projectCode,
    required this.gisDate,
    required this.isWorkOrder,
    this.workOrderId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View Basket GIS'),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SingleChildScrollView(
                child: Obx(() => DataTable(
                      columns: const [
                        DataColumn(label: Text('SR NO.')),
                        DataColumn(label: Text('Venus-Id')),
                        DataColumn(label: Text('Item ID')),
                        DataColumn(label: Text('Internal Code')),
                        DataColumn(label: Text('Batch No.')),
                        DataColumn(label: Text('Serial No')),
                        DataColumn(label: Text('Req Quantity')),
                        DataColumn(label: Text('Issued Quantity')),
                        DataColumn(label: Text('Difference Qty')),
                        DataColumn(label: Text('Balance Qty')),
                        DataColumn(label: Text('UOM')),
                        DataColumn(label: Text('Remarks')),
                        DataColumn(label: Text('Remove')),
                      ],
                      rows: basketController.basketItems
                          .asMap()
                          .entries
                          .map((entry) {
                        int idx = entry.key;
                        var item = entry.value;
                        return DataRow(cells: [
                          DataCell(Text('${idx + 1}')),
                          DataCell(Text(item.venusId)),
                          DataCell(Text('${item.itemId}')),
                          DataCell(Text(item.internalCode)),
                          DataCell(Text(item.batchNo)),
                          DataCell(Text(item.serialNo)),
                          DataCell(Text('${item.reqQuantity}')),
                          DataCell(Text('${item.issuedQuantity}')),
                          DataCell(Text('${item.differenceQty}')),
                          DataCell(Text('${item.balanceQty}')),
                          DataCell(Text(item.uom)),
                          DataCell(Text(item.remarks)),
                          DataCell(ElevatedButton(
                            onPressed: () =>
                                basketController.removeFromBasket(idx),
                            child: Text('Remove'),
                          )),
                        ]);
                      }).toList(),
                    )),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _submitForApproval,
                  child: Text('Submit for Approval'),
                ),
                ElevatedButton(
                  onPressed: () {
                    basketController.resetBasket();
                    Get.snackbar('Success', 'Basket has been reset');
                  },
                  child: Text('Reset Basket'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _submitForApproval() {
    if (basketController.basketItems.isEmpty) {
      Get.snackbar('Error', 'Basket is empty. Add items before submitting.');
      return;
    }

    List<Map<String, dynamic>> gisTransactionDetails =
        basketController.basketItems
            .map((item) => {
                  "index": basketController.basketItems.indexOf(item) + 1,
                  "ItemID": item.itemId,
                  "VenusId": item.venusId,
                  "BatchNo": item.batchNo,
                  "SerialNo": item.serialNo,
                  "ReqQty": item.reqQuantity.toString(),
                  "IssuedQty": item.issuedQuantity.toString(),
                  "DiffQty": item.differenceQty.toString(),
                  "BalanceQty": item.balanceQty.toString(),
                  "PurchaseUOM": item.uom,
                  "Remarks": item.remarks,
                  "IssueUOM":
                      item.uom, // Assuming IssueUOM is the same as PurchaseUOM
                  "InternalCode": item.internalCode
                })
            .toList();

    submitController
        .submitGIS(
            department: department,
            gisTransactionDetails: gisTransactionDetails,
            issuedTo: issuedTo,
            projectCode: projectCode,
            txnDate: gisDate.toIso8601String().split('T')[0],
            woTxnID: isWorkOrder ? (workOrderId ?? 0) : 0,
            type: "GIS")
        .then((_) {
      // If submission is successful, reset the basket
      basketController.resetBasket();
    });
  }
}
