import 'package:erp_copy/controllers/pr_controllers/pr_details_controller.dart';
import 'package:erp_copy/screens/pr_screens/short_close_pr_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ViewPrDetailsScreen extends StatefulWidget {
  const ViewPrDetailsScreen({
    super.key,
    required this.prTxnId,
  });

  final int prTxnId;

  @override
  State<ViewPrDetailsScreen> createState() => _ViewPrDetailsScreenState();
}

class _ViewPrDetailsScreenState extends State<ViewPrDetailsScreen> {
  final PrDetailsController _controller = Get.put(PrDetailsController());

  @override
  void initState() {
    super.initState();
    _controller.getPrDetails(widget.prTxnId.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('View PR Details'),
      ),
      body: Obx(() {
        if (_controller.prDetails.isEmpty) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: const [
                DataColumn(
                    label: Text('SR NO.',
                        style: TextStyle(fontWeight: FontWeight.bold))),
                DataColumn(
                    label: Text('Item Group',
                        style: TextStyle(fontWeight: FontWeight.bold))),
                DataColumn(
                    label: Text('Venus ID',
                        style: TextStyle(fontWeight: FontWeight.bold))),
                DataColumn(
                    label: Text('Internal Code',
                        style: TextStyle(fontWeight: FontWeight.bold))),
                DataColumn(
                    label: Text('Open Qty',
                        style: TextStyle(fontWeight: FontWeight.bold))),
                DataColumn(
                    label: Text('Request Qty',
                        style: TextStyle(fontWeight: FontWeight.bold))),
                DataColumn(
                    label: Text('Purchase UOM',
                        style: TextStyle(fontWeight: FontWeight.bold))),
                DataColumn(
                    label: Text('Remarks',
                        style: TextStyle(fontWeight: FontWeight.bold))),
                DataColumn(
                    label: Text('Short Close',
                        style: TextStyle(fontWeight: FontWeight.bold))),
              ],
              rows: List<DataRow>.generate(
                _controller.prDetails.length,
                (index) {
                  final prDetail = _controller.prDetailBySel[index];
                  return DataRow(
                    cells: [
                      DataCell(Text('${index + 1}')),
                      DataCell(Text(prDetail.itemGroup ?? 'N/A')),
                      DataCell(Text(prDetail.sapId ?? 'N/A')),
                      DataCell(Text(prDetail.internalCode ?? 'N/A')),
                      DataCell(Text(prDetail.openQty.toString())),
                      DataCell(Text(prDetail.reqQty.toString())),
                      DataCell(Text(prDetail.purchaseUOM ?? 'N/A')),
                      DataCell(Text(prDetail.remarks?.toString() ?? 'N/A')),
                      DataCell(ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 222, 86, 76),
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                        ),
                        onPressed: () async {
                          try {
                            showShortCloseQuantityDialog(
                              prTxnId: widget.prTxnId,
                              itemNameId: int.parse(prDetail.itemId.toString()),
                              itemName: prDetail.internalCode ?? '',
                              itemGroup: prDetail.itemGroup ?? '',
                              poQty: prDetail.poQty?.toInt() ?? 0,
                              reqQty: prDetail.reqQty?.toInt() ?? 0,
                            );
                          } catch (e) {
                            Get.snackbar(
                              "Error",
                              "An unexpected error occurred: ${e.toString()}",
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: Colors.red[100],
                              colorText: Colors.red[900],
                            );
                          }
                        },
                        child: const Text(
                          'Short Close',
                          style: TextStyle(color: Colors.white),
                        ),
                      )),
                    ],
                  );
                },
              ),
            ),
          ),
        );
      }),
    );
  }
}
