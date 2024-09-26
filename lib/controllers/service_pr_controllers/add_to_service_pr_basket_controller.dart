import 'package:erp_copy/model/service_pr_models/service_pr_basket_model.dart';
import 'package:get/get.dart';

class ServicePRBasketController extends GetxController {
  var basketItems = <ServicePRBasket>[].obs;

  void addItemToBasket(ServicePRBasket item) {
    basketItems.add(item);
  }

  void removeItemFromBasket(int index) {
    basketItems.removeAt(index);
  }

  void resetBasket() {
    basketItems.clear();
  }
}
