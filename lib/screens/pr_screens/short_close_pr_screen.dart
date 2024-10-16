import 'package:erp_copy/controllers/pr_controllers/update_short_close_pr_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

showShortCloseQuantityDialog({
  required String itemName,
  required String itemGroup,
  required int poQty,
  required int reqQty,
  required int itemNameId,
  required int prTxnId,
}) {
  final TextEditingController requiredQtyController = TextEditingController();

  Get.defaultDialog(
    title: 'Short Close Quantity',
    titleStyle: const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w500,
    ),
    contentPadding: const EdgeInsets.all(16),
    radius: 8,
    content: SizedBox(
      width: Get.width * 0.9, // Make dialog wider
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Item Name Section
          _buildLabel('Item Name'),
          _buildGreyContainer(itemName),
          const SizedBox(height: 16),

          // Item Group and PO Qty Row
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildLabel('Item Group'),
                    _buildGreyContainer(itemGroup),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildLabel('Po Qty'),
                    _buildGreyContainer(poQty.toString()),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Req Qty and Required Qty Input Row
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildLabel('Req Qty'),
                    _buildGreyContainer(reqQty.toString()),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildLabel('Required Qty'),
                    _buildInputField(requiredQtyController),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Submit Button
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: () => _handleSubmit(
                  requiredQtyController: requiredQtyController,
                  reqQty: reqQty,
                  itemNameId: itemNameId,
                  PRTxnID: prTxnId),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 38, 112, 35),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Submit',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    ),
    barrierDismissible: true,
  );
}

Widget _buildLabel(String text) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Text(
      text,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: Colors.black87,
      ),
    ),
  );
}

Widget _buildGreyContainer(String text) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
    decoration: BoxDecoration(
      color: const Color(0xFFEEEEEE),
      borderRadius: BorderRadius.circular(4),
    ),
    child: Text(
      text,
      style: const TextStyle(
        fontSize: 14,
        color: Colors.black87,
      ),
    ),
  );
}

Widget _buildInputField(TextEditingController controller) {
  return TextField(
    controller: controller,
    keyboardType: TextInputType.number,
    decoration: InputDecoration(
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: const BorderSide(color: Colors.grey),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: const BorderSide(color: Colors.grey),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: const BorderSide(color: Color(0xFF3F51B5)),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
    ),
  );
}

void _handleSubmit({
  required TextEditingController requiredQtyController,
  required int reqQty,
  required int PRTxnID,
  required int itemNameId,
}) {
  final UpdateShortClosePrController uscprc =
      Get.put(UpdateShortClosePrController());
  // Validate input
  final requiredQty = int.tryParse(requiredQtyController.text);
  if (requiredQty == null) {
    Get.snackbar(
      'Error',
      'Please enter a valid quantity',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red[100],
      colorText: Colors.red[900],
    );
    return;
  }
  if (requiredQty > reqQty) {
    Get.snackbar(
      'Error',
      'Required quantity cannot be greater than request quantity',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red[100],
      colorText: Colors.red[900],
    );
    return;
  } else {
    uscprc.shortClosePR(PRTxnID, itemNameId, requiredQty.toString(), 'goods');
  }
  // // Return the required quantity and close dialog
  // Get.back(result: requiredQty);
}
