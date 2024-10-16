import 'package:erp_copy/controllers/user_controllers/get_all_users_controller.dart';
import 'package:erp_copy/controllers/user_controllers/update_user_status_controller.dart';
import 'package:erp_copy/widget/menu_widget/drawer_menu_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';

class UsersListScreens extends StatefulWidget {
  const UsersListScreens({
    super.key,
    required this.openDrawer,
  });
  final VoidCallback openDrawer;

  @override
  State<UsersListScreens> createState() => _UsersListScreensState();
}

class _UsersListScreensState extends State<UsersListScreens> {
  TextEditingController searchController = TextEditingController();

  final advancedDrawerController = AdvancedDrawerController();

  final GetAllUsersController gauc = GetAllUsersController();

  final UpdateUserStatusController uusc = UpdateUserStatusController();

  final TextEditingController deptNameController = TextEditingController();

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
                'Users list',
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
                } else {
                  // Handle your snapshot data here
                  return SizedBox(
                    height: MediaQuery.of(context).size.height * 0.8,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        var fullName = '${snapshot.data[index].fullName}';
                        var userId = snapshot.data[index].userID;
                        // var userId = snapshot.data[index].userID;
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: GestureDetector(
                            onTap: () {
                              // Get.to(ViewAssignedMenuScreen(id: userId));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: const Color.fromARGB(255, 68, 168, 71),
                                  borderRadius: BorderRadius.circular(5)),
                              child: ListTile(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                tileColor: Colors.transparent,
                                title: Text(
                                  fullName,
                                  style: const TextStyle(color: Colors.white),
                                ),
                                trailing: GestureDetector(
                                  onTap: () {
                                    uusc.updateUserStatus(userId);
                                    setState(() {});
                                  },
                                  child: const Icon(
                                    Icons.delete,
                                    color: Colors.white,
                                  ),
                                ),
                                // Add other department details here
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
