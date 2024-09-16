import 'package:erp_copy/model/pr_models_new/view_basket_model.dart';
import 'package:get/get.dart';

class BasketController extends GetxController {
  var basketItems = <BasketItem>[].obs;

  void addItemToBasket(BasketItem item) {
    basketItems.add(item);
  }

  void removeItemFromBasket(int index) {
    basketItems.removeAt(index);
  }

  void resetBasket() {
    basketItems.clear();
  }
}
