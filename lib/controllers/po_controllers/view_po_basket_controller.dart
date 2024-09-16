import 'package:erp_copy/models/po_models/po_basket_item_model.dart';
import 'package:get/get.dart';

class POBasketController extends GetxController {
  var basketItems = <POBasketItem>[].obs;

  // Add an item to the PO basket
  void addItemToBasket(POBasketItem item) {
    basketItems.add(item);
  }

  // Remove an item from the PO basket at a specific index
  void removeItemFromBasket(int index) {
    if (index >= 0 && index < basketItems.length) {
      basketItems.removeAt(index);
    }
  }

  // Reset the PO basket by clearing all items
  void resetBasket() {
    basketItems.clear();
  }

  // Example method to simulate the submission of the PO basket items
  Future<void> submitPOBasket({required String poDate}) async {
    // Logic to submit the PO basket data to an API or service can go here
    // This is a placeholder method for demonstration purposes
    print('Submitting PO with ${basketItems.length} items on date: $poDate');

    // Simulate a delay to mimic an API call
    await Future.delayed(Duration(seconds: 2));

    // Clear the basket after submission
    resetBasket();

    // Show a success message
    Get.snackbar('Success', 'PO submitted successfully');
  }
}
