import 'package:erp_copy/controllers/item_groups_controller.dart/basket_controller/asign_item_basket_controller.dart';
import 'package:erp_copy/controllers/item_groups_controller.dart/get_item_groups_controller.dart';
import 'package:erp_copy/controllers/item_groups_controller.dart/get_items_by_item_groupid_controller.dart';
import 'package:erp_copy/screens/other/basket/view_assign_itemgroup_basket_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AssignItemGroupInsideScreen extends StatefulWidget {
  const AssignItemGroupInsideScreen({super.key, required this.userId});
  final int userId;

  @override
  State<AssignItemGroupInsideScreen> createState() =>
      _AssignItemGroupInsideScreenState();
}

class _AssignItemGroupInsideScreenState
    extends State<AssignItemGroupInsideScreen> {
  final _formKey = GlobalKey<FormState>();
  dynamic _selectedItemGroup;

  final GetItemGroupsController gigc = Get.put(GetItemGroupsController());
  final GetItemsbyItemGroupidController getItemsByItemGroupController =
      Get.put(GetItemsbyItemGroupidController());

  @override
  void initState() {
    super.initState();
    gigc.getItemsGroups(); // Fetch item groups when the screen loads
  }

  void _addToBasket() {
    if (_formKey.currentState!.validate()) {
      AssignItemGroupBasketController basketController =
          Get.put(AssignItemGroupBasketController());
      if (_selectedItemGroup != null) {
        basketController.addToBasket(_selectedItemGroup);
        Get.snackbar('Success', 'Item group added to the basket');
      }
    }
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
                'Assign item group',
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
              const SizedBox(width: 75),
              ElevatedButton(
                onPressed: () {
                  Get.to(() => ViewAssignItemGroupBasketScreen(
                        userId: widget.userId,
                      ));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: const BorderSide(color: Colors.grey),
                  ),
                ),
                child: const Text(
                  'View basket',
                  style: TextStyle(fontSize: 12, color: Colors.black),
                ),
              ),
              const SizedBox(width: 10),
            ],
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(() {
                if (gigc.itemGroupsList.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                }
                return DropdownButtonFormField(
                  value: _selectedItemGroup,
                  decoration: InputDecoration(
                    labelText: 'Select Item Group',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  ),
                  items: gigc.itemGroupsList
                      .map((ig) => DropdownMenuItem(
                            value: ig.itemGroups,
                            child: Text(
                              ig.itemGroups ?? '',
                              style: const TextStyle(color: Colors.black),
                            ),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedItemGroup = value;
                      // Fetch the items for the selected group
                      getItemsByItemGroupController
                          .getItemsbyItemGroupid(value.toString());
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Please select an item group';
                    }
                    return null;
                  },
                );
              }),
              const SizedBox(height: 16),

              // Container to display the list inside a bordered container
              Expanded(
                child: Obx(() {
                  if (getItemsByItemGroupController.itemGroupList.isEmpty) {
                    return const Center(
                      child: Text('No items found for the selected group'),
                    );
                  }
                  return Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: ListView.builder(
                      itemCount:
                          getItemsByItemGroupController.itemGroupList.length,
                      itemBuilder: (context, index) {
                        var item =
                            getItemsByItemGroupController.itemGroupList[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          elevation: 2,
                          child: ListTile(
                            title: Text(item.itemName ?? '',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold)),
                            subtitle: Text('ID: ${item.itemID.toString()}'),
                          ),
                        );
                      },
                    ),
                  );
                }),
              ),

              const SizedBox(height: 16),

              // Add to Basket Button
              Center(
                child: ElevatedButton(
                  onPressed: _addToBasket,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Add to Basket',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
