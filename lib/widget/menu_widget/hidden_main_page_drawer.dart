import 'package:erp_copy/model/drawer_item.dart';
import 'package:erp_copy/screens/gate_entry/create_gate_entry_screen.dart';
import 'package:erp_copy/screens/gate_entry/view_gate_entry_screen.dart';
import 'package:erp_copy/screens/gis_screens/create_gis_screens.dart';
import 'package:erp_copy/screens/gis_screens/gis_approval_screen.dart';
import 'package:erp_copy/screens/gis_screens/gis_status_list_screen.dart';
import 'package:erp_copy/screens/gis_screens/my_gis_approval_screen.dart';
import 'package:erp_copy/screens/grn_screens/create_grn_screen.dart';
import 'package:erp_copy/screens/grn_screens/create_service_grn_screen.dart';
import 'package:erp_copy/screens/grn_screens/grn_acceptance_screen.dart';
import 'package:erp_copy/screens/grn_screens/grn_approval_screen.dart';
import 'package:erp_copy/screens/grn_screens/grn_list_screen.dart';
import 'package:erp_copy/screens/grn_screens/grn_rejected_items_screen.dart';
import 'package:erp_copy/screens/grn_screens/grn_rejected_list_screen.dart';
import 'package:erp_copy/screens/grn_screens/srn_acceptance_screen.dart';
import 'package:erp_copy/screens/item_master_screens/add_item_screen.dart';
import 'package:erp_copy/screens/item_master_screens/block_item_list_screen.dart';
import 'package:erp_copy/screens/item_master_screens/item_master_list_screen.dart';
import 'package:erp_copy/screens/po_screens/create_po_screen.dart';
import 'package:erp_copy/screens/po_screens/generate_po_screen.dart';
import 'package:erp_copy/screens/pr_screens/create_pr_screen.dart';
import 'package:erp_copy/screens/pr_screens/pr_lists_screen.dart';
import 'package:erp_copy/screens/sample_po/create_sample_goods_po_screen.dart';
import 'package:erp_copy/screens/sample_po/create_sample_service_po_screen.dart';
import 'package:erp_copy/screens/service_po/create_service_po_screen.dart';
import 'package:erp_copy/screens/service_pr_screens/create_service_pr_screen.dart';
import 'package:erp_copy/screens/stock_posting/stock_movement_screen.dart';
import 'package:erp_copy/screens/stock_posting/stock_posting_screen.dart';
import 'package:erp_copy/screens/vendor_master/add_vendor_master_screen.dart';
import 'package:erp_copy/screens/vendor_master/pending_vendors_screen_list.dart';
import 'package:erp_copy/screens/vendor_master/vendor_master_list_screen.dart';
import 'package:erp_copy/widget/menu_widget/drawer_items.dart';
import 'package:erp_copy/screens/assign_item_groups_screens/assign_item_group_list_screen.dart';
import 'package:erp_copy/screens/create_delivery_terms.dart';
import 'package:erp_copy/screens/create_department.dart';
import 'package:erp_copy/screens/create_item_groups.dart';
import 'package:erp_copy/screens/create_payment_terms.dart';
import 'package:erp_copy/screens/employe_screens/employees_list_screen.dart';
import 'package:erp_copy/screens/employe_screens/register_employees.dart';
import 'package:erp_copy/screens/item_master_screens/block_unblock_item_list_screen.dart';
import 'package:erp_copy/screens/item_master_screens/item_block_unblock_log_screen.dart';
import 'package:erp_copy/screens/menu_screens/create_master_menu_screen.dart';
import 'package:erp_copy/screens/menu_screens/create_sub_menu_screen.dart';
import 'package:erp_copy/screens/menu_screens/users_menu_list.dart';
import 'package:erp_copy/screens/po_screens/po_log_details.dart';
import 'package:erp_copy/screens/pr_screens/pr_log_details.dart';
import 'package:erp_copy/screens/users_menu_screens/register_users.dart';
import 'package:erp_copy/screens/users_menu_screens/user_list_screens.dart';
import 'package:erp_copy/screens/vendor_master/block_unblock_vendor_list_screen.dart';
import 'package:erp_copy/widget/menu_widget/drawer_widget.dart';
import 'package:flutter/material.dart';

