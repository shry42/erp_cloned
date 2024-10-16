import 'dart:io';
import 'package:erp_copy/controllers/app_controller.dart';
import 'package:erp_copy/screens/loginscreen.dart';
import 'package:erp_copy/services/api_service.dart';
import 'package:erp_copy/utils/toast_notify.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart'; // Add this import for basename

class RegisterVendorController extends GetxController {
  Future<void> registerVendor({
    required String vendorName,
    required String vendorGroup,
    required String paymentTerms,
    required String vendorCurrency,
    required String telephone,
    required String mobilePhone,
    required String emailID,
    required String website,
    required String billToAddressL1,
    required String billToAddressL2,
    required String billToAddressL3,
    required String billToZipCode,
    required String billToCity,
    required String billToState,
    required String billToCountry,
    required String gstNumber,
    required String gstRegType,
    required String msme,
    required String pan,
    required String accountNo,
    required String accountName,
    required String bankBranch,
    required String bankIFSCCode,
    required String bankZipCode,
    required String bankStreet,
    required String bankCity,
    required String bankState,
    required int payViaAmz,
    required List<PlatformFile> files, // Change to List<PlatformFile>
  }) async {
    try {
      var uri = Uri.parse('${ApiService.base}/api/registerVendor');
      var request = http.MultipartRequest('POST', uri)
        ..headers['Authorization'] = 'Bearer ${AppController.accessToken}';

      // Add form fields
      request.fields['VendorName'] = vendorName;
      request.fields['VendorGroup'] = vendorGroup;
      request.fields['PaymentTerms'] = paymentTerms;
      request.fields['VendorCurrency'] = vendorCurrency;
      request.fields['Telephone'] = telephone;
      request.fields['MobilePhone'] = mobilePhone;
      request.fields['EmailID'] = emailID;
      request.fields['Website'] = website;
      request.fields['BillToAddressL1'] = billToAddressL1;
      request.fields['BillToAddressL2'] = billToAddressL2;
      request.fields['BillToAddressL3'] = billToAddressL3;
      request.fields['BillToZipCode'] = billToZipCode;
      request.fields['BillToCity'] = billToCity;
      request.fields['BillToState'] = billToState;
      request.fields['BillToCountry'] = billToCountry;
      request.fields['GSTNumber'] = gstNumber;
      request.fields['GSTRegType'] = gstRegType;
      request.fields['MSME'] = msme;
      request.fields['PAN'] = pan;
      request.fields['AccountNo'] = accountNo;
      request.fields['AccountName'] = accountName;
      request.fields['BankBranch'] = bankBranch;
      request.fields['BankIFSCCode'] = bankIFSCCode;
      request.fields['BankZipCode'] = bankZipCode;
      request.fields['BankStreet'] = bankStreet;
      request.fields['BankCity'] = bankCity;
      request.fields['BankState'] = bankState;
      request.fields['payViaAmz'] = payViaAmz.toString();

      // Add files
      for (var file in files) {
        request.files.add(
          http.MultipartFile.fromBytes(
            'files',
            File(file.path!).readAsBytesSync(),
            filename: basename(file.path!),
            contentType: MediaType('application', 'octet-stream'),
          ),
        );
      }

      var response = await request.send();

      if (response.statusCode == 200) {
        // Handle successful registration
        Get.defaultDialog(
          title: "Success",
          middleText: "Vendor registered successfully!",
          textConfirm: "OK",
          confirmTextColor: Colors.white,
          onConfirm: () {
            Get.back();
          },
        );
      } else {
        if (response.statusCode == 401) {
          toast('session expired or invalid');
          Get.offAll(LoginScreen());
        }
        // Handle error responses
        Get.defaultDialog(
          title: "Error",
          middleText: "Failed to register vendor. Please try again.",
          textConfirm: "OK",
          confirmTextColor: Colors.white,
          onConfirm: () {
            Get.back();
          },
        );
      }
    } catch (e) {
      // Handle any other errors
      Get.defaultDialog(
        title: "Error",
        middleText: "An error occurred: $e",
        textConfirm: "OK",
        confirmTextColor: Colors.white,
        onConfirm: () {
          Get.back();
        },
      );
    }
  }
}
