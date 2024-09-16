import 'package:erp_copy/controllers/menu_controllers/create_master_menu_controller.dart';
import 'package:erp_copy/controllers/menu_controllers/delete_master_menu_controller.dart';
import 'package:erp_copy/controllers/menu_controllers/get_master_menu_list_controller.dart';
import 'package:erp_copy/screens/menu_screens/update_master_menu_screen.dart';
import 'package:erp_copy/widget/menu_widget/drawer_menu_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:get/get.dart';

class CreateMasterMenuScreen extends StatefulWidget {
  const CreateMasterMenuScreen({
    super.key,
    required this.openDrawer,
  });
  final VoidCallback openDrawer;

  @override
  State<CreateMasterMenuScreen> createState() => _CreateMasterMenuScreenState();
}

class _CreateMasterMenuScreenState extends State<CreateMasterMenuScreen> {
  TextEditingController searchController = TextEditingController();

  final advancedDrawerController = AdvancedDrawerController();

  final TextEditingController menuController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final CreateMasterMenuController cmmc = CreateMasterMenuController();
  final GetMasterMenulistController gmmlc = GetMasterMenulistController();
  final DeleteMasterMenuController dmmc = DeleteMasterMenuController();

  @override
  void initState() {
    super.initState();
  }

  final List<Map<String, String>> iconNames = [
    {'value': '0', 'label': 'Select an icon'},
    {'value': 'cilCursor', 'label': 'cilCursor'},
    {'value': 'cil-list', 'label': 'cil-list'},
    {'value': 'cil-pencil', 'label': 'cil-pencil'},
    {'value': 'cil-user', 'label': 'cil-user'},
    {'value': 'cilUserFollow', 'label': 'cilUserFollow'},
    {'value': 'cilGroup', 'label': 'cilGroup'},
    {'value': 'cil-pen', 'label': 'cil-pen'},
    {'value': 'cilPlaylistAdd', 'label': 'cilPlaylistAdd'},
    {'value': 'cilLibraryAdd', 'label': 'cilLibraryAdd'},
    {'value': 'cil-calendar', 'label': 'cil-calendar'},
    {'value': 'cilContact', 'label': 'cilContact'},
    {'value': 'cilHome', 'label': 'cilHome'},
    {'value': 'cibTodoist', 'label': 'cibTodoist'},
    {'value': 'cilNoteAdd', 'label': 'cilNoteAdd'},
    {'value': 'cibTodoist', 'label': 'cibTodoist'},
    {'value': 'cibReadTheDocs', 'label': 'cibReadTheDocs'},
    {'value': 'cilCalendarCheck', 'label': 'cilCalendarCheck'},
    {'value': 'cibTodoist', 'label': 'cibTodoist'},
    {'value': 'cilSettings', 'label': 'cilSettings'},
    {'value': 'cilListRich', 'label': 'cilListRich'},
    {'value': 'cilListNumbered', 'label': 'cilListNumbered'}
  ];

  String? selectedLabel;

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
                'Create Master Menu',
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
                        hintText: "Search for master menu",
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
                        if ('value'!.isEmpty) {
                          return "Please enter menu name";
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: InputDecorator(
                      decoration: InputDecoration(
                        labelText: 'Select an icon',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 12),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: selectedLabel,
                          hint: const Text('Select an icon'),
                          items: iconNames.map((icon) {
                            return DropdownMenuItem<String>(
                              value: icon['label'],
                              child: Text(icon['label']!),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedLabel = newValue;
                            });
                          },
                          isExpanded: true,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        // await cdc.createDepartment(deptNameController.text);
                        await cmmc.createMasterMenu(
                            selectedLabel.toString(), menuController.text);
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
              future: gmmlc.getMasterMenuList(),
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
                        var masterMenuName = snapshot.data[index].menuName;
                        var menuIcon = snapshot.data[index].menuIcon;
                        var id = snapshot.data[index].id;
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: GestureDetector(
                            onTap: () {
                              Get.to(UpdateMasterMenuScreen(
                                  menuName: masterMenuName,
                                  menuIcon: menuIcon,
                                  id: id));
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
                                  masterMenuName,
                                  style: const TextStyle(color: Colors.white),
                                ),
                                trailing: GestureDetector(
                                  onTap: () {
                                    // ddc.deleteMyDepartment(department);
                                    dmmc.deleteMasterMenu(
                                      id,
                                      0,
                                      selectedLabel.toString(),
                                      menuController.text,
                                    );
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
