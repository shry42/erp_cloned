import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:erp_copy/controllers/app_controller.dart';
import 'package:erp_copy/controllers/po_controllers/cancel_po_controller.dart';
import 'package:erp_copy/controllers/po_controllers/po_log_controller.dart';
import 'package:erp_copy/controllers/po_controllers/vendor_details_controller.dart';
import 'package:erp_copy/controllers/vendor_master_controller/vendor_list_pdf_controller.dart';
import 'package:erp_copy/screens/po_screens/po_ammendment_screen.dart';
import 'package:erp_copy/widget/menu_widget/drawer_menu_widget.dart';
import 'package:erp_copy/widgets/po_cards/po_list_new_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:get/get.dart';

class POListScreen extends StatefulWidget {
  const POListScreen({
    super.key,
    required this.openDrawer,
  });
  final VoidCallback openDrawer;

  @override
  State<POListScreen> createState() => _POListScreenState();
}

class _POListScreenState extends State<POListScreen> {
  // double _height = 120;
  // double _width = 350;
  bool isPOSelected = true;
  bool animated = false;
  List<dynamic>? dataList;
  List? searchDataList;
  List? mainDataList;
  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 0;

  bool showApproved = true;

  final PoLogDetailsController poLogDeatailsCont =
      Get.put(PoLogDetailsController());
  final VenodorDetailsController vendorCont = VenodorDetailsController();
  TextEditingController searchController = TextEditingController();

  // final GetVendorMasterPdfController  gvmpdfc = Get.put(GetVendorMasterPdfController());

  final advancedDrawerController = AdvancedDrawerController();

  void opneDrawer() {
    setState(() {
      xOffset = 240;
      yOffset = 120;
      scaleFactor = 0.8;
    });
  }

