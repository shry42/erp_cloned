import 'package:erp_copy/controllers/po_controllers/insert_po_controller.dart';
import 'package:erp_copy/models/po_models/po_basket_item_model.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';

class POBasketController extends GetxController {
  var basketItems = <POBasketItem>[].obs;
  final InsertNewPOController inpoc = Get.put(InsertNewPOController());

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
  Future<void> submitPOBasket({
    required String poDate,
    required String pRTxnID,
    required String vendorId,
    required String quoteDate,
    required String rev_NO,
    required String buyerName,
    required String buyerEmailID,
    required String buyerTel,
    required String buyerMob,
    required String supplierPOCName,
    required String supplierPOCEmailID,
    required String supplierPOCTel,
    required String supplierPOCMob,
    required String deliveryTerms,
    required String paymentTerms,
    required String headerNote,
    required String approvalStatus,
    required String revisionNumber,
    PlatformFile? filePath,
  }) async {
    try {
      // Convert basketItems to the required format for productArr
      List<Map<String, dynamic>> productArr = basketItems
          .map((item) => {
                "ItemID": item.itemId,
                "SAPID": item.venusId,
                "ItemName": item.itemName,
                "Item Group": item.itemGroup,
                "HSN Code": item.hsnCode,
                "PurchaseUOM": item.uom,
                "POQty": item.poQuantity,
                "DeliveryDate": item.deliveryDate,
                "UnitPrice": item.unitPrice,
                "TaxCode": item.taxCode,
                "TaxPercent": item.taxRate,
                "LineTotal": item.lineTotal,
                "TaxAmt": item.taxAmount,
                "FinalAmt": item.finalAmount,
              })
          .toList();

      await inpoc.insertPO(
        PODate: poDate,
        pRTxnID: pRTxnID,
        vendorId: vendorId,
        quoteDate: quoteDate,
        rev_NO: rev_NO,
        buyerName: buyerName,
        buyerEmailID: buyerEmailID,
        buyerTel: buyerTel,
        buyerMob: buyerMob,
        supplierPOCName: supplierPOCName,
        supplierPOCEmailID: supplierPOCEmailID,
        supplierPOCTel: supplierPOCTel,
        supplierPOCMob: supplierPOCMob,
        deliveryTerms: deliveryTerms,
        paymentTerms: paymentTerms,
        headerNote: headerNote,
        approvalStatus: approvalStatus,
        revisionNumber: revisionNumber,
        productArr: productArr,
        filePath: filePath,
      );

      // Clear the basket after successful submission
      resetBasket();

      // Show a success message
      Get.snackbar('Success', 'PO submitted successfully');
    } catch (e) {
      // Handle any errors
      Get.snackbar('Error', 'Failed to submit PO: $e');
    }
  }
}
