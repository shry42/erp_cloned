import 'package:get/get.dart';

class AssignItemGroupBasketController extends GetxController {
  var basketItems = <String>[].obs; // To store item groups

  // Add item to basket
  void addToBasket(String itemGroup) {
    if (!basketItems.contains(itemGroup)) {
      basketItems.add(itemGroup);
    }
  }

  // Remove item from basket
  void removeFromBasket(String itemGroup) {
    basketItems.remove(itemGroup);
  }

  // Clear the basket
  void resetBasket() {
    basketItems.clear();
  }
}
