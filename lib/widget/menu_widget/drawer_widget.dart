import 'package:erp_copy/controllers/app_controller.dart';
import 'package:erp_copy/model/drawer_item.dart';
import 'package:erp_copy/widget/menu_widget/drawer_items.dart';
import 'package:erp_copy/screens/loginscreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({super.key, required this.onSelectedItem});
  final ValueChanged<DrawerItem> onSelectedItem;

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  // Separate boolean variables to track each expansion state
  bool isPurchaseRequestsExpanded = false;
  bool isItemMasterExpanded = false;
  bool isVendorMasterExpanded = false;
  bool isMenuExpanded = false;
  bool isEmployeeExpanded = false;
  bool isUserExpanded = false;
  bool isOtherExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Static Portion
        Padding(
          padding: const EdgeInsets.only(right: 350, bottom: 40),
          child: GestureDetector(
            onTap: () {
              // Trigger the onSelectedItem callback with a special item
              widget.onSelectedItem(DrawerItems.closeDrawer);
            },
            child: const Icon(
              Icons.close,
              size: 40,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 230, bottom: 50),
          child: Image.asset(
            'assets/images/gegadyne_log.png',
            height: 30,
          ),
        ),
        const SizedBox(height: 10),

        // Scrollable Portion
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                buildDrawerItems(context),

                // Purchase Requests Section
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 200),
                  child: Theme(
                    data: Theme.of(context)
                        .copyWith(dividerColor: Colors.transparent),
                    child: ExpansionTile(
                      leading: const Icon(
                        Icons.edit_document,
                        color: Colors.white,
                      ),
                      title: const Text('Purchase Requests'),
                      trailing: Icon(
                        isPurchaseRequestsExpanded
                            ? Icons.arrow_drop_up
                            : Icons.arrow_drop_down,
                      ),
                      onExpansionChanged: (bool expanded) {
                        setState(() => isPurchaseRequestsExpanded = expanded);
                      },
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40),
                          child: Column(
                            children: [
                              ListTile(
                                // leading: const Icon(
                                //   Icons.menu,
                                //   color: Colors.white,
                                // ),
                                title: const Text('Create Purchase request'),
                                onTap: () {
                                  widget.onSelectedItem(
                                      DrawerItems.createPurchaseRequest);
                                },
                              ),
                              ListTile(
                                // leading: const Icon(
                                //   Icons.menu,
                                //   color: Colors.white,
                                // ),
                                title: const Text('Purchase request list'),
                                onTap: () {
                                  widget.onSelectedItem(
                                      DrawerItems.purchaseRequestList);
                                },
                              ),
                              ListTile(
                                // leading: const Icon(
                                //   Icons.menu,
                                //   color: Colors.white,
                                // ),
                                title: const Text('All/pending PRs'),
                                onTap: () {
                                  widget.onSelectedItem(
                                      DrawerItems.purchaseRequest);
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Purchase Order Section
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 200),
                  child: Theme(
                    data: Theme.of(context)
                        .copyWith(dividerColor: Colors.transparent),
                    child: ExpansionTile(
                      leading: const Icon(
                        Icons.shopping_cart_rounded,
                        color: Colors.white,
                      ),
                      title: const Text('Purchase Orders'),
                      trailing: Icon(
                        isPurchaseRequestsExpanded
                            ? Icons.arrow_drop_up
                            : Icons.arrow_drop_down,
                      ),
                      onExpansionChanged: (bool expanded) {
                        setState(() => isPurchaseRequestsExpanded = expanded);
                      },
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40),
                          child: Column(
                            children: [
                              ListTile(
                                // leading: const Icon(
                                //   Icons.menu,
                                //   color: Colors.white,
                                // ),
                                title: const Text('Create Purchase order'),
                                onTap: () {
                                  widget.onSelectedItem(
                                      DrawerItems.createPurchaseOrder);
                                },
                              ),
                              ListTile(
                                // leading: const Icon(
                                //   Icons.menu,
                                //   color: Colors.white,
                                // ),
                                title: const Text('Purchase order list'),
                                onTap: () {
                                  widget.onSelectedItem(
                                      DrawerItems.purchaseOrderList);
                                },
                              ),
                              ListTile(
                                // leading: const Icon(
                                //   Icons.menu,
                                //   color: Colors.white,
                                // ),
                                title: const Text('All/pending POs'),
                                onTap: () {
                                  widget.onSelectedItem(
                                      DrawerItems.allPurchaseOrderList);
                                },
                              ),
                              ListTile(
                                // leading: const Icon(
                                //   Icons.menu,
                                //   color: Colors.white,
                                // ),
                                title: const Text('Generate POs'),
                                onTap: () {
                                  widget.onSelectedItem(
                                      DrawerItems.generatePurchaseOrder);
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

//GRN

                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 200),
                  child: Theme(
                    data: Theme.of(context)
                        .copyWith(dividerColor: Colors.transparent),
                    child: ExpansionTile(
                      leading: const Icon(
                        Icons.gradient_rounded,
                        color: Colors.white,
                      ),
                      title: const Text('GRN'),
                      trailing: Icon(
                        isMenuExpanded
                            ? Icons.arrow_drop_up
                            : Icons.arrow_drop_down,
                      ),
                      onExpansionChanged: (bool expanded) {
                        setState(() => isMenuExpanded = expanded);
                      },
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40),
                          child: Column(
                            children: [
                              ListTile(
                                // leading: const Icon(
                                //   Icons.menu,
                                //   color: Colors.white,
                                // ),
                                title: const Text('create GRN'),
                                onTap: () {
                                  widget.onSelectedItem(DrawerItems.createGRN);
                                },
                              ),
                              ListTile(
                                // leading: const Icon(
                                //   Icons.menu,
                                //   color: Colors.white,
                                // ),
                                title: const Text('create service GRN'),
                                onTap: () {
                                  widget.onSelectedItem(
                                      DrawerItems.createServiceGRN);
                                },
                              ),
                              ListTile(
                                // leading: const Icon(
                                //   Icons.menu,
                                //   color: Colors.white,
                                // ),
                                title: const Text('grn acceptance'),
                                onTap: () {
                                  widget.onSelectedItem(
                                      DrawerItems.grnAcceptance);
                                },
                              ),
                              ListTile(
                                // leading: const Icon(
                                //   Icons.menu,
                                //   color: Colors.white,
                                // ),
                                title: const Text('grn Approval'),
                                onTap: () {
                                  widget
                                      .onSelectedItem(DrawerItems.grnApproval);
                                },
                              ),
                              ListTile(
                                // leading: const Icon(
                                //   Icons.menu,
                                //   color: Colors.white,
                                // ),
                                title: const Text('grn list'),
                                onTap: () {
                                  widget.onSelectedItem(DrawerItems.grnList);
                                },
                              ),
                              ListTile(
                                // leading: const Icon(
                                //   Icons.menu,
                                //   color: Colors.white,
                                // ),
                                title: const Text('grn rejected items'),
                                onTap: () {
                                  widget.onSelectedItem(
                                      DrawerItems.grnRejectedItems);
                                },
                              ),
                              ListTile(
                                // leading: const Icon(
                                //   Icons.menu,
                                //   color: Colors.white,
                                // ),
                                title: const Text('grn rejected list'),
                                onTap: () {
                                  widget.onSelectedItem(
                                      DrawerItems.grenRejectedList);
                                },
                              ),
                              ListTile(
                                // leading: const Icon(
                                //   Icons.menu,
                                //   color: Colors.white,
                                // ),
                                title: const Text('srn acceptance'),
                                onTap: () {
                                  widget.onSelectedItem(
                                      DrawerItems.srnAcceptance);
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                //
                //STOCK POSTING

                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 200),
                  child: Theme(
                    data: Theme.of(context)
                        .copyWith(dividerColor: Colors.transparent),
                    child: ExpansionTile(
                      leading: const Icon(
                        Icons.travel_explore,
                        color: Colors.white,
                      ),
                      title: const Text('Stock Posting'),
                      trailing: Icon(
                        isMenuExpanded
                            ? Icons.arrow_drop_up
                            : Icons.arrow_drop_down,
                      ),
                      onExpansionChanged: (bool expanded) {
                        setState(() => isMenuExpanded = expanded);
                      },
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40),
                          child: Column(
                            children: [
                              ListTile(
                                // leading: const Icon(
                                //   Icons.menu,
                                //   color: Colors.white,
                                // ),
                                title: const Text('stock posting'),
                                onTap: () {
                                  widget
                                      .onSelectedItem(DrawerItems.stockposting);
                                },
                              ),
                              ListTile(
                                // leading: const Icon(
                                //   Icons.menu,
                                //   color: Colors.white,
                                // ),
                                title: const Text('stock movement'),
                                onTap: () {
                                  widget.onSelectedItem(
                                      DrawerItems.stockMovement);
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                //

                //GIS

                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 200),
                  child: Theme(
                    data: Theme.of(context)
                        .copyWith(dividerColor: Colors.transparent),
                    child: ExpansionTile(
                      leading: const Icon(
                        Icons.discord_sharp,
                        color: Colors.white,
                      ),
                      title: const Text('GIS'),
                      trailing: Icon(
                        isMenuExpanded
                            ? Icons.arrow_drop_up
                            : Icons.arrow_drop_down,
                      ),
                      onExpansionChanged: (bool expanded) {
                        setState(() => isMenuExpanded = expanded);
                      },
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40),
                          child: Column(
                            children: [
                              ListTile(
                                // leading: const Icon(
                                //   Icons.menu,
                                //   color: Colors.white,
                                // ),
                                title: const Text('create GIS'),
                                onTap: () {
                                  widget.onSelectedItem(DrawerItems.CcreateGIS);
                                },
                              ),
                              ListTile(
                                // leading: const Icon(
                                //   Icons.menu,
                                //   color: Colors.white,
                                // ),
                                title: const Text('GIS Approval'),
                                onTap: () {
                                  widget
                                      .onSelectedItem(DrawerItems.gisApproval);
                                },
                              ),
                              ListTile(
                                // leading: const Icon(
                                //   Icons.menu,
                                //   color: Colors.white,
                                // ),
                                title: const Text('GIS Status list'),
                                onTap: () {
                                  widget.onSelectedItem(
                                      DrawerItems.gisStatusList);
                                },
                              ),
                              ListTile(
                                // leading: const Icon(
                                //   Icons.menu,
                                //   color: Colors.white,
                                // ),
                                title: const Text('My GIS '),
                                onTap: () {
                                  widget.onSelectedItem(
                                      DrawerItems.myGisApproval);
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                //

//

                // Item Master Section
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 200),
                  child: Theme(
                    data: Theme.of(context)
                        .copyWith(dividerColor: Colors.transparent),
                    child: ExpansionTile(
                      leading: const Icon(
                        Icons.list,
                        color: Colors.white,
                      ),
                      title: const Text('Item Master'),
                      trailing: Icon(
                        isItemMasterExpanded
                            ? Icons.arrow_drop_up
                            : Icons.arrow_drop_down,
                      ),
                      onExpansionChanged: (bool expanded) {
                        setState(() => isItemMasterExpanded = expanded);
                      },
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40),
                          child: Column(
                            children: [
                              ListTile(
                                title: const Text('Add item'),
                                onTap: () {
                                  widget.onSelectedItem(DrawerItems.addItem);
                                },
                              ),
                              ListTile(
                                title: const Text('Item master list'),
                                onTap: () {
                                  widget.onSelectedItem(
                                      DrawerItems.itemMasterList);
                                },
                              ),
                              ListTile(
                                title: const Text('block/unblock item list'),
                                onTap: () {
                                  widget.onSelectedItem(
                                      DrawerItems.blockUnblockItemsList);
                                },
                              ),
                              ListTile(
                                title: const Text('block/unblock Log list'),
                                onTap: () {
                                  widget.onSelectedItem(
                                      DrawerItems.blockUnblockLogList);
                                },
                              ),
                              ListTile(
                                title: const Text('block Item list'),
                                onTap: () {
                                  widget.onSelectedItem(
                                      DrawerItems.blockItemsList);
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Vendor Master Section
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 200),
                  child: Theme(
                    data: Theme.of(context)
                        .copyWith(dividerColor: Colors.transparent),
                    child: ExpansionTile(
                      leading: const Icon(
                        Icons.shopping_basket,
                        color: Colors.white,
                      ),
                      title: const Text('Vendor Master'),
                      trailing: Icon(
                        isVendorMasterExpanded
                            ? Icons.arrow_drop_up
                            : Icons.arrow_drop_down,
                      ),
                      onExpansionChanged: (bool expanded) {
                        setState(() => isVendorMasterExpanded = expanded);
                      },
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40),
                          child: Column(
                            children: [
                              ListTile(
                                title: const Text('Add vendor'),
                                onTap: () {
                                  widget.onSelectedItem(DrawerItems.addVendor);
                                },
                              ),
                              ListTile(
                                title: const Text('Vendor master list'),
                                onTap: () {
                                  widget.onSelectedItem(
                                      DrawerItems.vendorMasterListScreen);
                                },
                              ),
                              ListTile(
                                title: const Text('Pending Vendor List'),
                                onTap: () {
                                  widget.onSelectedItem(
                                      DrawerItems.pendingVendor);
                                },
                              ),
                              ListTile(
                                title: const Text('block/unblock vendor'),
                                onTap: () {
                                  widget.onSelectedItem(
                                      DrawerItems.blockUnblockVendor);
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Menu Section
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 200),
                  child: Theme(
                    data: Theme.of(context)
                        .copyWith(dividerColor: Colors.transparent),
                    child: ExpansionTile(
                      leading: const Icon(
                        Icons.home,
                        color: Colors.white,
                      ),
                      title: const Text('Menu'),
                      trailing: Icon(
                        isMenuExpanded
                            ? Icons.arrow_drop_up
                            : Icons.arrow_drop_down,
                      ),
                      onExpansionChanged: (bool expanded) {
                        setState(() => isMenuExpanded = expanded);
                      },
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            children: [
                              ListTile(
                                // leading: const Icon(
                                //   Icons.menu,
                                //   color: Colors.white,
                                // ),
                                title: const Text('Create master menu'),
                                onTap: () {
                                  widget.onSelectedItem(
                                      DrawerItems.createMasterMenu);
                                },
                              ),
                              ListTile(
                                // leading: const Icon(
                                //   Icons.menu,
                                //   color: Colors.white,
                                // ),
                                title: const Text('Create sub menu'),
                                onTap: () {
                                  widget.onSelectedItem(
                                      DrawerItems.createSubMenu);
                                },
                              ),
                              ListTile(
                                // leading: const Icon(
                                //   Icons.menu,
                                //   color: Colors.white,
                                // ),
                                title: const Text('User menu list'),
                                onTap: () {
                                  widget
                                      .onSelectedItem(DrawerItems.userMenuList);
                                },
                              ),
                              ListTile(
                                // leading: const Icon(
                                //   Icons.menu,
                                //   color: Colors.white,
                                // ),
                                title: const Text('Assign menu'),
                                onTap: () {
                                  widget.onSelectedItem(DrawerItems.assignMenu);
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

//Gate Entry

                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 200),
                  child: Theme(
                    data: Theme.of(context)
                        .copyWith(dividerColor: Colors.transparent),
                    child: ExpansionTile(
                      leading: const Icon(
                        Icons.telegram,
                        color: Colors.white,
                      ),
                      title: const Text('Gate Entry'),
                      trailing: Icon(
                        isMenuExpanded
                            ? Icons.arrow_drop_up
                            : Icons.arrow_drop_down,
                      ),
                      onExpansionChanged: (bool expanded) {
                        setState(() => isMenuExpanded = expanded);
                      },
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40),
                          child: Column(
                            children: [
                              ListTile(
                                // leading: const Icon(
                                //   Icons.menu,
                                //   color: Colors.white,
                                // ),
                                title: const Text('create gate entry'),
                                onTap: () {
                                  widget.onSelectedItem(
                                      DrawerItems.createGateEntry);
                                },
                              ),
                              ListTile(
                                // leading: const Icon(
                                //   Icons.menu,
                                //   color: Colors.white,
                                // ),
                                title: const Text('view gate entry'),
                                onTap: () {
                                  widget.onSelectedItem(
                                      DrawerItems.viewGateEntry);
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

//

                // Employee Section
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 200),
                  child: Theme(
                    data: Theme.of(context)
                        .copyWith(dividerColor: Colors.transparent),
                    child: ExpansionTile(
                      leading: const Icon(
                        Icons.people,
                        color: Colors.white,
                      ),
                      title: const Text('Employee'),
                      trailing: Icon(
                        isEmployeeExpanded
                            ? Icons.arrow_drop_up
                            : Icons.arrow_drop_down,
                      ),
                      onExpansionChanged: (bool expanded) {
                        setState(() => isEmployeeExpanded = expanded);
                      },
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40),
                          child: Column(
                            children: [
                              ListTile(
                                title: const Text('Employee Registration'),
                                onTap: () {
                                  widget.onSelectedItem(
                                      DrawerItems.registerEmployees);
                                },
                              ),
                              ListTile(
                                title: const Text('Employee List'),
                                onTap: () {
                                  widget.onSelectedItem(
                                      DrawerItems.employeesList);
                                },
                              ),
                              ListTile(
                                title: const Text('Delete Employee'),
                                onTap: () {
                                  widget.onSelectedItem(
                                      DrawerItems.createDeliverTerms);
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // User Section
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 200),
                  child: Theme(
                    data: Theme.of(context)
                        .copyWith(dividerColor: Colors.transparent),
                    child: ExpansionTile(
                      leading: const Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
                      title: const Text('User'),
                      trailing: Icon(
                        isUserExpanded
                            ? Icons.arrow_drop_up
                            : Icons.arrow_drop_down,
                      ),
                      onExpansionChanged: (bool expanded) {
                        setState(() => isUserExpanded = expanded);
                      },
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40),
                          child: Column(
                            children: [
                              ListTile(
                                title: const Text('User Registration'),
                                onTap: () {
                                  widget.onSelectedItem(
                                      DrawerItems.registerUsers);
                                },
                              ),
                              ListTile(
                                title: const Text('User List'),
                                onTap: () {
                                  widget.onSelectedItem(DrawerItems.userList);
                                },
                              ),
                              ListTile(
                                title: const Text('Delete Users'),
                                onTap: () {
                                  widget.onSelectedItem(
                                      DrawerItems.createDeliverTerms);
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Other Section
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 200),
                  child: Theme(
                    data: Theme.of(context)
                        .copyWith(dividerColor: Colors.transparent),
                    child: ExpansionTile(
                      leading: const Icon(
                        Icons.settings,
                        color: Colors.white,
                      ),
                      title: const Text('Other'),
                      trailing: Icon(
                        isOtherExpanded
                            ? Icons.arrow_drop_up
                            : Icons.arrow_drop_down,
                      ),
                      onExpansionChanged: (bool expanded) {
                        setState(() => isOtherExpanded = expanded);
                      },
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40),
                          child: Column(
                            children: [
                              ListTile(
                                title: const Text('Department'),
                                onTap: () {
                                  widget.onSelectedItem(DrawerItems.createDept);
                                },
                              ),
                              ListTile(
                                title: const Text('Payments terms'),
                                onTap: () {
                                  widget.onSelectedItem(
                                      DrawerItems.createPaymentTerms);
                                },
                              ),
                              ListTile(
                                title: const Text('Delivery Terms'),
                                onTap: () {
                                  widget.onSelectedItem(
                                      DrawerItems.createDeliverTerms);
                                },
                              ),
                              ListTile(
                                title: const Text('Item groups'),
                                onTap: () {
                                  widget.onSelectedItem(
                                      DrawerItems.createItemGroups);
                                },
                              ),
                              ListTile(
                                title: const Text('Assign item group'),
                                onTap: () {
                                  widget.onSelectedItem(
                                      DrawerItems.assignItemGroups);
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 30),
        // Logout Button (Static)
        Padding(
          padding: const EdgeInsets.only(right: 310, bottom: 40),
          child: GestureDetector(
            onTap: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.remove('token');
              AppController.setaccessToken(null);
              Get.offAll(LoginScreen());
            },
            child: const Row(
              children: [
                SizedBox(width: 25),
                Icon(
                  Icons.logout,
                  size: 30,
                ),
                SizedBox(width: 10),
                SizedBox(height: 40),
                Text(
                  'Log out',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget buildDrawerItems(BuildContext context) => Column(
      children: DrawerItems.all
          .map(
            (item) => Column(
              children: [
                ListTile(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                  leading: Icon(
                    item.icon,
                    color: Colors.white,
                  ),
                  title: Text(
                    item.title,
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                  onTap: () {
                    widget.onSelectedItem(item);
                  },
                ),
              ],
            ),
          )
          .toList());
}
