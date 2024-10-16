// lib/screens/assign_menu_screen.dart

import 'package:erp_copy/controllers/menu_controllers/basket/menu_basket_controller.dart';
import 'package:erp_copy/controllers/menu_controllers/get_master_menu_list_controller.dart';
import 'package:erp_copy/controllers/menu_controllers/get_master_sub_menu_list_controller.dart';
import 'package:erp_copy/controllers/menu_controllers/get_users_menu_list_controller.dart';
import 'package:erp_copy/screens/menu_screens/baseket/view_menu_basket_screen.dart';
import 'package:erp_copy/widget/menu_widget/drawer_menu_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Import other necessary controllers and widgets

class AssignMenuScreen extends StatefulWidget {
  const AssignMenuScreen({
    super.key,
    required this.openDrawer,
  });
  final VoidCallback openDrawer;

  @override
  State<AssignMenuScreen> createState() => _AssignMenuScreenState();
}

class _AssignMenuScreenState extends State<AssignMenuScreen> {
  String? selectedUsername;
  String? selectedMasterMenu;
  int? selectedMenuId;
  int? selectedSubMenuId;
  int? selectedUserId;
  final MenuBasketController basketController = Get.put(MenuBasketController());
  final GetUserMenuListController gumlc = Get.put(GetUserMenuListController());
  final GetMasterMenulistController gmmlc =
      Get.put(GetMasterMenulistController());
  final GetMasterSubMenulistController gmsmlc =
      Get.put(GetMasterSubMenulistController());

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    await gumlc.getUserMenuList();
    await gmmlc.getMasterMenuList();
  }

  void _addToBasket() {
    if (_formKey.currentState!.validate()) {
      final selectedSubMenu = gmsmlc.subMenusList
          .firstWhere((menu) => menu.id == selectedSubMenuId);

      basketController.addToBasket(
        userId: selectedUserId!.toInt(),
        masterMenuName: selectedMasterMenu!,
        subMenuName: selectedSubMenu.subMenuName,
        menuId: selectedMenuId!.toInt(),
        subMenuId: selectedSubMenuId!.toInt(),
      );

      // Clear selections after adding to basket
      setState(() {
        selectedSubMenuId = null;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Added to basket successfully')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 68, 168, 71),
        automaticallyImplyLeading: true,
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text(
                'Assign Menu',
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
              const SizedBox(width: 20),
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => ViewBasketDialog(
                      userid: selectedUserId,
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: const BorderSide(color: Colors.grey),
                  ),
                ),
                child: const Text(
                  'View basket',
                  style: TextStyle(fontSize: 12, color: Colors.black),
                ),
              ),
              DrawerMenuWidget(onClicked: widget.openDrawer),
              const SizedBox(width: 20),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Username Dropdown
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 16),
                child: Obx(() {
                  return DropdownButtonFormField<String>(
                    value: selectedUsername,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 6,
                        horizontal: 8,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      labelText: 'User Name',
                      labelStyle: const TextStyle(color: Colors.black),
                    ),
                    items: gumlc.userMenusList.map((user) {
                      return DropdownMenuItem<String>(
                        value: user.username,
                        child: Text(user.username.toString()),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      final selectedUserDetails = gumlc.userMenusList
                          .firstWhere((menu) => menu.username == newValue);

                      setState(() {
                        selectedUserId = selectedUserDetails.userID;

                        selectedUsername = newValue;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please select a User name";
                      }
                      return null;
                    },
                  );
                }),
              ),

              // Master Menu Dropdown
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
                child: Obx(() {
                  return DropdownButtonFormField<String>(
                    value: selectedMasterMenu,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 6,
                        horizontal: 8,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      labelText: 'Master Menu',
                      labelStyle: const TextStyle(color: Colors.black),
                    ),
                    items: gmmlc.masterMenusList.map((menu) {
                      return DropdownMenuItem<String>(
                        value: menu.menuName,
                        child: Text(menu.menuName.toString()),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        gmsmlc.subMenusList.clear();
                        selectedSubMenuId = null;
                        selectedMasterMenu = newValue;
                        final selectedMenu = gmmlc.masterMenusList
                            .firstWhere((menu) => menu.menuName == newValue);
                        selectedMenuId = selectedMenu.id;
                        gmsmlc.getMasterSubMenuList(selectedMenu.id);
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please select a Master menu";
                      }
                      return null;
                    },
                  );
                }),
              ),

              // Sub Menu Dropdown
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
                child: Obx(() {
                  return DropdownButtonFormField<int>(
                    value: selectedSubMenuId,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 6,
                        horizontal: 8,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      labelText: 'Sub Menu',
                      labelStyle: const TextStyle(color: Colors.black),
                    ),
                    items: gmsmlc.subMenusList.map((menu) {
                      return DropdownMenuItem<int>(
                        value: menu.id,
                        child: Text("${menu.subMenuName} (${menu.id})"),
                      );
                    }).toList(),
                    onChanged: (int? newValue) {
                      setState(() {
                        selectedSubMenuId = newValue;
                      });
                    },
                    validator: (value) {
                      if (value == null) {
                        return "Please select a Sub menu";
                      }
                      return null;
                    },
                  );
                }),
              ),

              const SizedBox(height: 20),

              // Add to Basket Button
              ElevatedButton(
                onPressed: _addToBasket,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: const BorderSide(color: Colors.grey),
                  ),
                ),
                child: const Text(
                  'Add to basket',
                  style: TextStyle(fontSize: 12, color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
