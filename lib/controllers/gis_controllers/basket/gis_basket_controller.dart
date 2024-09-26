import 'package:erp_copy/model/gis_model/basket/gis_basket_item_model.dart';
import 'package:get/get.dart';

class GISBasketController extends GetxController {
  final RxList<GISBasketItem> basketItems = <GISBasketItem>[].obs;

  void addToBasket(GISBasketItem item) {
    basketItems.add(item);
  }

  void removeFromBasket(int index) {
    basketItems.removeAt(index);
  }

  void resetBasket() {
    basketItems.clear();
  }
}
