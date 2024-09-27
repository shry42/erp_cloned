import 'package:erp_copy/controllers/service_po_controllers/insert_service_po_controller.dart';
import 'package:erp_copy/model/service_po_models/basket/service_po_basket_item_model.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';

class ServicePOBasketController extends GetxController {
  var serviceBasketItems = <ServicePOBasketItem>[].obs;
  final InsertNewServicePOController inpoc =
      Get.put(InsertNewServicePOController());

  // Add an item to the PO basket
  void addItemToBasket(ServicePOBasketItem item) {
    serviceBasketItems.add(item);
  }

  // Remove an item from the PO basket at a specific index
  void removeItemFromBasket(int index) {
    if (index >= 0 && index < serviceBasketItems.length) {
      serviceBasketItems.removeAt(index);
    }
  }

  // Reset the PO basket by clearing all items
  void resetBasket() {
    serviceBasketItems.clear();
  }

  // Example method to simulate the submission of the PO basket items
  Future<void> submitPOBasket({
    required String poDate,
    required String pRTxnID,
    required String vendorId,
    required String SupplierQuoteNo,
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
      // Convert serviceBasketItems to the required format for productArr
      List<Map<String, dynamic>> productArr = serviceBasketItems
          .map((item) => {
                "ServiceId": item.serviceID,
                "ServiceName": item.serviceName,
                "ServiceGroup": item.serviceGroup,
                "SAC_Code": item.sacCode,
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

      await inpoc.insertServicePO(
        PODate: poDate,
        pRTxnID: pRTxnID,
        vendorId: vendorId,
        SupplierQuoteNo: SupplierQuoteNo,
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
