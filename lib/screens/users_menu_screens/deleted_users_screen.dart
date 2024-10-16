import 'package:erp_copy/controllers/user_controllers/get_all_users_controller.dart';
import 'package:erp_copy/controllers/user_controllers/update_user_status_controller.dart';
import 'package:erp_copy/widget/menu_widget/drawer_menu_widget.dart';
import 'package:erp_copy/widgets/user_cards/deleted_users_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:get/get.dart';

class DeletedUsersList extends StatefulWidget {
  const DeletedUsersList({
    super.key,
    required this.openDrawer,
  });
  final VoidCallback openDrawer;

  @override
  State<DeletedUsersList> createState() => _DeletedUsersListState();
}

class _DeletedUsersListState extends State<DeletedUsersList> {
  TextEditingController searchController = TextEditingController();

  final advancedDrawerController = AdvancedDrawerController();

  final GetAllUsersController gauc = GetAllUsersController();

  final UpdateUserStatusController uusc = UpdateUserStatusController();

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
                'Deleted Users list',
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
                      horizontal: 15.0, vertical: 20),
                  child: SizedBox(
                    height: 35,
                    width: 400,
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
                        hintText: "Search for users list",
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
            FutureBuilder(
              future: gauc.getUsersList(),
              builder: (BuildContext ctx, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                } else if (snapshot.hasData && snapshot.data != null) {
                  // Wrap ListView.builder inside an Expanded widget
                  return SizedBox(
                    height: MediaQuery.of(context).size.height *
                        0.8, // Or any height you prefer
                    child: ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Get.defaultDialog(
                              middleText: 'Are you sure?',
                              cancel: ElevatedButton(
                                onPressed: () {
                                  // Handle "No" action here
                                  Get.back(); // Close the dialog
                                },
                                child: const Text('No'),
                              ),
                              confirm: ElevatedButton(
                                onPressed: () {
                                  uusc.updateUserStatus(
                                      snapshot.data[index].userID);
                                },
                                child: const Text('Yes'),
                              ),
                            );
                          },
                          child: DeletedUserCard(
                            ht: _height,
                            wd: _width,
                            duration: 1,
                            userName: snapshot.data[index].fullName,
                            emailId: snapshot.data[index].emailID,
                            role: snapshot.data[index].userRole,
                            department: snapshot.data[index].department,
                          ),
                        );
                      },
                    ),
                  );
                } else {
                  return const Center(
                    child: Text('No data found'),
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