class HiddenDrawer extends StatelessWidget {
  const HiddenDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      // theme: ThemeData(
      //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      //   useMaterial3: true,
      // ),
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.white,
        primaryColor: const Color.fromRGBO(21, 30, 61, 1),
      ),
      home: Mainpage(),
    );
  }
}

class Mainpage extends StatefulWidget {
  Mainpage({super.key});

  @override
  State<Mainpage> createState() => _MainpageState();
}

class _MainpageState extends State<Mainpage> {
  late double xOffset;
  late double yOffset;
  late double scaleFactor;
  DrawerItem item = DrawerItems.purchaseOrder;

  @override
  void initState() {
    super.initState();
    // opneDrawer();
    closeDrawer();
  }

  void opneDrawer() {
    setState(() {
      xOffset = 240;
      yOffset = 120;
      scaleFactor = 0.8;
    });
  }

  void closeDrawer() => setState(() {
        xOffset = 0;
        yOffset = 0;
        scaleFactor = 1;
      });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: LinearGradient(colors: colors),
      body: Stack(children: [
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              // begin: Alignment.topCenter,
              // end: Alignment.bottomRight,
              colors: [
                Colors.black,
                Color.fromARGB(31, 6, 6, 6),

                // Adjust this color to be the lighter color you want
              ],
            ),
          ),
        ),
        buildDrawer(),
        buildPage(),
      ]),
    );
  }

  Widget buildDrawer() => SafeArea(
        child: DrawerWidget(
          onSelectedItem: (item) {
            if (item == DrawerItems.closeDrawer) {
              closeDrawer(); // Close the drawer
            } else {
              setState(() {
                this.item = item;
                closeDrawer();
              });
            }
          },
        ),
      );
  Widget buildPage() {
    // final double xOffset = 230;
    // final double yOffset = 150;
    // final double scaleFactor = 0.6;
    return GestureDetector(
      onTap: closeDrawer,
      child: AnimatedContainer(
          duration: const Duration(milliseconds: 450),
          transform: Matrix4.translationValues(
            xOffset,
            yOffset,
            200,
          )..scale(scaleFactor),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Container(child: getDrawerPage()))),
    );
  }

  Widget getDrawerPage() {
    switch (item) {
      case DrawerItems.purchaseRequest:
        return PrLogDetailsScreen(openDrawer: opneDrawer);
      case DrawerItems.createDept:
        return CreateDepartments(
          openDrawer: opneDrawer,
        );
      case DrawerItems.createPaymentTerms:
        return CreatePaymentTermsScreen(
          openDrawer: opneDrawer,
        );
      case DrawerItems.createDeliverTerms:
        return CreateDeliveryTermsScreen(
          openDrawer: opneDrawer,
        );
      case DrawerItems.createItemGroups:
        return CreateItemGroupsScreen(
          openDrawer: opneDrawer,
        );
      case DrawerItems.assignItemGroups:
        return AssignItemGroupListScreen(
          openDrawer: opneDrawer,
        );

//Purchase requests

      case DrawerItems.createPurchaseRequest:
        return CreatePRScreen(openDrawer: opneDrawer);

      case DrawerItems.purchaseRequestList:
        return PRListsScreen(openDrawer: opneDrawer);

      case DrawerItems.allPurchaseRequestList:
        return AddItemScreen(openDrawer: opneDrawer);

//Purchase orders

      case DrawerItems.createPurchaseOrder:
        return CreatePOScreen(openDrawer: opneDrawer);

      case DrawerItems.purchaseOrderList:
        return PRListsScreen(openDrawer: opneDrawer);

      case DrawerItems.allPurchaseOrderList:
        return AddItemScreen(openDrawer: opneDrawer);

      case DrawerItems.generatePurchaseOrder:
        return GeneratePOScreen(openDrawer: opneDrawer);

//GRN

      case DrawerItems.createGRN:
        return CreateGRNScreen(openDrawer: opneDrawer);

      case DrawerItems.createServiceGRN:
        return CreateServiceGRNScreen(openDrawer: opneDrawer);

      case DrawerItems.grnAcceptance:
        return GRNAcceptanceScreen(openDrawer: opneDrawer);

      case DrawerItems.grnApproval:
        return GRNListApprovalScreen(openDrawer: opneDrawer);

      case DrawerItems.grnList:
        return GRNListScreen(openDrawer: opneDrawer);

      case DrawerItems.grnRejectedItems:
        return GRNRejectedItemsScreen(openDrawer: opneDrawer);

      case DrawerItems.grenRejectedList:
        return GRNRejectedListScreen(openDrawer: opneDrawer);

      case DrawerItems.srnAcceptance:
        return SRNAcceptanceScreen(openDrawer: opneDrawer);

//

//STOCK POSTING

      case DrawerItems.stockposting:
        return StockPostingScreen(openDrawer: opneDrawer);

      case DrawerItems.stockMovement:
        return StockMovementScreen(openDrawer: opneDrawer);

// GIS

      case DrawerItems.CcreateGIS:
        return CreateGISScreen(openDrawer: opneDrawer);

      case DrawerItems.gisApproval:
        return GISApprovalScreen(openDrawer: opneDrawer);

      case DrawerItems.gisStatusList:
        return GISStatusListcreen(openDrawer: opneDrawer);

      case DrawerItems.myGisApproval:
        return MyGISApprovalScreen(openDrawer: opneDrawer);

// Service PR
      case DrawerItems.createServicePR:
        return CreateServicePRScreen(openDrawer: opneDrawer);

// Service PO
      case DrawerItems.createServicePO:
        return CreateServicePOScreen(openDrawer: opneDrawer);

// Service PO
      case DrawerItems.createSampleGoodsPO:
        return CreateSampleGoodsPOScreen(openDrawer: opneDrawer);

      case DrawerItems.createSampleServicePO:
        return CreateSampleServicePOScreen(openDrawer: opneDrawer);

//item master

      case DrawerItems.addItem:
        return AddItemScreen(openDrawer: opneDrawer);

      case DrawerItems.itemMasterList:
        return ItemMasterListScreen(openDrawer: opneDrawer);

      case DrawerItems.blockUnblockItemsList:
        return BlockUnblockItemsListScreen(openDrawer: opneDrawer);

      case DrawerItems.blockUnblockLogList:
        return ItemBlockUnblockLogScreen(openDrawer: opneDrawer);

      case DrawerItems.blockItemsList:
        return BlockItemListScreen(openDrawer: opneDrawer);

//Gate Entry

      case DrawerItems.createGateEntry:
        return CreateGateEntryScreen(openDrawer: opneDrawer);

      case DrawerItems.viewGateEntry:
        return ViewGateEntryScreen(openDrawer: opneDrawer);
//

//vendor master

      case DrawerItems.addVendor:
        return AddVendorMasterScreen(openDrawer: opneDrawer);

      case DrawerItems.pendingVendor:
        return PendingVendorsScreenList(openDrawer: opneDrawer);

      case DrawerItems.blockUnblockVendor:
        return BlockUnblockVendorListScreen(openDrawer: opneDrawer);

      case DrawerItems.vendorMasterListScreen:
        return VendorMasterListScreen(openDrawer: opneDrawer);

      //
//Employees  menu
      //
      case DrawerItems.registerEmployees:
        return RegisterEmployeesScreen(
          openDrawer: opneDrawer,
        );
      case DrawerItems.employeesList:
        return EmployeesListsScreen(
          openDrawer: opneDrawer,
        );
      //

      //Users menu
      //
      case DrawerItems.registerUsers:
        return RegisterUsersScreen(
          openDrawer: opneDrawer,
        );
      case DrawerItems.userList:
        return UsersListScreens(
          openDrawer: opneDrawer,
        );

      case DrawerItems.deleteUsers:
        return EmployeesListsScreen(
          openDrawer: opneDrawer,
        );
      //

      case DrawerItems.createMasterMenu:
        return CreateMasterMenuScreen(
          openDrawer: opneDrawer,
        );

      case DrawerItems.createSubMenu:
        return CreateSubMenuScreen(
          openDrawer: opneDrawer,
        );

      case DrawerItems.userMenuList:
        return UsersMenuListScreen(
          openDrawer: opneDrawer,
        );
      case DrawerItems.assignMenu:
        return AssignItemGroupListScreen(
          openDrawer: opneDrawer,
        );
//

      case DrawerItems.purchaseOrder:
      default:
        return PoLogDetailsScreen(openDrawer: opneDrawer);
    }
  }
}
