import 'package:erp_copy/controllers/assign_item_groups_controller.dart/get_assign_items_user_list_controller.dart';
import 'package:erp_copy/screens/other/assign_item_group_inside_screen.dart';
import 'package:erp_copy/screens/other/view_item_group_screen.dart';
import 'package:erp_copy/widget/menu_widget/drawer_menu_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:get/get.dart';

class AssignItemGroupListScreen extends StatefulWidget {
  const AssignItemGroupListScreen({
    super.key,
    required this.openDrawer,
  });
  final VoidCallback openDrawer;

  @override
  State<AssignItemGroupListScreen> createState() =>
      _AssignItemGroupListScreenState();
}

class _AssignItemGroupListScreenState extends State<AssignItemGroupListScreen> {
  TextEditingController searchController = TextEditingController();

  final advancedDrawerController = AdvancedDrawerController();

  final GetAssignItemsUserListController gaiulc =
      GetAssignItemsUserListController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.sizeOf(context).height * 0.18;
    double _width = MediaQuery.sizeOf(context).width * 0.90;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 68, 168, 71),
        automaticallyImplyLeading: true,
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text(
                'Assign Item Groups',
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
              const SizedBox(width: 95),
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 20),
                  child: SizedBox(
                    height: 35,
                    width: 390,
                    child: TextField(
                      controller: searchController,
                      decoration: InputDecoration(
                        focusColor: Colors.black,
                        filled: true,
                        fillColor: const Color(0xfff1f1f1),
                        border: OutlineInputBorder(
                          gapPadding: 20,
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            width: 1,
                            color: Colors.green,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Colors.grey)),
                        hintText: "Search for item groups",
                        hintStyle:
                            const TextStyle(fontSize: 12, color: Colors.grey),
                        suffixIcon: const Icon(Icons.search),
                        prefixIconColor: Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            const SizedBox(height: 10),
            FutureBuilder(
              future: gaiulc.getUserListOfAssignItems(),
              builder: (BuildContext ctx, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                } else {
                  // Handle your snapshot data here
                  return SizedBox(
                    height: MediaQuery.of(context).size.height * 0.75,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        // var terms = snapshot.data[index].terms;
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: GestureDetector(
                            onTap: () {
                              showItemGroupDialog(snapshot.data[index].userId);
                            },
                            child: Card(
                              color: const Color.fromARGB(255, 77, 131, 77),
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 18),
                              elevation: 8,
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 15, left: 18),
                                    child: Row(
                                      children: [
                                        Flexible(
                                          child: Text(
                                            'Name   :  ${snapshot.data[index].username}\n',
                                            style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

void showItemGroupDialog(int userId) {
  Get.defaultDialog(
    title: "Item Group",
    titleStyle: const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
    content: const Column(
      children: [
        Text(
          "Please choose one of the options below:",
          style: TextStyle(fontSize: 16, color: Colors.black54),
        ),
        SizedBox(height: 20),
      ],
    ),
    radius: 10, // Rounded corners for the dialog

    backgroundColor: Colors.white,
    actions: [
      ElevatedButton(
        onPressed: () {
          // Action for "View Item Group"
          // Get.back(); // Close the dialog
          Get.to(ViewItemGroupScreen(
            userId: userId,
          ));
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.grey,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        ),
        child: const Text(
          "View Item Group",
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
      ),
      ElevatedButton(
        onPressed: () {
          // Action for "Assign Item Group"
          // Get.back(); // Close the dialog
          Get.to(AssignItemGroupInsideScreen(
            userId: userId,
          ));
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        ),
        child: const Text(
          "Assign Item Group",
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
      ),
    ],
  );
}
