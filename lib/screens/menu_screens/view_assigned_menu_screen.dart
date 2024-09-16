import 'package:erp_copy/controllers/menu_controllers/get_menu_by_userid_controller.dart';
import 'package:erp_copy/screens/menu_screens/update_sub_menu_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ViewAssignedMenuScreen extends StatefulWidget {
  const ViewAssignedMenuScreen({
    super.key,
    required this.id,
  });
  final int id;

  @override
  State<ViewAssignedMenuScreen> createState() => _ViewAssignedMenuScreenState();
}

class _ViewAssignedMenuScreenState extends State<ViewAssignedMenuScreen> {
  TextEditingController searchController = TextEditingController();

  final GetMenuByUserIdController gmbuic = GetMenuByUserIdController();

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
                'Assigned Menu list',
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
              const SizedBox(width: 120),
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
                      horizontal: 12.0, vertical: 20),
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
                        hintText: "Search for assigned menu",
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
              future: gmbuic.getmenuByuserId(widget.id),
              builder: (BuildContext ctx, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                } else if (snapshot.hasData) {
                  // Handle your snapshot data here
                  return SizedBox(
                    height: MediaQuery.of(context).size.height * 0.6,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        var subMenuName = snapshot.data[index].subMenuName;
                        var masterMenu = snapshot.data[index].menuName;
                        var url = snapshot.data[index].subMenuUrl;
                        var id = snapshot.data[index].id;
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: GestureDetector(
                            onTap: () {
                              Get.to(UpdateSubMenuScreen(
                                id: id,
                                name: subMenuName,
                                url: url,
                              ));
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
                                  "MasterMenu : $subMenuName\nSubMenu : $masterMenu",
                                  style: const TextStyle(color: Colors.white),
                                ),
                                trailing: GestureDetector(
                                  onTap: () {},
                                  child: const Icon(
                                    Icons.delete,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
