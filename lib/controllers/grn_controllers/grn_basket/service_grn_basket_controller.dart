import 'package:erp_copy/controllers/grn_controllers/submit_grn/submit_service_grn_controller.dart';
import 'package:erp_copy/model/grn_models/get_service_po_items.dart';
import 'package:erp_copy/model/grn_models/service_grn_basket_item_model.dart';
import 'package:erp_copy/model/grn_models/submit_grn/service_grn_transac_model.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';

class ServiceGRNBasketController extends GetxController {
  RxList<ServiceGRNBasketItem> serviceBasketItems =
      <ServiceGRNBasketItem>[].obs;

  void addPOItemToBasket(GetServicePOItemsModel poItem) {
    ServiceGRNBasketItem grnItem = ServiceGRNBasketItem(
      srNo: '1', // Assuming '1' as a placeholder value
      poTxnId: poItem.poTxnID.toString(),
      serviceId: poItem.serviceId.toString(),
      serviceName: poItem.serviceName.toString(),
      serviceGroup: poItem.serviceGroup.toString(),
      batchNumber: '', // Default value for batch number
      serialNumber: '', // Default value for serial number
      poQuantity: poItem.poQty.toString(),
      unitPrice: poItem.unitPrice.toString(),
      receivedQuantity: '', // Default value for received quantity
      receivedRate: '', // Default value for received rate
      gateEntryId: '', // Default value for gate entry ID
      purchaseUOM: poItem.purchaseUOM.toString(),
      totalReceivedQuantity: poItem.totalReceivedQty.toString(),
      remainingQuantity: poItem.remainingQty.toString(),
    );
    serviceBasketItems.add(grnItem);
  }

  void addItemToBasket(ServiceGRNBasketItem item) {
    serviceBasketItems.add(item);
  }

  void removeItemFromBasket(int index) {
    if (index >= 0 && index < serviceBasketItems.length) {
      serviceBasketItems.removeAt(index);
    }
  }

  void resetBasket() {
    serviceBasketItems.clear();
  }

  void updateBatchNumber(int index, String batchNumber) {
    if (index >= 0 && index < serviceBasketItems.length) {
      serviceBasketItems[index] =
          serviceBasketItems[index].copyWith(batchNumber: batchNumber);
    }
  }

  void updateSerialNumber(int index, String serialNumber) {
    if (index >= 0 && index < serviceBasketItems.length) {
      serviceBasketItems[index] =
          serviceBasketItems[index].copyWith(serialNumber: serialNumber);
    }
  }

  void updateReceivedQuantity(int index, String quantity) {
    if (index >= 0 && index < serviceBasketItems.length) {
      serviceBasketItems[index] =
          serviceBasketItems[index].copyWith(receivedQuantity: quantity);
    }
  }

  void updateReceivedRate(int index, String rate) {
    if (index >= 0 && index < serviceBasketItems.length) {
      double? parsedRate = double.tryParse(rate);
      if (parsedRate != null) {
        serviceBasketItems[index] =
            serviceBasketItems[index].copyWith(receivedRate: rate);
      }
    }
  }

  void updateGateEntryId(int index, String gateEntryId) {
    if (index >= 0 && index < serviceBasketItems.length) {
      serviceBasketItems[index] =
          serviceBasketItems[index].copyWith(gateEntryId: gateEntryId);
    }
  }

  Future<void> submitServiceGRNBasket({
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
    final List<ServiceGRNTransactionDetailsModel> transactionDetails =
        serviceBasketItems.map((item) {
      return ServiceGRNTransactionDetailsModel(
        srNo: item.srNo.toString(),
        poTxnId: item.poTxnId.toString(),
        serviceId: item.serviceId.toString(),
        serviceName: item.serviceName.toString(),
        serviceGroup: item.serviceGroup.toString(),
        batchNumber: item.batchNumber.toString(),
        serialNumber: item.serialNumber.toString(),
        poQuantity: item.poQuantity.toString(),
        poRate: item.receivedRate.toString(),
        receivedQuantity: item.receivedQuantity.toString(),
        receivedRate: item.receivedRate.toString(),
        gateEntryId: item.gateEntryId.toString(),
        purchaseUOM: item.purchaseUOM.toString(),
        totalReceivedQuantity: item.totalReceivedQuantity.toString(),
        remainingQuantity: item.remainingQuantity.toString(),
      );
    }).toList();

    // Get instance of InsertGRNTransactionController
    final insertController = Get.put(InsertServiceGRNTransactionController());

    try {
      // Call the insertGRNTransaction method
      await insertController.insertServiceGRNTransaction(
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
