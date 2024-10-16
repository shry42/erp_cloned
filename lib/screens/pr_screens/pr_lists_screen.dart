import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:erp_copy/controllers/app_controller.dart';
import 'package:erp_copy/controllers/po_controllers/vendor_details_controller.dart';
import 'package:erp_copy/controllers/pr_controllers/pr_log_controller.dart';
import 'package:erp_copy/controllers/vendor_master_controller/vendor_list_pdf_controller.dart';
import 'package:erp_copy/screens/pr_screens/pr_view_item_screen.dart';
import 'package:erp_copy/widget/menu_widget/drawer_menu_widget.dart';
import 'package:erp_copy/widgets/pr_cards/pre_new_all_list_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:get/get.dart';

class PRListsScreen extends StatefulWidget {
  const PRListsScreen({
    super.key,
    required this.openDrawer,
  });
  final VoidCallback openDrawer;

  @override
  State<PRListsScreen> createState() => _PRListsScreenState();
}

class _PRListsScreenState extends State<PRListsScreen> {
  // double _height = 120;
  // double _width = 350;
  bool isPOSelected = true;
  dynamic? _duration = 500;
  bool animated = false;
  List<dynamic>? dataList;
  List? searchDataList;
  List? mainDataList;
  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 0;

  bool showApproved = true;

  final PrLogController prLogDeatailsCont = Get.put(PrLogController());
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
    prLogDeatailsCont;