  @override
  void initState() {
    dataList; //Initialize as empty or else data will not be displayed until tapped on searchbar
    poLogDeatailsCont;

    WidgetsBinding.instance?.addPostFrameCallback((_) async {
      await poLogDeatailsCont.getPoLogDetails().then((value) {
        setState(() {
          dataList = value;
          searchDataList = value;
          mainDataList = value;
        });
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.sizeOf(context).height * 0.32;
    double _width = MediaQuery.sizeOf(context).width * 0.90;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 68, 168, 71),
        automaticallyImplyLeading: true,
        // title: const Text('UnApproved PO selection'),

        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: const Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.white,
                  size: 30,
                ),
              ),
              const SizedBox(width: 120),
              const Text(
                'PO Lists',
                style: TextStyle(color: Colors.white),
              ),
              const SizedBox(width: 95),
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
      body: Stack(children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 15.0, vertical: 20),
                  child: SizedBox(
                    height: 35,
                    width: 200,
                    child: TextField(
                      style: const TextStyle(color: Colors.black),
                      controller: searchController,
                      onChanged: (value) {
                        setState(() {
                          if (value.isEmpty) {
                            dataList = searchDataList; // Reset to show all data
                          } else {
                            dataList = searchDataList
                                ?.where((element) => element.POTxnID.toString()
                                    .contains(value.toString()))
                                .toList();
                          }
                        });
                      },
                      decoration: InputDecoration(
                        focusColor: Colors.black,
                        filled: true,
                        fillColor: const Color(0xfff1f1f1),
                        border: OutlineInputBorder(
                          gapPadding: 20,
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            width: 1,
                            color: Colors.green,
                          ),
                        ),
                        hintText: "Search for PoTxnId",
                        hintStyle:
                            const TextStyle(fontSize: 12, color: Colors.grey),
                        suffixIcon: const Icon(Icons.search),
                        // suffixIconColor: Colors.white,
                        prefixIconColor: Colors.black,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Container(
                  height: 35,
                  width: 150,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: <Color>[
                        Color.fromARGB(243, 84, 86, 80),
                        // Color.fromARGB(243, 77, 234, 88),
                        Color.fromARGB(255, 234, 242, 232),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Center(
                      child: Text(
                    'Search History',
                    style: TextStyle(color: Colors.white),
                  )),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: DefaultTabController(
                  length: 7,
                  child: Column(
                    children: <Widget>[
                      ButtonsTabBar(
                        onTap: (index) {
                          if (index == 0) {
                            setState(() {
                              dataList = mainDataList;
                              searchDataList = dataList;
                              searchController.clear();
                            });
                          } else if (index == 1) {
                            setState(() {
                              dataList = mainDataList
                                  ?.where((element) =>
                                      element.POStatus.toString()
                                          .contains('PO Generated'.toString()))
                                  .toList();
                              searchDataList = dataList;
                              searchController.clear();
                            });
                          } else if (index == 2) {
                            setState(() {
                              dataList = mainDataList
                                  ?.where((element) =>
                                      element.POStatus.toString().contains(
                                          'Approval Pending'.toString()))
                                  .toList();
                              searchDataList = dataList;
                              searchController.clear();
                            });
                          } else if (index == 3) {
                            setState(() {
                              dataList = mainDataList
                                  ?.where((element) =>
                                      element.POStatus.toString()
                                          .contains('Approved'.toString()))
                                  .toList();
                              searchDataList = dataList;
                              searchController.clear();
                            });
                          } else if (index == 4) {
                            setState(() {
                              dataList = mainDataList
                                  ?.where((element) =>
                                      element.POStatus.toString()
                                          .contains('Rejected'.toString()))
                                  .toList();
                              searchDataList = dataList;
                              searchController.clear();
                            });
                          } else if (index == 5) {
                            setState(() {
                              dataList = mainDataList
                                  ?.where((element) =>
                                      element.POStatus.toString()
                                          .contains('Cancelled'.toString()))
                                  .toList();
                              searchDataList = dataList;
                              searchController.clear();
                            });
                          } else if (index == 6) {
                            setState(() {
                              dataList = mainDataList
                                  ?.where((element) =>
                                      element.POStatus.toString()
                                          .contains('GRN Done'.toString()))
                                  .toList();
                              searchDataList = dataList;
                              searchController.clear();
                            });
                          }
                        },
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 10),
                        unselectedBackgroundColor:
                            const Color.fromARGB(255, 125, 141, 122),
                        decoration: const BoxDecoration(
                          // gradient: LinearGradient(
                          //   colors: <Color>[
                          //     Color.fromARGB(243, 84, 86, 80),
                          //     // Color.fromARGB(243, 77, 234, 88),
                          //     Color.fromARGB(255, 151, 223, 126),
                          //   ],
                          // ),
                          color: Color.fromARGB(255, 68, 168, 71),
                        ),
                        unselectedLabelStyle: const TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255)),
                        labelStyle: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        tabs: const [
                          Tab(
                            // icon: Icon(Icons.all_inbox),
                            text: "All POs",
                          ),
                          Tab(
                            // icon: Icon(Icons.all_inbox),
                            text: "PO Generated",
                          ),
                          Tab(
                            // icon: Icon(Icons.approval),
                            text: "Approval pending",
                          ),
                          Tab(
                            // icon: Icon(Icons.pending),
                            text: "Approved",
                          ),
                          Tab(
                            // icon: Icon(Icons.wrong_location_rounded),
                            text: "Rejected",
                          ),
                          Tab(
                            // icon: Icon(Icons.pending),
                            text: "Cancelled",
                          ),
                          Tab(
                            // icon: Icon(Icons.pending),
                            text: "GRN Done",
                          ),
                        ],
                      ),
                      Expanded(
                        child: TabBarView(
                          physics: const NeverScrollableScrollPhysics(),
                          children: [
                            Center(
                              child: Column(
                                children: [
                                  const SizedBox(height: 30),
                                  Expanded(
                                    child: Builder(builder: (
                                      BuildContext context,
                                    ) {
                                      if (dataList == null) {
                                        return Center(
                                            child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              'assets/images/loaderr.gif',
                                              height: 200,
                                              width: 350,
                                            ),
                                            const Text('No records found')
                                          ],
                                        ));
                                      } else {
                                        return ListView.builder(
                                            itemCount: dataList!.length,
                                            itemBuilder: (context, index) {
                                              final POStatus = dataList![index]
                                                  .POStatus
                                                  .toString();
                                              final color =
                                                  POStatus == 'Rejected'
                                                      ? Colors.red
                                                      : POStatus == 'Approved'
                                                          ? Colors.green
                                                          : Colors.grey;
                                              return GestureDetector(
                                                onTap: () async {
                                                  final POStatus =
                                                      dataList![index]
                                                          .POStatus
                                                          .toString();
                                                  final color = POStatus ==
                                                          'Rejected'
                                                      ? Colors.red
                                                      : POStatus == 'Approved'
                                                          ? Colors.green
                                                          : Colors.grey;
                                                  String POTxnID =
                                                      dataList![index]
                                                          .POTxnID
                                                          .toString();

                                                  if (AppController.message !=
                                                      null) {
                                                    Get.defaultDialog(
                                                      title: "Oops!",
                                                      middleText:
                                                          "${AppController.message}",
                                                      textConfirm: "OK",
                                                      confirmTextColor:
                                                          Colors.white,
                                                      onConfirm: () {
                                                        Get.back(); // Close the dialog
                                                      },
                                                    );
                                                    return;
                                                  } else {
                                                    showPODialog(
                                                      dataList![index]
                                                          .POTxnID
                                                          .toString(),
                                                      dataList![index]
                                                          .VendorID
                                                          .toString(),
                                                    );
                                                  }
                                                },
                                                child: POListsNewCard(
                                                  ht: _height,
                                                  wd: _width,
                                                  duration: 500,
                                                  srNo: (index + 1)
                                                      .toString(), // SR No based on index
                                                  poTxnID: dataList![index]
                                                      .POTxnID
                                                      .toString(), // PO TxnID from dataList
                                                  prTxnID: dataList![index]
                                                      .PRTxnID
                                                      .toString(), // PR TxnID from dataList
                                                  poCode: dataList![index]
                                                      .POCode
                                                      .toString(), // PO Code from dataList
                                                  poDate: dataList![index]
                                                          .PODate
                                                          .toString()
                                                          .split("T")[
                                                      0], // PO Date from dataList, formatted
                                                  department: dataList![index]
                                                      .Department
                                                      .toString(), // Department from dataList
                                                  status: dataList![index]
                                                      .POStatus
                                                      .toString(), // PO Status from dataList
                                                ),
                                              );
                                            });
                                      }
                                    }),
                                  )
                                ],
                              ),
                            ),
                            Center(
                              child: Column(
                                children: [
                                  const SizedBox(height: 30),
                                  Expanded(
                                    child: Builder(builder: (
                                      BuildContext context,
                                    ) {
                                      if (dataList == null) {
                                        return Center(
                                            child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              'assets/images/loaderr.gif',
                                              height: 200,
                                              width: 350,
                                            ),
                                            const Text('No records found')
                                          ],
                                        ));
                                      } else {
                                        return ListView.builder(
                                            itemCount: dataList!.length,
                                            itemBuilder: (context, index) {
                                              final POStatus = dataList![index]
                                                  .POStatus
                                                  .toString();
                                              final color =
                                                  POStatus == 'Rejected'
                                                      ? Colors.red
                                                      : POStatus == 'Approved'
                                                          ? Colors.green
                                                          : Colors.grey;
                                              return GestureDetector(
                                                onTap: () async {
                                                  final POStatus =
                                                      dataList![index]
                                                          .POStatus
                                                          .toString();
                                                  final color = POStatus ==
                                                          'Rejected'
                                                      ? Colors.red
                                                      : POStatus == 'Approved'
                                                          ? Colors.green
                                                          : Colors.grey;
                                                  String POTxnID =
                                                      dataList![index]
                                                          .POTxnID
                                                          .toString();

                                                  if (AppController.message !=
                                                      null) {
                                                    Get.defaultDialog(
                                                      title: "Oops!",
                                                      middleText:
                                                          "${AppController.message}",
                                                      textConfirm: "OK",
                                                      confirmTextColor:
                                                          Colors.white,
                                                      onConfirm: () {
                                                        Get.back(); // Close the dialog
                                                      },
                                                    );
                                                    return;
                                                  } else {
                                                    showPODialog(
                                                      dataList![index]
                                                          .POTxnID
                                                          .toString(),
                                                      dataList![index]
                                                          .POTxnID
                                                          .toString(),
                                                    );
                                                  }
                                                },
                                                child: POListsNewCard(
                                                  ht: _height,
                                                  wd: _width,
                                                  duration: 500,
                                                  srNo: (index + 1)
                                                      .toString(), // SR No based on index
                                                  poTxnID: dataList![index]
                                                      .POTxnID
                                                      .toString(), // PO TxnID from dataList
                                                  prTxnID: dataList![index]
                                                      .PRTxnID
                                                      .toString(), // PR TxnID from dataList
                                                  poCode: dataList![index]
                                                      .POCode
                                                      .toString(), // PO Code from dataList
                                                  poDate: dataList![index]
                                                          .PODate
                                                          .toString()
                                                          .split("T")[
                                                      0], // PO Date from dataList, formatted
                                                  department: dataList![index]
                                                      .Department
                                                      .toString(), // Department from dataList
                                                  status: dataList![index]
                                                      .POStatus
                                                      .toString(), // PO Status from dataList
                                                ),
                                              );
                                            });
                                      }
                                    }),
                                  )
                                ],
                              ),
                            ),
                            Center(
                              child: Column(
                                children: [
                                  const SizedBox(height: 30),
                                  Expanded(
                                    child: Builder(builder: (
                                      BuildContext context,
                                    ) {
                                      if (dataList == null) {
                                        return Center(
                                            child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              'assets/images/loaderr.gif',
                                              height: 200,
                                              width: 350,
                                            ),
                                            const Text('No records found')
                                          ],
                                        ));
                                      } else {
                                        return ListView.builder(
                                            itemCount: dataList!.length,
                                            itemBuilder: (context, index) {
                                              final POStatus = dataList![index]
                                                  .POStatus
                                                  .toString();
                                              final color =
                                                  POStatus == 'Rejected'
                                                      ? Colors.red
                                                      : POStatus == 'Approved'
                                                          ? Colors.green
                                                          : Colors.grey;
                                              return GestureDetector(
                                                onTap: () async {
                                                  final POStatus =
                                                      dataList![index]
                                                          .POStatus
                                                          .toString();
                                                  final color = POStatus ==
                                                          'Rejected'
                                                      ? Colors.red
                                                      : POStatus == 'Approved'
                                                          ? Colors.green
                                                          : Colors.grey;
                                                  String POTxnID =
                                                      dataList![index]
                                                          .POTxnID
                                                          .toString();

                                                  if (AppController.message !=
                                                      null) {
                                                    Get.defaultDialog(
                                                      title: "Oops!",
                                                      middleText:
                                                          "${AppController.message}",
                                                      textConfirm: "OK",
                                                      confirmTextColor:
                                                          Colors.white,
                                                      onConfirm: () {
                                                        Get.back(); // Close the dialog
                                                      },
                                                    );
                                                    return;
                                                  } else {
                                                    showPODialog(
                                                      dataList![index]
                                                          .POTxnID
                                                          .toString(),
                                                      dataList![index]
                                                          .VendorID
                                                          .toString(),
                                                    );
                                                  }
                                                },
                                                child: POListsNewCard(
                                                  ht: _height,
                                                  wd: _width,
                                                  duration: 500,
                                                  srNo: (index + 1)
                                                      .toString(), // SR No based on index
                                                  poTxnID: dataList![index]
                                                      .POTxnID
                                                      .toString(), // PO TxnID from dataList
                                                  prTxnID: dataList![index]
                                                      .PRTxnID
                                                      .toString(), // PR TxnID from dataList
                                                  poCode: dataList![index]
                                                      .POCode
                                                      .toString(), // PO Code from dataList
                                                  poDate: dataList![index]
                                                          .PODate
                                                          .toString()
                                                          .split("T")[
                                                      0], // PO Date from dataList, formatted
                                                  department: dataList![index]
                                                      .Department
                                                      .toString(), // Department from dataList
                                                  status: dataList![index]
                                                      .POStatus
                                                      .toString(), // PO Status from dataList
                                                ),
                                              );
                                            });
                                      }
                                    }),
                                  )
                                ],
                              ),
                            ),
                            Center(
                              child: Column(
                                children: [
                                  const SizedBox(height: 30),
                                  Expanded(
                                    child: Builder(builder: (
                                      BuildContext context,
                                    ) {
                                      if (dataList == null) {
                                        return Center(
                                            child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              'assets/images/loaderr.gif',
                                              height: 200,
                                              width: 350,
                                            ),
                                            const Text('No records found')
                                          ],
                                        ));
                                      } else {
                                        return ListView.builder(
                                            itemCount: dataList!.length,
                                            itemBuilder: (context, index) {
                                              final POStatus = dataList![index]
                                                  .POStatus
                                                  .toString();
                                              final color =
                                                  POStatus == 'Rejected'
                                                      ? Colors.red
                                                      : POStatus == 'Approved'
                                                          ? Colors.green
                                                          : Colors.grey;
                                              return GestureDetector(
                                                onTap: () async {
                                                  final POStatus =
                                                      dataList![index]
                                                          .POStatus
                                                          .toString();
                                                  final color = POStatus ==
                                                          'Rejected'
                                                      ? Colors.red
                                                      : POStatus == 'Approved'
                                                          ? Colors.green
                                                          : Colors.grey;
                                                  String POTxnID =
                                                      dataList![index]
                                                          .POTxnID
                                                          .toString();

                                                  if (AppController.message !=
                                                      null) {
                                                    Get.defaultDialog(
                                                      title: "Oops!",
                                                      middleText:
                                                          "${AppController.message}",
                                                      textConfirm: "OK",
                                                      confirmTextColor:
                                                          Colors.white,
                                                      onConfirm: () {
                                                        Get.back(); // Close the dialog
                                                      },
                                                    );
                                                    return;
                                                  } else {
                                                    showPODialog(
                                                      dataList![index]
                                                          .POTxnID
                                                          .toString(),
                                                      dataList![index]
                                                          .VendorID
                                                          .toString(),
                                                    );
                                                  }
                                                },
                                                child: POListsNewCard(
                                                  ht: _height,
                                                  wd: _width,
                                                  duration: 500,
                                                  srNo: (index + 1)
                                                      .toString(), // SR No based on index
                                                  poTxnID: dataList![index]
                                                      .POTxnID
                                                      .toString(), // PO TxnID from dataList
                                                  prTxnID: dataList![index]
                                                      .PRTxnID
                                                      .toString(), // PR TxnID from dataList
                                                  poCode: dataList![index]
                                                      .POCode
                                                      .toString(), // PO Code from dataList
                                                  poDate: dataList![index]
                                                          .PODate
                                                          .toString()
                                                          .split("T")[
                                                      0], // PO Date from dataList, formatted
                                                  department: dataList![index]
                                                      .Department
                                                      .toString(), // Department from dataList
                                                  status: dataList![index]
                                                      .POStatus
                                                      .toString(), // PO Status from dataList
                                                ),
                                              );
                                            });
                                      }
                                    }),
                                  )
                                ],
                              ),
                            ),
                            Center(
                              child: Column(
                                children: [
                                  const SizedBox(height: 30),
                                  Expanded(
                                    child: Builder(builder: (
                                      BuildContext context,
                                    ) {
                                      if (dataList == null) {
                                        return Center(
                                            child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              'assets/images/loaderr.gif',
                                              height: 200,
                                              width: 350,
                                            ),
                                            const Text('No records found')
                                          ],
                                        ));
                                      } else {
                                        return ListView.builder(
                                            itemCount: dataList!.length,
                                            itemBuilder: (context, index) {
                                              final POStatus = dataList![index]
                                                  .POStatus
                                                  .toString();
                                              final color =
                                                  POStatus == 'Rejected'
                                                      ? Colors.red
                                                      : POStatus == 'Approved'
                                                          ? Colors.green
                                                          : Colors.grey;
                                              return GestureDetector(
                                                onTap: () async {
                                                  final POStatus =
                                                      dataList![index]
                                                          .POStatus
                                                          .toString();
                                                  final color = POStatus ==
                                                          'Rejected'
                                                      ? Colors.red
                                                      : POStatus == 'Approved'
                                                          ? Colors.green
                                                          : Colors.grey;
                                                  String POTxnID =
                                                      dataList![index]
                                                          .POTxnID
                                                          .toString();

                                                  if (AppController.message !=
                                                      null) {
                                                    Get.defaultDialog(
                                                      title: "Oops!",
                                                      middleText:
                                                          "${AppController.message}",
                                                      textConfirm: "OK",
                                                      confirmTextColor:
                                                          Colors.white,
                                                      onConfirm: () {
                                                        Get.back(); // Close the dialog
                                                      },
                                                    );
                                                    return;
                                                  } else {
                                                    showPODialog(
                                                      dataList![index]
                                                          .POTxnID
                                                          .toString(),
                                                      dataList![index]
                                                          .VendorID
                                                          .toString(),
                                                    );
                                                  }
                                                },
                                                child: POListsNewCard(
                                                  ht: _height,
                                                  wd: _width,
                                                  duration: 500,
                                                  srNo: (index + 1)
                                                      .toString(), // SR No based on index
                                                  poTxnID: dataList![index]
                                                      .POTxnID
                                                      .toString(), // PO TxnID from dataList
                                                  prTxnID: dataList![index]
                                                      .PRTxnID
                                                      .toString(), // PR TxnID from dataList
                                                  poCode: dataList![index]
                                                      .POCode
                                                      .toString(), // PO Code from dataList
                                                  poDate: dataList![index]
                                                          .PODate
                                                          .toString()
                                                          .split("T")[
                                                      0], // PO Date from dataList, formatted
                                                  department: dataList![index]
                                                      .Department
                                                      .toString(), // Department from dataList
                                                  status: dataList![index]
                                                      .POStatus
                                                      .toString(), // PO Status from dataList
                                                ),
                                              );
                                            });
                                      }
                                    }),
                                  )
                                ],
                              ),
                            ),
                            Center(
                              child: Column(
                                children: [
                                  const SizedBox(height: 30),
                                  Expanded(
                                    child: Builder(builder: (
                                      BuildContext context,
                                    ) {
                                      if (dataList == null) {
                                        return Center(
                                            child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              'assets/images/loaderr.gif',
                                              height: 200,
                                              width: 350,
                                            ),
                                            const Text('No records found')
                                          ],
                                        ));
                                      } else {
                                        return ListView.builder(
                                            itemCount: dataList!.length,
                                            itemBuilder: (context, index) {
                                              final POStatus = dataList![index]
                                                  .POStatus
                                                  .toString();
                                              final color =
                                                  POStatus == 'Rejected'
                                                      ? Colors.red
                                                      : POStatus == 'Approved'
                                                          ? Colors.green
                                                          : Colors.grey;
                                              return GestureDetector(
                                                onTap: () async {
                                                  final POStatus =
                                                      dataList![index]
                                                          .POStatus
                                                          .toString();
                                                  final color = POStatus ==
                                                          'Rejected'
                                                      ? Colors.red
                                                      : POStatus == 'Approved'
                                                          ? Colors.green
                                                          : Colors.grey;
                                                  String POTxnID =
                                                      dataList![index]
                                                          .POTxnID
                                                          .toString();

                                                  if (AppController.message !=
                                                      null) {
                                                    Get.defaultDialog(
                                                      title: "Oops!",
                                                      middleText:
                                                          "${AppController.message}",
                                                      textConfirm: "OK",
                                                      confirmTextColor:
                                                          Colors.white,
                                                      onConfirm: () {
                                                        Get.back(); // Close the dialog
                                                      },
                                                    );
                                                    return;
                                                  } else {
                                                    showPODialog(
                                                      dataList![index]
                                                          .POTxnID
                                                          .toString(),
                                                      dataList![index]
                                                          .VendorID
                                                          .toString(),
                                                    );
                                                  }
                                                },
                                                child: POListsNewCard(
                                                  ht: _height,
                                                  wd: _width,
                                                  duration: 500,
                                                  srNo: (index + 1)
                                                      .toString(), // SR No based on index
                                                  poTxnID: dataList![index]
                                                      .POTxnID
                                                      .toString(), // PO TxnID from dataList
                                                  prTxnID: dataList![index]
                                                      .PRTxnID
                                                      .toString(), // PR TxnID from dataList
                                                  poCode: dataList![index]
                                                      .POCode
                                                      .toString(), // PO Code from dataList
                                                  poDate: dataList![index]
                                                          .PODate
                                                          .toString()
                                                          .split("T")[
                                                      0], // PO Date from dataList, formatted
                                                  department: dataList![index]
                                                      .Department
                                                      .toString(), // Department from dataList
                                                  status: dataList![index]
                                                      .POStatus
                                                      .toString(), // PO Status from dataList
                                                ),
                                              );
                                            });
                                      }
                                    }),
                                  )
                                ],
                              ),
                            ),
                            Center(
                              child: Column(
                                children: [
                                  const SizedBox(height: 30),
                                  Expanded(
                                    child: Builder(builder: (
                                      BuildContext context,
                                    ) {
                                      if (dataList == null) {
                                        return Center(
                                            child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              'assets/images/loaderr.gif',
                                              height: 200,
                                              width: 350,
                                            ),
                                            const Text('No records found')
                                          ],
                                        ));
                                      } else {
                                        return ListView.builder(
                                            itemCount: dataList!.length,
                                            itemBuilder: (context, index) {
                                              final POStatus = dataList![index]
                                                  .POStatus
                                                  .toString();
                                              final color =
                                                  POStatus == 'Rejected'
                                                      ? Colors.red
                                                      : POStatus == 'Approved'
                                                          ? Colors.green
                                                          : Colors.grey;
                                              return GestureDetector(
                                                onTap: () async {
                                                  final POStatus =
                                                      dataList![index]
                                                          .POStatus
                                                          .toString();
                                                  final color = POStatus ==
                                                          'Rejected'
                                                      ? Colors.red
                                                      : POStatus == 'Approved'
                                                          ? Colors.green
                                                          : Colors.grey;
                                                  String POTxnID =
                                                      dataList![index]
                                                          .POTxnID
                                                          .toString();

                                                  if (AppController.message !=
                                                      null) {
                                                    Get.defaultDialog(
                                                      title: "Oops!",
                                                      middleText:
                                                          "${AppController.message}",
                                                      textConfirm: "OK",
                                                      confirmTextColor:
                                                          Colors.white,
                                                      onConfirm: () {
                                                        Get.back(); // Close the dialog
                                                      },
                                                    );
                                                    return;
                                                  } else {
                                                    showPODialog(
                                                      dataList![index]
                                                          .POTxnID
                                                          .toString(),
                                                      dataList![index]
                                                          .VendorID
                                                          .toString(),
                                                    );
                                                  }
                                                },
                                                child: POListsNewCard(
                                                  ht: _height,
                                                  wd: _width,
                                                  duration: 500,
                                                  srNo: (index + 1)
                                                      .toString(), // SR No based on index
                                                  poTxnID: dataList![index]
                                                      .POTxnID
                                                      .toString(), // PO TxnID from dataList
                                                  prTxnID: dataList![index]
                                                      .PRTxnID
                                                      .toString(), // PR TxnID from dataList
                                                  poCode: dataList![index]
                                                      .POCode
                                                      .toString(), // PO Code from dataList
                                                  poDate: dataList![index]
                                                          .PODate
                                                          .toString()
                                                          .split("T")[
                                                      0], // PO Date from dataList, formatted
                                                  department: dataList![index]
                                                      .Department
                                                      .toString(), // Department from dataList
                                                  status: dataList![index]
                                                      .POStatus
                                                      .toString(), // PO Status from dataList
                                                ),
                                              );
                                            });
                                      }
                                    }),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ]),
    );
  }
}

