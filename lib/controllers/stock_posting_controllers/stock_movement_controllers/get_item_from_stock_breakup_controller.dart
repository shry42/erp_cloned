import 'dart:convert';
import 'package:erp_copy/controllers/app_controller.dart';
import 'package:erp_copy/model/stock_posting/stock_movement/item_details_from_stock_brkp_model.dart';
import 'package:erp_copy/model/stock_posting/stock_movement/ps_stock_list_model.dart';
import 'package:erp_copy/model/stock_posting/stock_movement/rd_stock_list_model.dart';
import 'package:erp_copy/model/stock_posting/stock_movement/stock_breakup_list_model.dart';
import 'package:erp_copy/model/stock_posting/stock_movement/wh_stock_list_model.dart';
import 'package:erp_copy/screens/loginscreen.dart';
import 'package:erp_copy/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class GetItemFromStockBreakupController extends GetxController {
  var itemDetailsList = <ItemDetailsFromStockBrkpModel>[]
      .obs; // Updated list to store model objects
  var stockBreakUpList = <StockBreakupListModel>[].obs;
  var whStockList = <WHStockListModel>[].obs;

  var rdStockList = <RDStockListModel>[].obs;

  var psStockList = <PSStockListModel>[].obs;

  var isLoading = false.obs; // Loading state

  // Method to fetch "Entry By" users
  getItemstockBrkp(int itemId) async {
    isLoading(true); // Start loading
    try {
      http.Response response = await http.post(
        Uri.parse('${ApiService.base}/getItemFromStockBreakup'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${AppController.accessToken}',
        },
        body: jsonEncode({
          'itemId': itemId,
        }),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> result = json.decode(response.body);
        List<dynamic> itemDetails = result['itemDetails'];
        List<dynamic> stockBreakUp = result['stockBreakUp'];
        List<dynamic> WHStock = result['WHStocklist'];
        List<dynamic> RDStock = result['RDStockList'];
        List<dynamic> PSStock = result['PSStockList'];

        // Mapping response data to  list
        itemDetailsList.value = itemDetails
            .map((e) => ItemDetailsFromStockBrkpModel.fromJson(e))
            .toList();

        stockBreakUpList.value =
            stockBreakUp.map((e) => StockBreakupListModel.fromJson(e)).toList();

        whStockList.value =
            WHStock.map((e) => WHStockListModel.fromJson(e)).toList();

        rdStockList.value =
            RDStock.map((e) => RDStockListModel.fromJson(e)).toList();

        psStockList.value =
            PSStock.map((e) => PSStockListModel.fromJson(e)).toList();
      } else {
        handleErrorResponse(response);
      }
    } catch (e) {
      print('Exception: ${e.toString()}'); // Print the exception details
      Get.snackbar('Error', 'Failed to fetch Entry By users. ${e.toString()}');
    } finally {
      isLoading(false); // Stop loading
    }
  }

  // Handle error responses (e.g., validation, unauthorized)
  void handleErrorResponse(http.Response response) {
    Map<String, dynamic> result = json.decode(response.body);
    String title = result['title'];
    String message = result['message'];

    if (title == 'Validation Failed') {
      Get.defaultDialog(
        title: "Error",
        middleText: message,
        textConfirm: "OK",
        confirmTextColor: Colors.white,
        onConfirm: () {
          Get.back(); // Close the dialog
        },
      );
    } else if (title == 'Unauthorized') {
      Get.defaultDialog(
        title: "Error",
        middleText: "$message \nPlease re-login",
        textConfirm: "OK",
        confirmTextColor: Colors.white,
        onConfirm: () {
          Get.offAll(LoginScreen()); // Redirect to login
        },
      );
    }
  }
}
