import 'package:erp_copy/model/drawer_item.dart';
import 'package:erp_copy/widget/menu_widget/drawer_items.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class NavigationController extends GetxController {
  final Rx<DrawerItem> currentItem = DrawerItems.purchaseOrder.obs;
  final RxBool isDrawerOpen = false.obs;

  void navigateToScreen(DrawerItem item) {
    currentItem.value = item;
  }

  void directNavigateToScreen(DrawerItem item, {bool closeDrawer = true}) {
    refresh();
    currentItem.value = item;
    update();
    if (closeDrawer) {
      isDrawerOpen.value = false;
    }
  }
}
