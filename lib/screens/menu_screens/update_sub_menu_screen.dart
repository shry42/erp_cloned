import 'package:erp_copy/controllers/menu_controllers/delete_master_menu_controller.dart';
import 'package:erp_copy/controllers/menu_controllers/update_sub_menu_controller.dart';
import 'package:flutter/material.dart';

class UpdateSubMenuScreen extends StatefulWidget {
  const UpdateSubMenuScreen({
    super.key,
    required this.id,
    required this.name,
    required this.url,
  });

  final int id;
  final String name, url;

  @override
  State<UpdateSubMenuScreen> createState() => _UpdateSubMenuScreenState();
}

class _UpdateSubMenuScreenState extends State<UpdateSubMenuScreen> {
  TextEditingController searchController = TextEditingController();

  final TextEditingController menuNameController = TextEditingController();
  final TextEditingController urlController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final DeleteMasterMenuController dmmc =
      DeleteMasterMenuController(); //used for updating also just by changing isActive value

  final UpdateSubMenuController usmc = UpdateSubMenuController();

  @override
  void initState() {
    menuNameController.text = widget.name;
    urlController.text = widget.url;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 68, 168, 71),
        automaticallyImplyLeading: true,
        actions: [
          Text(
            'Update Sub Menu',
            style: TextStyle(color: Colors.white, fontSize: 15),
          ),
          const SizedBox(width: 140),
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
                      controller: menuNameController,
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
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
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
                        if ('value'!.isEmpty) {
                          return "Please enter url";
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        usmc.updateSubMenu(widget.id, 1, '',
                            menuNameController.text, urlController.text);
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
