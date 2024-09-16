import 'package:erp_copy/controllers/menu_controllers/delete_master_menu_controller.dart';
import 'package:erp_copy/screens/menu_screens/sub_menu_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:get/get.dart';

class UpdateMasterMenuScreen extends StatefulWidget {
  const UpdateMasterMenuScreen({
    super.key,
    required this.menuName,
    required this.menuIcon,
    required this.id,
  });

  final int id;
  final String menuName, menuIcon;

  @override
  State<UpdateMasterMenuScreen> createState() => _UpdateMasterMenuScreenState();
}

class _UpdateMasterMenuScreenState extends State<UpdateMasterMenuScreen> {
  TextEditingController searchController = TextEditingController();

  final advancedDrawerController = AdvancedDrawerController();

  final TextEditingController menuController = TextEditingController();
  String? menuIcon = "";

  final _formKey = GlobalKey<FormState>();
  final DeleteMasterMenuController dmmc =
      DeleteMasterMenuController(); //used for updating also just by changing isActive value

  @override
  void initState() {
    menuController.text = widget.menuName;
    menuIcon = widget.menuIcon;
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
    {'value': 'cibReadTheDocs', 'label': 'cibReadTheDocs'},
    {'value': 'cilCalendarCheck', 'label': 'cilCalendarCheck'},
    {'value': 'cibTodoist', 'label': 'cibTodoist'},
    {'value': 'cilSettings', 'label': 'cilSettings'},
    {'value': 'cilListRich', 'label': 'cilListRich'},
    {'value': 'cilListNumbered', 'label': 'cilListNumbered'}
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 68, 168, 71),
        automaticallyImplyLeading: true,
        actions: [
          const Text(
            'Update Master Menu',
            style: TextStyle(color: Colors.white, fontSize: 15),
          ),
          const SizedBox(width: 60),
          GestureDetector(
            child: Icon(Icons.subject),
            onTap: () {
              Get.to(MasterSubMenulistScreen(id: widget.id));
            },
          ),
          const SizedBox(width: 50),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                          value: menuIcon,
                          hint: const Text('Select an icon'),
                          items: iconNames.map((icon) {
                            return DropdownMenuItem<String>(
                              value: icon['label'],
                              child: Text(icon['label']!),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              menuIcon = newValue;
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
                        await dmmc.deleteMasterMenu(widget.id, 1,
                            menuIcon.toString(), menuController.text);
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
                      'Update',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            // FutureBuilder(
            //   future: gmmlc.getMasterMenuList(),
            //   builder: (BuildContext ctx, AsyncSnapshot snapshot) {
            //     if (snapshot.connectionState == ConnectionState.waiting) {
            //       return const Center(
            //         child: CircularProgressIndicator(),
            //       );
            //     } else if (snapshot.hasError) {
            //       return Center(
            //         child: Text('Error: ${snapshot.error}'),
            //       );
            //     } else {
            //       // Handle your snapshot data here
            //       return SizedBox(
            //         height: MediaQuery.of(context).size.height * 0.6,
            //         child: ListView.builder(
            //           shrinkWrap: true,
            //           itemCount: snapshot.data.length,
            //           itemBuilder: (context, index) {
            //             var masterMenuName = snapshot.data[index].menuName;
            //             var id = snapshot.data[index].id;
            //             return Padding(
            //               padding: const EdgeInsets.symmetric(
            //                   horizontal: 20, vertical: 10),
            //               child: Container(
            //                 decoration: BoxDecoration(
            //                     color: const Color.fromARGB(255, 68, 168, 71),
            //                     borderRadius: BorderRadius.circular(5)),
            //                 child: ListTile(
            //                   shape: RoundedRectangleBorder(
            //                     borderRadius: BorderRadius.circular(100),
            //                   ),
            //                   tileColor: Colors.transparent,
            //                   title: Text(
            //                     masterMenuName,
            //                     style: const TextStyle(color: Colors.white),
            //                   ),
            //                   trailing: GestureDetector(
            //                     onTap: () {
            //                       // ddc.deleteMyDepartment(department);
            //                       dmmc.deleteMasterMenu(
            //                         id,
            //                         0,
            //                         selectedLabel.toString(),
            //                         menuController.text,
            //                       );
            //                       setState(() {});
            //                     },
            //                     child: const Icon(
            //                       Icons.delete,
            //                       color: Colors.white,
            //                     ),
            //                   ),
            //                   // Add other department details here
            //                 ),
            //               ),
            //             );
            //           },
            //         ),
            //       );
            //     }
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