    WidgetsBinding.instance?.addPostFrameCallback((_) async {
      await prLogDeatailsCont.getPrDetails().then((value) {
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
                'PR Lists',
                style: TextStyle(color: Colors.white),
              ),
              const SizedBox(width: 95),
              // GestureDetector(
              //   onTap: () {
              //     widget.openDrawer;
              //   },
              //   child: const Icon(
              //     Icons.menu_open_rounded,
              //     size: 35,
              //     color: Colors.white,
              //   ),
              // ),
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
                    width: _width,
                    child: TextField(
                      style: const TextStyle(color: Colors.black),
                      controller: searchController,
                      onChanged: (value) {
                        setState(() {
                          if (value.isEmpty) {
                            dataList = searchDataList; // Reset to show all data
                          } else {
                            dataList = searchDataList
                                ?.where((element) => element.prTxnId
                                    .toString()
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
                        hintText: "Search for PrTxnId",
                        hintStyle:
                            const TextStyle(fontSize: 12, color: Colors.grey),
                        suffixIcon: const Icon(Icons.search),
                        // suffixIconColor: Colors.white,
                        prefixIconColor: Colors.black,
                      ),
                    ),
                  ),
                ),
                // const SizedBox(width: 20),
                // Container(
                //   height: 35,
                //   width: 150,
                //   decoration: BoxDecoration(
                //     gradient: const LinearGradient(
                //       colors: <Color>[
                //         Color.fromARGB(243, 84, 86, 80),
                //         // Color.fromARGB(243, 77, 234, 88),
                //         Color.fromARGB(255, 234, 242, 232),
                //       ],
                //     ),
                //     borderRadius: BorderRadius.circular(10),
                //   ),
                //   child: const Center(
                //       child: Text(
                //     'Search History',
                //     style: TextStyle(color: Colors.white),
                //   )),
                // ),
              ],
            ),
            const SizedBox(height: 6),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: DefaultTabController(
                  length: 4,
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
                                  ?.where((element) => element.approvalStatus
                                      .toString()
                                      .contains('true'.toString()))
                                  .toList();
                              searchDataList = dataList;
                              searchController.clear();
                            });
                          } else if (index == 2) {
                            setState(() {
                              dataList = mainDataList
                                  ?.where((element) => element.prStatus
                                      .toString()
                                      .contains('PR Short Closed'.toString()))
                                  .toList();
                              searchDataList = dataList;
                              searchController.clear();
                            });
                          } else if (index == 3) {
                            setState(() {
                              dataList = mainDataList
                                  ?.where((element) => element.prStatus
                                      .toString()
                                      .contains('Approval Pending'.toString()))
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
                            text: "All",
                          ),
                          Tab(
                            // icon: Icon(Icons.approval),
                            text: "Approved",
                          ),
                          Tab(
                            // icon: Icon(Icons.wrong_location_rounded),
                            text: "Short closed",
                          ),
                          Tab(
                            // icon: Icon(Icons.pending),
                            text: "Pending",
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
                                              final prStatus = dataList![index]
                                                  .prStatus
                                                  .toString();
                                              final color =
                                                  prStatus == 'Rejected'
                                                      ? Colors.red
                                                      : prStatus == 'Approved'
                                                          ? Colors.green
                                                          : Colors.grey;
                                              return GestureDetector(
                                                onTap: () async {
                                                  final prStatus =
                                                      dataList![index]
                                                          .prStatus
                                                          .toString();
                                                  final color = prStatus ==
                                                          'Rejected'
                                                      ? Colors.red
                                                      : prStatus == 'Approved'
                                                          ? Colors.green
                                                          : Colors.grey;
                                                  String PrTxnId =
                                                      dataList![index]
                                                          .prTxnId
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
                                                    showPRDialog(
                                                        dataList![index]
                                                            .prTxnId);
                                                  }
                                                },
                                                child: PRListsNewCard(
                                                  ht: _height,
                                                  wd: _width,
                                                  duration: 500,
                                                  prTxnID: dataList![index]
                                                      .prTxnId
                                                      .toString(), // PR Txn ID
                                                  txnDate: dataList![index]
                                                      .txnDate
                                                      .toString()
                                                      .split(
                                                          "T")[0], // Txn Date
                                                  requestDate: dataList![index]
                                                          .reqDate
                                                          .toString()
                                                          .split("T")[
                                                      0], // Request Date
                                                  projectCode: dataList![index]
                                                      .projectCode
                                                      .toString(), // Project Code
                                                  department: dataList![index]
                                                      .department
                                                      .toString(), // Department
                                                  approvalStatus: dataList![
                                                          index]
                                                      .approvalStatus
                                                      .toString(), // Approval Status
                                                  approvedAt: dataList![index]
                                                          .approvedAt
                                                          .toString()
                                                          .split("T")[
                                                      0], // Approved At
                                                  prStatus: dataList![index]
                                                      .prStatus
                                                      .toString(), // PR Status
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
                                  SizedBox(height: 30),
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
                                              width: 250,
                                            ),
                                            const Text('No records found')
                                          ],
                                        ));
                                      } else {
                                        return ListView.builder(
                                            itemCount: dataList!.length,
                                            itemBuilder: (context, index) {
                                              return GestureDetector(
                                                onTap: () async {
                                                  final poStatus =
                                                      dataList![index]
                                                          .POStatus
                                                          .toString();
                                                  final color = poStatus ==
                                                          'Rejected'
                                                      ? Colors.red
                                                      : poStatus == 'Approved'
                                                          ? Colors.green
                                                          : Colors.grey;
                                                  String PoTxnId =
                                                      dataList![index]
                                                          .POTxnID
                                                          .toString();
                                                  String VendorID =
                                                      dataList![index]
                                                          .VendorID
                                                          .toString();
                                                  await vendorCont
                                                      .getVendorById(
                                                          VendorID, PoTxnId);

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
                                                    showPRDialog(
                                                        dataList![index]
                                                            .prTxnId);
                                                  }
                                                },
                                                // child: POInfoCard(
                                                //   ht: _height,
                                                //   wd: _width,
                                                //   duration: 500,
                                                //   POTxnID: dataList![index]
                                                //       .POTxnID
                                                //       .toString(),
                                                //   POCode: dataList![index]
                                                //       .POCode
                                                //       .toString(),
                                                //   PODate: dataList![index]
                                                //       .PODate
                                                //       .toString()
                                                //       .split("T")[0],
                                                //   poStatus: dataList![index]
                                                //       .POStatus
                                                //       .toString(),
                                                // ),
                                                child: PRListsNewCard(
                                                  ht: _height,
                                                  wd: _width,
                                                  duration: 500,
                                                  prTxnID: dataList![index]
                                                      .prTxnId
                                                      .toString(), // PR Txn ID
                                                  txnDate: dataList![index]
                                                      .txnDate
                                                      .toString()
                                                      .split(
                                                          "T")[0], // Txn Date
                                                  requestDate: dataList![index]
                                                          .reqDate
                                                          .toString()
                                                          .split("T")[
                                                      0], // Request Date
                                                  projectCode: dataList![index]
                                                      .projectCode
                                                      .toString(), // Project Code
                                                  department: dataList![index]
                                                      .department
                                                      .toString(), // Department
                                                  approvalStatus: dataList![
                                                          index]
                                                      .approvalStatus
                                                      .toString(), // Approval Status
                                                  approvedAt: dataList![index]
                                                          .approvedAt
                                                          .toString()
                                                          .split("T")[
                                                      0], // Approved At
                                                  prStatus: dataList![index]
                                                      .prStatus
                                                      .toString(), // PR Status
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
                                  SizedBox(height: 30),
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
                                              width: 250,
                                            ),
                                            const Text('No records found')
                                          ],
                                        ));
                                      } else {
                                        return ListView.builder(
                                            itemCount: dataList!.length,
                                            itemBuilder: (context, index) {
                                              return GestureDetector(
                                                onTap: () async {
                                                  String PoTxnId =
                                                      dataList![index]
                                                          .POTxnID
                                                          .toString();
                                                  String VendorID =
                                                      dataList![index]
                                                          .VendorID
                                                          .toString();
                                                  await vendorCont
                                                      .getVendorById(
                                                          VendorID, PoTxnId);
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
                                                    showPRDialog(
                                                        dataList![index]
                                                            .prTxnId);
                                                  }
                                                },
                                                // child: POInfoCard(
                                                //   ht: _height,
                                                //   wd: _width,
                                                //   duration: 500,
                                                //   POTxnID: dataList![index]
                                                //       .POTxnID
                                                //       .toString(),
                                                //   POCode: dataList![index]
                                                //       .POCode
                                                //       .toString(),
                                                //   PODate: dataList![index]
                                                //       .PODate
                                                //       .toString()
                                                //       .split("T")[0],
                                                //   poStatus: dataList![index]
                                                //       .POStatus
                                                //       .toString(),
                                                // ),
                                                child: PRListsNewCard(
                                                  ht: _height,
                                                  wd: _width,
                                                  duration: 500,
                                                  prTxnID: dataList![index]
                                                      .prTxnId
                                                      .toString(), // PR Txn ID
                                                  txnDate: dataList![index]
                                                      .txnDate
                                                      .toString()
                                                      .split(
                                                          "T")[0], // Txn Date
                                                  requestDate: dataList![index]
                                                          .reqDate
                                                          .toString()
                                                          .split("T")[
                                                      0], // Request Date
                                                  projectCode: dataList![index]
                                                      .projectCode
                                                      .toString(), // Project Code
                                                  department: dataList![index]
                                                      .department
                                                      .toString(), // Department
                                                  approvalStatus: dataList![
                                                          index]
                                                      .approvalStatus
                                                      .toString(), // Approval Status
                                                  approvedAt: dataList![index]
                                                          .approvedAt
                                                          .toString()
                                                          .split("T")[
                                                      0], // Approved At
                                                  prStatus: dataList![index]
                                                      .prStatus
                                                      .toString(), // PR Status
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
                                  SizedBox(height: 30),
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
                                              width: 250,
                                            ),
                                            const Text('No records found')
                                          ],
                                        ));
                                      } else {
                                        return ListView.builder(
                                            itemCount: dataList!.length,
                                            itemBuilder: (context, index) {
                                              return GestureDetector(
                                                onTap: () async {
                                                  String PoTxnId =
                                                      dataList![index]
                                                          .POTxnID
                                                          .toString();
                                                  String VendorID =
                                                      dataList![index]
                                                          .VendorID
                                                          .toString();
                                                  await vendorCont
                                                      .getVendorById(
                                                          VendorID, PoTxnId);
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
                                                    showPRDialog(
                                                        dataList![index]
                                                            .prTxnId);
                                                  }
                                                },
                                                // child: POInfoCard(
                                                //   ht: _height,
                                                //   wd: _width,
                                                //   duration: 500,
                                                //   POTxnID: dataList![index]
                                                //       .POTxnID
                                                //       .toString(),
                                                //   POCode: dataList![index]
                                                //       .POCode
                                                //       .toString(),
                                                //   PODate: dataList![index]
                                                //       .PODate
                                                //       .toString()
                                                //       .split("T")[0],
                                                //   poStatus: dataList![index]
                                                //       .POStatus
                                                //       .toString(),
                                                // ),
                                                child: PRListsNewCard(
                                                  ht: _height,
                                                  wd: _width,
                                                  duration: 500,
                                                  prTxnID: dataList![index]
                                                      .prTxnId
                                                      .toString(), // PR Txn ID
                                                  txnDate: dataList![index]
                                                      .txnDate
                                                      .toString()
                                                      .split(
                                                          "T")[0], // Txn Date
                                                  requestDate: dataList![index]
                                                          .reqDate
                                                          .toString()
                                                          .split("T")[
                                                      0], // Request Date
                                                  projectCode: dataList![index]
                                                      .projectCode
                                                      .toString(), // Project Code
                                                  department: dataList![index]
                                                      .department
                                                      .toString(), // Department
                                                  approvalStatus: dataList![
                                                          index]
                                                      .approvalStatus
                                                      .toString(), // Approval Status
                                                  approvedAt: dataList![index]
                                                          .approvedAt
                                                          .toString()
                                                          .split("T")[
                                                      0], // Approved At
                                                  prStatus: dataList![index]
                                                      .prStatus
                                                      .toString(), // PR Status
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

void showPRDialog(int prTxnID) {
  final GetVendorMasterPdfController gvmpdfc =
      Get.put(GetVendorMasterPdfController());
  Get.defaultDialog(
    title: "PR Dialog",
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
          Get.to(ViewPrDetailsScreen(
            prTxnId: prTxnID,
          ));
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
          await gvmpdfc.getVednorMaster(prTxnID, 'PRTxnID');
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        ),
        child: const Text(
          "View Documents",
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
      ),
    ],
  );
}
