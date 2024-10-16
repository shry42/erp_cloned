import 'package:erp_copy/controllers/item_groups_controller.dart/get_item_group_by_user_controller.dart';
import 'package:erp_copy/controllers/item_groups_controller.dart/unassign_item_group_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ViewItemGroupScreen extends StatefulWidget {
  const ViewItemGroupScreen({
    super.key,
    required this.userId,
  });
  final int userId;

  @override
  State<ViewItemGroupScreen> createState() => _ViewItemGroupScreenState();
}

class _ViewItemGroupScreenState extends State<ViewItemGroupScreen> {
  final GetItemGroupByUserController _controller =
      Get.put(GetItemGroupByUserController());

  final UnassignItemGroupController uaigc =
      Get.put(UnassignItemGroupController());

  @override
  void initState() {
    super.initState();
    _controller
        .getItemsGroupsByuser(widget.userId); // Load item groups for the user
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('View Assigned Items'),
      ),
      body: Obx(() {
        if (_controller.itemGroupList.isEmpty) {
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
                    label: Text('Unassign',
                        style: TextStyle(fontWeight: FontWeight.bold))),
              ],
              rows: List<DataRow>.generate(
                _controller.itemGroupList.length,
                (index) {
                  final itemGroup = _controller.itemGroupList[index];
                  return DataRow(
                    cells: [
                      DataCell(Text('${index + 1}')),
                      DataCell(Text(itemGroup.itemGroup ?? 'N/A')),
                      DataCell(
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 222, 86, 76),
                          ),
                          onPressed: () async {
                            // // Unassign button action
                            // Get.snackbar("Action",
                            //     "Unassign for ${itemGroup.itemGroup}");
                            await uaigc.unassignItemGroup(
                                widget.userId, itemGroup.itemGroup);
                          },
                          child: const Text(
                            'Unassign',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
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
