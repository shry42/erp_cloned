import 'dart:convert';
import 'package:erp_copy/controllers/item_groups_controller.dart/add_item_groupname_userid_controller.dart.dart';
import 'package:erp_copy/controllers/item_groups_controller.dart/basket_controller/asign_item_basket_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ViewAssignItemGroupBasketScreen extends StatelessWidget {
  ViewAssignItemGroupBasketScreen({super.key, required this.userId});

  final int userId;
  final AssignItemGroupBasketController basketController =
      Get.put(AssignItemGroupBasketController()); // Get the basket controller
  final AddItemGroupnameAndUseridController addItemGroupController =
      Get.put(AddItemGroupnameAndUseridController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 68, 168, 71),
        automaticallyImplyLeading: true,
        title: const Text(
          'View Basket',
          style: TextStyle(color: Colors.white, fontSize: 15),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: Obx(() {
                if (basketController.basketItems.isEmpty) {
                  return const Center(child: Text('Basket is empty'));
                }
                return ListView.builder(
                  itemCount: basketController.basketItems.length,
                  itemBuilder: (context, index) {
                    var itemGroup = basketController.basketItems[index];
                    return Card(
                      elevation: 3,
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: ListTile(
                        title: Text(itemGroup),
                        trailing: IconButton(
                          icon: const Icon(Icons.remove_circle_outline,
                              color: Colors.red),
                          onPressed: () {
                            basketController.removeFromBasket(itemGroup);
                          },
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
            // Submit and Reset buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    _handleSubmit(); // Call the submit method
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: const BorderSide(color: Colors.grey),
                    ),
                  ),
                  child: const Text(
                    'Submit',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    basketController.resetBasket();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: const BorderSide(color: Colors.grey),
                    ),
                  ),
                  child: const Text(
                    'Reset',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Method to handle the submission
  void _handleSubmit() {
    // Prepare the data to send to the controller
    String itemGroups = jsonEncode(basketController.basketItems
        .map((item) => {"ItemGroup": item})
        .toList());

    // Call the createItemGroups method in the controller
    addItemGroupController.createItemGroups(
        userId, basketController.basketItems.toList());
    basketController.basketItems.clear();
  }
}
