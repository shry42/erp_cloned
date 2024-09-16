import 'package:erp_copy/controllers/assign_item_groups_controller.dart/get_assign_items_user_list_controller.dart';
import 'package:erp_copy/widget/menu_widget/drawer_menu_widget.dart';
import 'package:erp_copy/widgets/Tables/item_group_table.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';

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
                // ElevatedButton(
                //     onPressed: () {
                //       showCreateItemGroupDialog(context);
                //     },
                //     style: ElevatedButton.styleFrom(
                //       backgroundColor: Colors.white,
                //       shape: RoundedRectangleBorder(
                //         borderRadius: BorderRadius.circular(12),
                //       ),
                //       minimumSize: const Size(120, 40),
                //     ),
                //     child: const Text(
                //       'Add item',
                //       style: TextStyle(color: Colors.black),
                //     )),
              ],
            ),
            const SizedBox(height: 6),
            // Form(
            //   key: _formKey,
            //   child: Column(
            //     children: [
            //       Padding(
            //         padding:
            //             const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
            //         child: TextFormField(
            //           controller: deliveryTermsController,
            //           decoration: InputDecoration(
            //             focusedBorder: OutlineInputBorder(
            //                 borderRadius: BorderRadius.circular(12),
            //                 borderSide: const BorderSide(color: Colors.grey)),
            //             contentPadding: const EdgeInsets.symmetric(
            //                 vertical: 6, horizontal: 8),
            //             border: OutlineInputBorder(
            //               borderRadius: BorderRadius.circular(12),
            //             ),
            //             labelText: 'Delivery term',
            //           ),
            //           style: const TextStyle(
            //             color: Colors.black,
            //           ),
            //           validator: (value) {
            //             if (value!.isEmpty) {
            //               return "Please enter delivery term";
            //             }
            //             return null;
            //           },
            //         ),
            //       ),
            //       const SizedBox(height: 20),
            //       ElevatedButton(
            //         onPressed: () async {
            //           // if (_formKey.currentState!.validate()) {
            //           //   await cdtc
            //           //       .createDeliveryTerms(deliveryTermsController.text);
            //           // }
            //           // setState(() {});
            //           showCreateItemGroupDialog(context);
            //         },
            //         style: ElevatedButton.styleFrom(
            //           backgroundColor: Colors.white,
            //           shape: RoundedRectangleBorder(
            //             borderRadius: BorderRadius.circular(12),
            //           ),
            //           minimumSize: const Size(120, 40),
            //         ),
            //         child: const Text(
            //           'Add',
            //           style: TextStyle(color: Colors.black),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
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
                          child: ItemGroupTable(
                            // ht: 250,
                            // wd: 400,
                            duration: 200,
                            name: snapshot.data[index].username,
                            // type: snapshot.data[index].itemType,
                            // prefix: snapshot.data[index].toString(),
                            // suffix: snapshot.data[index].toString(),
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
