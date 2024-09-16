import 'package:erp_copy/controllers/block_unblock_vendor/block_unblock_item_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

BlockUnblockItemController buic = BlockUnblockItemController();
void showBlockItemDialog(int ItemId) {
  TextEditingController remarkController = TextEditingController();
  String status = "Blocked";

  Get.defaultDialog(
    title: 'Block Item',
    titleStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    content: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          TextFormField(
            controller: remarkController,
            decoration: const InputDecoration(
              hintText: 'Why do you want to block this Item?',
              border: OutlineInputBorder(),
            ),
            maxLines: 3,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              String remark = remarkController.text;
              if (remark.isNotEmpty) {
                // Handle the block Item logic here
                buic.blockUnblockItem(remarkController.text, status, ItemId);
                Get.back(); // Close the dialog
              } else {
                Get.snackbar(
                  'Error',
                  'Please provide a reason for blocking the Item.',
                  snackPosition: SnackPosition.BOTTOM,
                );
              }
            },
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5), // Circular radius of 5
              ),
              minimumSize: const Size(150, 50), // Custom size
              backgroundColor: Colors.red, // Button color
            ),
            child: const Text(
              'Block',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ),
        ],
      ),
    ),
  );
}
