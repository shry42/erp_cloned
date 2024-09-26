import 'package:erp_copy/controllers/grn_controllers/submit_grn/submit_grn_controllers.dart';
import 'package:erp_copy/model/grn_models/get_po_items_model.dart';
import 'package:erp_copy/model/grn_models/grn_basket_item_model.dart';
import 'package:erp_copy/model/grn_models/submit_grn/grn_transac_model.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';

class GRNBasketController extends GetxController {
  RxList<GRNBasketItem> basketItems = <GRNBasketItem>[].obs;

  void addPOItemToBasket(GetPOItemsModel poItem) {
    GRNBasketItem grnItem = GRNBasketItem(
      srNo: '1',
      poTxnId: poItem.poTxnID.toString(),
      venusId: poItem.sapID,
      itemGroup: poItem.itemGroup,
      itemId: poItem.itemID.toString(),
      itemName: poItem.itemName,
      poQuantity: poItem.poQty,
      unitPrice: poItem.unitPrice,
      batchNumber: '',
      serialNumber: '',
      receivedQuantity: '', // default value
      receivedRate: '', // default value
      gateEntryId: '', // default value
      purchaseUOM: poItem.purchaseUOM,
      totalReceivedQuantity: poItem.totalReceivedQty.toString(),
      remainingQuantity: poItem.remainingQty.toString(),
      acceptedQuantity: poItem.acceptedQty.toString(),
    );
    basketItems.add(grnItem);
  }

  void addItemToBasket(GRNBasketItem item) {
    basketItems.add(item);
  }

  void removeItemFromBasket(int index) {
    if (index >= 0 && index < basketItems.length) {
      basketItems.removeAt(index);
    }
  }

  void resetBasket() {
    basketItems.clear();
  }

  void updateBatchNumber(int index, String batchNumber) {
    if (index >= 0 && index < basketItems.length) {
      basketItems[index] =
          basketItems[index].copyWith(batchNumber: batchNumber);
    }
  }

  void updateSerialNumber(int index, String serialNumber) {
    if (index >= 0 && index < basketItems.length) {
      basketItems[index] =
          basketItems[index].copyWith(serialNumber: serialNumber);
    }
  }

  void updateReceivedQuantity(int index, String quantity) {
    if (index >= 0 && index < basketItems.length) {
      basketItems[index] =
          basketItems[index].copyWith(receivedQuantity: quantity);
    }
  }

  void updateReceivedRate(int index, String rate) {
    if (index >= 0 && index < basketItems.length) {
      double? parsedRate = double.tryParse(rate);
      if (parsedRate != null) {
        basketItems[index] = basketItems[index].copyWith(receivedRate: rate);
      }
    }
  }

  void updateGateEntryId(int index, String gateEntryId) {
    if (index >= 0 && index < basketItems.length) {
      basketItems[index] =
          basketItems[index].copyWith(gateEntryId: gateEntryId);
    }
  }

  Future<void> submitGRNBasket({
    String? grnDate,
    String? grnNumber,
    String? invoiceNumber,
    String? invoiceDate,
    String? challanNumber,
    String? remark,
    required List<PlatformFile> files,
  }) async {
    // print('Submitting GRN with ${basketItems.length} items on date: $grnDate');

    // Convert basket items to GRNTransactionDetails model
    final List<GRNTransactionDetailsModel> transactionDetails =
        basketItems.map((item) {
      return GRNTransactionDetailsModel(
        srNo: item.srNo.toString(),
        poTxnID: item.poTxnId.toString(),
        sapID: item.venusId.toString(),
        itemGroup: item.itemGroup.toString(),
        itemID: item.itemId.toString(),
        itemName: item.itemName.toString(),
        batchNo: item.batchNumber,
        serialNo: item.serialNumber,
        poQty: item.poQuantity.toString(),
        poRate: item.unitPrice.toString(),
        receivedQty: item.receivedQuantity.toString(),
        receivedRate: item.receivedRate.toString(),
        purchaseUOM: item.purchaseUOM.toString(),
        gateEntryID: item.gateEntryId.toString(),
        // gateEntryID: "1359",
        totalReceivedQuantity: item.totalReceivedQuantity.toString(),
        remainingQuantity: item.remainingQuantity.toString(),
        acceptedQty: item.acceptedQuantity.toString(),
      );
    }).toList();

    // Get instance of InsertGRNTransactionController
    final insertController = Get.put(InsertGRNTransactionController());

    try {
      // Call the insertGRNTransaction method
      await insertController.insertGRNTransaction(
        transactionDate: grnDate.toString(),
        focSampleFlag: 0, // Set appropriate values or add additional parameters
        remarks: remark.toString(),
        invoiceNo: invoiceNumber.toString(),
        invoiceDate: invoiceDate.toString(),
        challanNo: challanNumber.toString(),
        transactionDetails: transactionDetails,
        filePath: files.isNotEmpty
            ? files.first
            : null, // Add file handling if necessary
      );

      // Reset the basket after successful submission
      resetBasket();
    } catch (e) {
      print('Error submitting GRN basket: $e');
    }
  }
}
