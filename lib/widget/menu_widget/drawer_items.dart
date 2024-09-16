import 'package:erp_copy/model/drawer_item.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DrawerItems {
  static const purchaseOrder =
      DrawerItem(title: 'Purchase Order', icon: FontAwesomeIcons.cartShopping);

  static const purchaseRequest =
      DrawerItem(title: 'Purchase Request', icon: FontAwesomeIcons.receipt);
//
  static const createPurchaseRequest = DrawerItem(
      title: 'Create Purchase Request', icon: FontAwesomeIcons.receipt);

  static const purchaseRequestList =
      DrawerItem(title: 'purchaseRequestList', icon: FontAwesomeIcons.receipt);

  static const allPurchaseRequestList = DrawerItem(
      title: 'allPurchaseRequestList', icon: FontAwesomeIcons.receipt);

//

  static const createPurchaseOrder = DrawerItem(
      title: 'Create Purchase Order', icon: FontAwesomeIcons.receipt);

  static const purchaseOrderList =
      DrawerItem(title: 'purchaseOrderList', icon: FontAwesomeIcons.receipt);

  static const allPurchaseOrderList =
      DrawerItem(title: 'allPurchaseOrderList', icon: FontAwesomeIcons.receipt);

//
//
  static const createDept =
      DrawerItem(title: 'Create department', icon: Icons.assignment);

  static const createPaymentTerms =
      DrawerItem(title: 'createPaymentTerms', icon: Icons.payment);

  static const createDeliverTerms =
      DrawerItem(title: 'createDeliveryTerms', icon: Icons.delivery_dining);

  static const createItemGroups =
      DrawerItem(title: 'createItemGroups', icon: Icons.group);

  static const assignItemGroups =
      DrawerItem(title: 'assignItemGroups', icon: Icons.group);

  //
  static const registerEmployees =
      DrawerItem(title: 'registerEmployees', icon: Icons.people);

  static const employeesList =
      DrawerItem(title: 'employeesList', icon: Icons.people);

  static const deleteEmployees =
      DrawerItem(title: 'deleteEmployees', icon: Icons.people);

//
//
  static const registerUsers =
      DrawerItem(title: 'registerUsers', icon: Icons.people);

  static const userList = DrawerItem(title: 'userList', icon: Icons.people);

  static const deleteUsers =
      DrawerItem(title: 'deleteUsers', icon: Icons.people);
//

//

  static const addItem = DrawerItem(title: 'Add item', icon: Icons.collections);

  static const itemMasterList =
      DrawerItem(title: 'ItemMasterList', icon: Icons.collections);

  static const blockUnblockItemsList =
      DrawerItem(title: 'itemMaster', icon: Icons.collections);

  static const blockUnblockLogList =
      DrawerItem(title: 'itemBlock/Unblock Logs', icon: Icons.collections);

//

  static const addVendor = DrawerItem(title: 'add vendor', icon: Icons.shop);

  static const pendingVendor =
      DrawerItem(title: 'pending vendor', icon: Icons.shop);

  static const blockUnblockVendor =
      DrawerItem(title: 'block/unblock vendor', icon: Icons.shop);

  static const blockItemsList =
      DrawerItem(title: 'blockItemList', icon: Icons.collections);

//
//
  static const createMasterMenu = DrawerItem(
      title: 'createMasterMenu', icon: FontAwesomeIcons.cartShopping);

  static const vendorMasterListScreen = DrawerItem(
      title: 'Vendor master list', icon: FontAwesomeIcons.cartShopping);

//
  static const createSubMenu =
      DrawerItem(title: 'createSubMenu', icon: Icons.assignment);

  static const userMenuList =
      DrawerItem(title: 'userMenuList', icon: Icons.delivery_dining);

  static const assignMenu = DrawerItem(title: 'assignMenu', icon: Icons.group);

  // Special item to indicate closing the drawer
  static const closeDrawer =
      DrawerItem(title: 'Close Drawer', icon: Icons.close);

  static final List<DrawerItem> all = [
    purchaseOrder,
    purchaseRequest,
    // logout,
  ];
}