void showPODialog(String poTxnId, String vendorId) {
  final GetVendorMasterPdfController gvmpdfc =
      Get.put(GetVendorMasterPdfController());
  Get.defaultDialog(
    title: "PO Dialog",
    titleStyle: const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
    content: const Column(
      children: [
        Text(
          "Please choose one of the options below:",
          style: TextStyle(fontSize: 16, color: Colors.black54),
        ),
        SizedBox(height: 20),
      ],
    ),
    radius: 10, // Rounded corners for the dialog

    backgroundColor: Colors.white,
    actions: [
      ElevatedButton(
        onPressed: () {
          // Action for "View Item Group"
          Get.back(); // Close the dialog
          // Get.to(ViewPrDetailsScreen(
          //   prTxnId: int.parse(prTxnID),
          // ));
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.grey,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        ),
        child: const Text(
          "View Items",
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
      ),
      ElevatedButton(
        onPressed: () async {
          // Action for "Assign Item Group"
          Get.back(); // Close the dialog
          showCancelPODialog(poTxnId);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 215, 93, 56),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        ),
        child: const Text(
          "Cancel PO",
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
      ),
      ElevatedButton(
        onPressed: () async {
          // Action for "Assign Item Group"
          Get.back(); // Close the dialog
          Get.to(POAmendmentScreen(
            vendorID: vendorId,
            poTxnid: int.parse(poTxnId),
          ));
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        ),
        child: const Text(
          "View Ammendment",
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
      ),
    ],
  );
}

void showCancelPODialog(String poTxnId) {
  final CancelPoController cpoc = Get.put(CancelPoController());
  final TextEditingController remarkscontroller = TextEditingController();
  Get.defaultDialog(
    title: 'Cancel PO',
    titleStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    content: Column(
      children: [
        const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Remark',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: remarkscontroller,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            hintText: 'Please enter remark',
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.purple.shade200),
            ),
          ),
          maxLines: 3,
        ),
        const SizedBox(height: 20),
      ],
    ),
    confirm: Padding(
      padding: const EdgeInsets.only(bottom: 10.0, right: 10.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 214, 64, 54),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        ),
        onPressed: () {
          cpoc.cancelPo(int.parse(poTxnId), remarkscontroller.text.toString());
          Get.back(); // Close the dialog after action
        },
        child: const Text(
          'Cancel PO',
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
      ),
    ),
  );
}
