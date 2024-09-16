import 'package:erp_copy/controllers/payment_terms_controller/get_payment_terms_controller.dart';
import 'package:erp_copy/controllers/vendor_master_controller/get_all_countries_controller.dart';
import 'package:erp_copy/controllers/vendor_master_controller/get_city_by_state_controller.dart';
import 'package:erp_copy/controllers/vendor_master_controller/get_state_by_country_code_controller.dart';
import 'package:erp_copy/controllers/vendor_master_controller/get_ifsc_code_controller.dart';
import 'package:erp_copy/controllers/vendor_master_controller/register_vendor_controller.dart'; // Import the RegisterVendorController
import 'package:erp_copy/model/vendor_master/country_timezone_model.dart';
import 'package:erp_copy/model/vendor_master/state_by_country_code_model.dart';
import 'package:erp_copy/model/vendor_master/city_by_state_model.dart';
import 'package:erp_copy/widget/menu_widget/drawer_menu_widget.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'dart:io';

class AddVendorMasterScreen extends StatefulWidget {
  const AddVendorMasterScreen({
    super.key,
    required this.openDrawer,
  });
  final VoidCallback openDrawer;

  @override
  State<AddVendorMasterScreen> createState() => _AddVendorMasterScreenState();
}

class _AddVendorMasterScreenState extends State<AddVendorMasterScreen> {
  final _formKey = GlobalKey<FormState>();
  List<PlatformFile> _selectedFiles = [];
  TextEditingController ifscController = TextEditingController();
  TextEditingController bankAccountNamecontroller = TextEditingController();
  TextEditingController bankAccNoController = TextEditingController();
  TextEditingController branchController = TextEditingController();
  TextEditingController zipCodeController = TextEditingController();
  TextEditingController streetController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController msmeController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController groupController = TextEditingController();
  TextEditingController currencyController = TextEditingController();
  TextEditingController telephoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController websiteController = TextEditingController();
  TextEditingController gstNumberController = TextEditingController();
  TextEditingController gstRegTypeController = TextEditingController();
  TextEditingController panController = TextEditingController();
  TextEditingController addressLine1Controller = TextEditingController();
  TextEditingController addressLine2Controller = TextEditingController();
  TextEditingController addressLine3Controller = TextEditingController();
  TextEditingController zipCodeAddressController = TextEditingController();

  final RegisterVendorController registerVendorController =
      Get.put(RegisterVendorController());
  final GetPaymentTermsController getPaymentTermsController =
      Get.put(GetPaymentTermsController());
  final GetAllCountriesController getAllCountriesController =
      Get.put(GetAllCountriesController());
  final GetStateByCountryCodeController getStateByCountryCodeController =
      Get.put(GetStateByCountryCodeController());
  final GetCityByStateCodeController getCityByStateCodeController =
      Get.put(GetCityByStateCodeController());
  final GetIFSCCodeController getIFSCCodeController =
      Get.put(GetIFSCCodeController());

  String? selectedCountryCode;
  String? selectedState;
  String? selectedCity;
  String? selectedPaymentTerm;
  String? selectedGroup;
  String? selectedVendorCurrency;
  String? selectedGstRegType;
  int payViaAmz = 0;

  bool isPaymentTermPayViaAmazon() {
    return selectedPaymentTerm == "Pay Via Amazon";
  }

  @override
  void initState() {
    super.initState();
    fetchPaymentTerms();
    fetchCountries();
  }

  Future<void> fetchPaymentTerms() async {
    await getPaymentTermsController.getPaymentTerms();
    setState(() {});
  }

  Future<void> fetchCountries() async {
    await getAllCountriesController.getAllCountries();
    setState(() {});
  }

  Future<void> fetchStates(String countryCode) async {
    await getStateByCountryCodeController.getState(countryCode);
    setState(() {});
  }

  Future<void> fetchCities(String stateCode) async {
    await getCityByStateCodeController.getCity(selectedCountryCode!, stateCode);
    setState(() {});
  }

