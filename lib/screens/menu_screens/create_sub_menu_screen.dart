import 'package:erp_copy/controllers/menu_controllers/create_master_menu_controller.dart';
import 'package:erp_copy/controllers/menu_controllers/get_master_menu_list_controller.dart';
import 'package:erp_copy/controllers/menu_controllers/get_sub_master_menu_id_list_controller.dart';
import 'package:erp_copy/controllers/menu_controllers/insert_sub_menu_controller.dart';
import 'package:erp_copy/controllers/menu_controllers/update_sub_menu_controller.dart';
import 'package:erp_copy/screens/menu_screens/update_sub_menu_screen.dart';
import 'package:erp_copy/widget/menu_widget/drawer_menu_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:get/get.dart';

class CreateSubMenuScreen extends StatefulWidget {
  const CreateSubMenuScreen({
    super.key,
    required this.openDrawer,
  });
  final VoidCallback openDrawer;

  @override
  State<CreateSubMenuScreen> createState() => _CreateSubMenuScreenState();
}

class _CreateSubMenuScreenState extends State<CreateSubMenuScreen> {
  TextEditingController searchController = TextEditingController();

  final advancedDrawerController = AdvancedDrawerController();

  final TextEditingController menuController = TextEditingController();
  final TextEditingController urlController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final CreateMasterMenuController cmmc = CreateMasterMenuController();

  final InsertSubMenuController ismc = InsertSubMenuController();

  final GetMasterMenulistController gmmlc = GetMasterMenulistController();
  final GetSubMenuIdlistController gsmilc = GetSubMenuIdlistController();

  final UpdateSubMenuController usmc = UpdateSubMenuController();

  List<dynamic> masterMenuList = [];

  String? selectedLabel;
  String? selectedMasterMenu;

  int? id = 28;

  @override
  void initState() {
    super.initState();
    fetchMasterMenuList();
  }

  void fetchMasterMenuList() async {
    await gmmlc.getMasterMenuList();
    setState(() {
      masterMenuList = gmmlc.masterMenuList;
    });
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
                'Create Sub Menu',
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
              const SizedBox(width: 85),
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
                        hintText: "Search for sub menu screen",
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
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
                    child: DropdownButtonFormField<String>(
                      value: selectedMasterMenu,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Colors.grey),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 6, horizontal: 8),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        labelText: 'Master Name',
                      ),
                      items: masterMenuList.map((menu) {
                        return DropdownMenuItem<String>(
                          value: menu.menuName,
                          child: Text(menu.menuName),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedMasterMenu = newValue;
                          final selectedMasterMenuData =
                              masterMenuList.firstWhere(
                            (menu) => menu.menuName == newValue,
                          );
                          id = selectedMasterMenuData.id;
                          print("*****$id");
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please select master name";
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: TextFormField(
                      controller: menuController,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Colors.grey)),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 6, horizontal: 8),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        labelText: 'Menu Name',
                      ),
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter menu name";
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: TextFormField(
                      controller: urlController,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Colors.grey)),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 6, horizontal: 8),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        labelText: 'Url',
                      ),
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter Url";
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        await ismc.insertSubMenu(
                          id!.toInt(),
                          menuController.text,
                          urlController.text,
                        );
                      }
                      setState(() {});
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      minimumSize: const Size(120, 40),
                    ),
                    child: const Text(
                      'Create',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            FutureBuilder(
              future: gsmilc.getSubMenuIdList(),
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
                                  "Name : $subMenuName\nMasterMenu : $masterMenu",
                                  style: const TextStyle(color: Colors.white),
                                ),
                                trailing: GestureDetector(
                                  onTap: () {
                                    usmc.updateSubMenu(
                                        id,
                                        0,
                                        selectedLabel.toString(),
                                        menuController.text,
                                        urlController.text);
                                    setState(() {});
                                  },
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
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
