// lib/controllers/menu_controllers/basket/menu_basket_controller.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../insert_menu_mapping_controller.dart';

class BasketItem {
  final int srNo;
  final String masterMenuName;
  final String subMenuName;
  final int menuId; // Added to store menuId
  final int subMenuId; // Added to store subMenuId

  BasketItem({
    required this.srNo,
    required this.masterMenuName,
    required this.subMenuName,
    required this.menuId,
    required this.subMenuId,
  });
}

class MenuBasketController extends GetxController {
  RxList<BasketItem> basketItems = <BasketItem>[].obs;
  RxInt currentSrNo = 1.obs;
  final InsertMenuMappingController insertController =
      Get.put(InsertMenuMappingController());

  void addToBasket(
      {required String masterMenuName,
      required String subMenuName,
      required int menuId,
      required int subMenuId,
      required int userId}) {
    basketItems.add(BasketItem(
      srNo: currentSrNo.value,
      masterMenuName: masterMenuName,
      subMenuName: subMenuName,
      menuId: menuId,
      subMenuId: subMenuId,
    ));
    currentSrNo.value++;
  }

  void resetBasket() {
    basketItems.clear();
    currentSrNo.value = 1;
  }

  Future<void> submitBasket(int userid) async {
    if (basketItems.isEmpty) {
      Get.defaultDialog(
        title: "Error",
        middleText: "Basket is empty. Please add items before submitting.",
        textConfirm: "OK",
        confirmTextColor: Colors.white,
        onConfirm: () {
          Get.back();
        },
      );
      return;
    }

    try {
      // Convert basket items to menu mappings
      List<MenuMapping> menuMappings = basketItems
          .map((item) => MenuMapping(
                menuId: item.menuId,
                subMenuId: item.subMenuId,
              ))
          .toList();

      // Get the user ID from your app controller or wherever it's stored
      String userId = userid.toString(); // Replace with actual user ID

      // Submit the mappings
      await insertController.insertUserMenuMapping(userId, menuMappings);

      // Clear the basket after successful submission
      resetBasket();
    } catch (e) {
      Get.defaultDialog(
        title: "Error",
        middleText: "An error occurred while submitting the basket.",
        textConfirm: "OK",
        confirmTextColor: Colors.white,
        onConfirm: () {
          Get.back();
        },
      );
    }
  }
}