  Future<void> _chooseFiles() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: true,
      );

      if (result != null && result.files.isNotEmpty) {
        setState(() {
          _selectedFiles = result.files.length > 5
              ? result.files.sublist(0, 5)
              : result.files;
        });
      }
    } catch (e) {
      print("Error picking files: $e");
    }
  }

  void _removeFile(int index) {
    setState(() {
      _selectedFiles.removeAt(index);
    });
  }

  Future<void> _fetchBankDetails() async {
    await Get.find<GetIFSCCodeController>().getIFSC(ifscController.text);
    final ifscDetails = Get.find<GetIFSCCodeController>().ifscDetails;

    if (ifscDetails != null) {
      setState(() {
        branchController.text = ifscDetails.branch ?? '';
        zipCodeController.text = ifscDetails.zipCode ?? '';
        streetController.text = ifscDetails.address ?? '';
        cityController.text = ifscDetails.city ?? '';
      });
    } else {
      Get.snackbar("Error", "No details found for the provided IFSC code");
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      registerVendorController.registerVendor(
        vendorName: nameController.text,
        vendorGroup: selectedGroup ?? '',
        paymentTerms: selectedPaymentTerm ?? '',
        vendorCurrency: selectedVendorCurrency ?? '',
        telephone: telephoneController.text,
        mobilePhone: mobileController.text,
        emailID: emailController.text,
        website: websiteController.text,
        billToAddressL1: addressLine1Controller.text,
        billToAddressL2: addressLine2Controller.text,
        billToAddressL3: addressLine3Controller.text,
        billToZipCode: zipCodeAddressController.text,
        billToCity: selectedCity ?? '',
        billToState: selectedState ?? '',
        billToCountry: selectedCountryCode ?? '',
        gstNumber: gstNumberController.text,
        gstRegType: selectedGstRegType ?? '',
        msme: msmeController.text,
        pan: panController.text,
        accountNo: isPaymentTermPayViaAmazon() ? '' : bankAccNoController.text,
        accountName:
            isPaymentTermPayViaAmazon() ? '' : bankAccountNamecontroller.text,
        bankBranch: isPaymentTermPayViaAmazon() ? '' : branchController.text,
        bankIFSCCode: isPaymentTermPayViaAmazon() ? '' : ifscController.text,
        bankZipCode: isPaymentTermPayViaAmazon() ? '' : zipCodeController.text,
        bankStreet: isPaymentTermPayViaAmazon() ? '' : streetController.text,
        bankCity: isPaymentTermPayViaAmazon() ? '' : cityController.text,
        bankState: isPaymentTermPayViaAmazon() ? '' : selectedState ?? '',
        payViaAmz: isPaymentTermPayViaAmazon() ? 1 : 0,
        files: _selectedFiles,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 68, 168, 71),
        automaticallyImplyLeading: true,
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text(
                'Add Vendor',
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
              const SizedBox(width: 100),
              DrawerMenuWidget(
                onClicked: widget.openDrawer,
              ),
              const SizedBox(
                width: 20,
              ),
            ],
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSectionCard(
                  title: 'General',
                  children: [
                    _buildTextFormField(
                      'Name',
                      'Please enter name',
                      controller: nameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a name';
                        }
                        return null;
                      },
                    ),
                    _buildGroupDropdownFormField(
                      'Group',
                      'Select Group',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select a group';
                        }
                        return null;
                      },
                    ),
                    _buildCountryCodeDropdownFormField(
                      'Country Code',
                      'Select Country Code',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select a country code';
                        }
                        return null;
                      },
                    ),
                    _buildTextFormField(
                      'Telephone',
                      'Please enter telephone number',
                      controller: telephoneController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a telephone number';
                        }
                        return null;
                      },
                      enabled: !isPaymentTermPayViaAmazon(),
                    ),
                    _buildTextFormField(
                      'Mobile',
                      'Please enter mobile number',
                      controller: mobileController,
                      maxLength: 10,
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a mobile number';
                        } else if (value.length != 10) {
                          return 'Mobile number must be 10 digits';
                        }
                        return null;
                      },
                      enabled: !isPaymentTermPayViaAmazon(),
                    ),
                    _buildTextFormField(
                      'Email',
                      'Please enter email address',
                      controller: emailController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter an email address';
                        }
                        return null;
                      },
                      enabled: !isPaymentTermPayViaAmazon(),
                    ),
                    _buildTextFormField(
                      'Website',
                      'Please enter website URL',
                      controller: websiteController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a website URL';
                        }
                        return null;
                      },
                      enabled: !isPaymentTermPayViaAmazon(),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                _buildSectionCard(
                  title: 'Address',
                  children: [
                    _buildTextFormField(
                      'Address Line 1',
                      'Please enter Address Line 1',
                      controller: addressLine1Controller,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter address line 1';
                        }
                        return null;
                      },
                    ),
                    _buildTextFormField(
                      'Address Line 2',
                      'Please enter Address Line 2',
                      controller: addressLine2Controller,
                    ),
                    _buildTextFormField(
                      'Address Line 3',
                      'Please enter Address Line 3',
                      controller: addressLine3Controller,
                    ),
                    _buildTextFormField(
                      'Zip Code',
                      'Please enter Zip Code',
                      controller: zipCodeAddressController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter zip code';
                        }
                        return null;
                      },
                    ),
                    _buildCountryDropdownFormField(
                      'Country',
                      'Select Country',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select a country';
                        }
                        return null;
                      },
                    ),
                    _buildStateDropdownFormField(
                      'State',
                      'Select State',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select a state';
                        }
                        return null;
                      },
                    ),
                    _buildCityDropdownFormField(
                      'City',
                      'Select City',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select a city';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                _buildSectionCard(
                  title: 'Category',
                  children: [
                    _buildPaymentTermsDropdownFormField(
                      'Payment Terms',
                      'Select Payment Terms',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select payment terms';
                        }
                        return null;
                      },
                    ),
                    _buildVendorCurrencyDropdownFormField(
                      'Vendor Currency',
                      'Select Vendor Currency',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select vendor currency';
                        }
                        return null;
                      },
                    ),
                    _buildTextFormField(
                      'GST Number',
                      'Please enter GST Number',
                      controller: gstNumberController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a GST number';
                        }
                        return null;
                      },
                    ),
                    _buildGSTRegTypeDropdownFormField(
                      'GST Reg Type',
                      'Select GST Reg Type',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select a GST registration type';
                        }
                        return null;
                      },
                    ),
                    _buildTextFormField(
                      'MSME Number',
                      'Please enter MSME Number',
                      controller: msmeController,
                      validator: (value) {
                        String pattern = r'^UDYAM-[A-Z]{2}-\d{2}-\d{7}$';
                        RegExp regex = RegExp(pattern);
                        if (!regex.hasMatch(value ?? '')) {
                          return 'Invalid MSME format';
                        }
                        return null;
                      },
                    ),
                    _buildTextFormField(
                      'PAN Number',
                      'Please enter PAN Number',
                      controller: panController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a PAN number';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                _buildSectionCard(
                  title: 'Bank Details',
                  disabled: isPaymentTermPayViaAmazon(),
                  children: [
                    _buildTextFormField(
                      'Bank Account Number',
                      'Please enter Bank Account Number',
                      controller: bankAccNoController,
                      enabled: !isPaymentTermPayViaAmazon(),
                      validator: (value) {
                        if (!isPaymentTermPayViaAmazon() &&
                            (value == null || value.isEmpty)) {
                          return 'Please enter a bank account number';
                        }
                        return null;
                      },
                    ),
                    _buildTextFormField(
                      'Account Name',
                      'Please enter account name',
                      enabled: !isPaymentTermPayViaAmazon(),
                      validator: (value) {
                        if (!isPaymentTermPayViaAmazon() &&
                            (value == null || value.isEmpty)) {
                          return 'Please enter an account name';
                        }
                        return null;
                      },
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: _buildTextFormField(
                            'IFSC / SWIFT Code',
                            'Please enter IFSC',
                            controller: ifscController,
                            enabled: !isPaymentTermPayViaAmazon(),
                            validator: (value) {
                              if (!isPaymentTermPayViaAmazon() &&
                                  (value == null || value.isEmpty)) {
                                return 'Please enter an IFSC code';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(width: 10),
                        ElevatedButton(
                          onPressed: isPaymentTermPayViaAmazon()
                              ? null
                              : _fetchBankDetails,
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            backgroundColor: isPaymentTermPayViaAmazon()
                                ? Colors.grey
                                : const Color(0xFF43A047),
                            foregroundColor: Colors.white,
                          ),
                          child: const Text('Search'),
                        ),
                      ],
                    ),
                    _buildTextFormField(
                      'Branch',
                      'Please enter Branch',
                      controller: branchController,
                      enabled: !isPaymentTermPayViaAmazon(),
                      validator: (value) {
                        if (!isPaymentTermPayViaAmazon() &&
                            (value == null || value.isEmpty)) {
                          return 'Please enter a branch';
                        }
                        return null;
                      },
                    ),
                    _buildTextFormField(
                      'Zip Code',
                      'Please enter Zip Code',
                      controller: zipCodeController,
                      enabled: !isPaymentTermPayViaAmazon(),
                      validator: (value) {
                        if (!isPaymentTermPayViaAmazon() &&
                            (value == null || value.isEmpty)) {
                          return 'Please enter a zip code';
                        }
                        return null;
                      },
                    ),
                    _buildTextFormField(
                      'Street',
                      'Please enter Street',
                      controller: streetController,
                      enabled: !isPaymentTermPayViaAmazon(),
                      validator: (value) {
                        if (!isPaymentTermPayViaAmazon() &&
                            (value == null || value.isEmpty)) {
                          return 'Please enter a street';
                        }
                        return null;
                      },
                    ),
                    _buildTextFormField(
                      'City',
                      'Please enter City',
                      controller: cityController,
                      enabled: !isPaymentTermPayViaAmazon(),
                      validator: (value) {
                        if (!isPaymentTermPayViaAmazon() &&
                            (value == null || value.isEmpty)) {
                          return 'Please enter a city';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                _buildUploadAndSubmitSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionCard({
    required String title,
    required List<Widget> children,
    bool disabled = false,
  }) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          gradient: const LinearGradient(
            colors: [
              Color(0xFFE8F5E9),
              Colors.white,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Opacity(
          opacity: disabled ? 0.5 : 1.0,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                const SizedBox(height: 10),
                ...children,
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextFormField(
    String label,
    String hint, {
    TextEditingController? controller,
    FormFieldValidator<String>? validator,
    int? maxLength,
    TextInputType? keyboardType,
    bool enabled = true,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        maxLength: maxLength,
        keyboardType: keyboardType,
        enabled: enabled,
        validator: validator,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.black12),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        style: const TextStyle(
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _buildDropdownFormField(
    String label,
    String hint, {
    required List<DropdownMenuItem<String>> items,
    ValueChanged<String?>? onChanged,
    FormFieldValidator<String>? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        items: items,
        onChanged: onChanged,
        validator: validator,
        style: const TextStyle(
          color: Colors.black,
        ),
        dropdownColor: Colors.white,
        iconEnabledColor: Colors.black,
        isExpanded: true,
      ),
    );
  }

  Widget _buildGroupDropdownFormField(
    String label,
    String hint, {
    FormFieldValidator<String>? validator,
  }) {
    return _buildDropdownFormField(
      label,
      hint,
      items: <String>['MSME', 'Domestic', 'International'].map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (String? newValue) {
        setState(() {
          selectedGroup = newValue;
        });
      },
      validator: validator,
    );
  }

  Widget _buildCountryCodeDropdownFormField(
    String label,
    String hint, {
    FormFieldValidator<String>? validator,
  }) {
    return _buildDropdownFormField(
      label,
      hint,
      items: getAllCountriesController.countryList.map((Country country) {
        return DropdownMenuItem<String>(
          value: country.phonecode,
          child:
              Text('${country.flag} ${country.name} (+${country.phonecode})'),
        );
      }).toList(),
      onChanged: (String? newValue) {
        setState(() {
          selectedCountryCode = newValue;
        });
      },
      validator: validator,
    );
  }

  Widget _buildCountryDropdownFormField(
    String label,
    String hint, {
    FormFieldValidator<String>? validator,
  }) {
    return _buildDropdownFormField(
      label,
      hint,
      items: getAllCountriesController.countryList.map((Country country) {
        return DropdownMenuItem<String>(
          value: country.isoCode,
          child: Text(country.name ?? ''),
        );
      }).toList(),
      onChanged: (String? newValue) {
        setState(() {
          selectedCountryCode = newValue;
          fetchStates(selectedCountryCode!);
          selectedState = null;
          selectedCity = null;
        });
      },
      validator: validator,
    );
  }

  Widget _buildStateDropdownFormField(
    String label,
    String hint, {
    FormFieldValidator<String>? validator,
  }) {
    return _buildDropdownFormField(
      label,
      hint,
      items: getStateByCountryCodeController.stateList
          .map((StateByCountryCodeModel state) {
        return DropdownMenuItem<String>(
          value: state.isoCode,
          child: Text(state.name ?? ''),
        );
      }).toList(),
      onChanged: (String? newValue) {
        setState(() {
          selectedState = newValue;
          fetchCities(selectedState!);
          selectedCity = null;
        });
      },
      validator: validator,
    );
  }

  Widget _buildCityDropdownFormField(
    String label,
    String hint, {
    FormFieldValidator<String>? validator,
  }) {
    return _buildDropdownFormField(
      label,
      hint,
      items: getCityByStateCodeController.cityList
          .map((GetCityByStateCodeModel city) {
        return DropdownMenuItem<String>(
          value: city.name,
          child: Text(city.name ?? ''),
        );
      }).toList(),
      onChanged: (String? newValue) {
        setState(() {
          selectedCity = newValue;
        });
      },
      validator: validator,
    );
  }

  Widget _buildPaymentTermsDropdownFormField(
    String label,
    String hint, {
    FormFieldValidator<String>? validator,
  }) {
    return _buildDropdownFormField(
      label,
      hint,
      items: getPaymentTermsController.paymentTermsList.map((paymentTerm) {
        return DropdownMenuItem<String>(
          value: paymentTerm.terms,
          child: Text(paymentTerm.terms ?? ''),
        );
      }).toList(),
      onChanged: (String? newValue) {
        setState(() {
          selectedPaymentTerm = newValue;
          if (isPaymentTermPayViaAmazon()) {
            payViaAmz = 1;
          } else {
            payViaAmz = 0;
          }
        });
      },
      validator: validator,
    );
  }

  Widget _buildVendorCurrencyDropdownFormField(
    String label,
    String hint, {
    FormFieldValidator<String>? validator,
  }) {
    const List<String> currencies = ['INR', 'USD', 'EUR', 'JPY', 'CNY'];
    return _buildDropdownFormField(
      label,
      hint,
      items: currencies.map((currency) {
        return DropdownMenuItem<String>(
          value: currency,
          child: Text(currency),
        );
      }).toList(),
      onChanged: (String? newValue) {
        setState(() {
          selectedVendorCurrency = newValue;
        });
      },
      validator: validator,
    );
  }

  Widget _buildGSTRegTypeDropdownFormField(
    String label,
    String hint, {
    FormFieldValidator<String>? validator,
  }) {
    return _buildDropdownFormField(
      label,
      hint,
      items: const <String>[
        'N/A',
        'Regular',
        'Composition Scheme',
        'Casual',
        'Non-Resident',
        'SEZ registration',
      ].map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (String? newValue) {
        setState(() {
          selectedGstRegType = newValue;
        });
      },
      validator: validator,
    );
  }

  Widget _buildUploadAndSubmitSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ElevatedButton(
          onPressed: _chooseFiles,
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            backgroundColor: const Color(0xFF43A047),
            foregroundColor: Colors.white,
          ),
          child: const Text('Choose files'),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8.0,
          children: _selectedFiles.map((file) {
            return Chip(
              label: Text(file.name),
              onDeleted: () => _removeFile(_selectedFiles.indexOf(file)),
            );
          }).toList(),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: _submitForm,
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            backgroundColor: const Color(0xFF43A047),
            foregroundColor: Colors.white,
          ),
          child: const Text('Submit For Approval'),
        ),
      ],
    );
  }
}
