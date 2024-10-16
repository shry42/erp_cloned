import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:erp_copy/controllers/app_controller.dart';
import 'package:erp_copy/controllers/po_controllers/po_log_controller.dart';
import 'package:erp_copy/controllers/po_controllers/vendor_details_controller.dart';
import 'package:erp_copy/screens/po_screens/po_vendor_details_screen.dart';
import 'package:erp_copy/widget/menu_widget/drawer_menu_widget.dart';
import 'package:erp_copy/widgets/po_cards/dummy_po_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:get/get.dart';

class PoLogDetailsScreen extends StatefulWidget {
  const PoLogDetailsScreen({
    super.key,
    required this.openDrawer,
  });
  final VoidCallback openDrawer;

  @override
  State<PoLogDetailsScreen> createState() => _PoLogDetailsScreenState();
}

class _PoLogDetailsScreenState extends State<PoLogDetailsScreen> {
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

  final PoLogDetailsController poLogDeatailsCont = PoLogDetailsController();
  final VenodorDetailsController vendorCont = VenodorDetailsController();
  TextEditingController searchController = TextEditingController();

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
    double _height = MediaQuery.sizeOf(context).height * 0.18;
    double _width = MediaQuery.sizeOf(context).width * 0.90;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 68, 168, 71),
        title: const Text(
          'PO Log Details',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        centerTitle: true, // Centers the title
        leading: GestureDetector(
          onTap: () {
            Get.back(); // Navigates back on tap
          },
          child: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
            size: 30,
          ),
        ),
        actions: [
          DrawerMenuWidget(
            onClicked: widget.openDrawer, // Custom drawer menu action
          ),
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
                                  ?.where((element) =>
                                      element.POStatus.toString()
                                          .contains('Approved'.toString()))
                                  .toList();
                              searchDataList = dataList;
                              searchController.clear();
                            });
                          } else if (index == 2) {
                            setState(() {
                              dataList = mainDataList
                                  ?.where((element) =>
                                      element.POStatus.toString()
                                          .contains('Rejected'.toString()))
                                  .toList();
                              searchDataList = dataList;
                              searchController.clear();
                            });
                          } else if (index == 3) {
                            setState(() {
                              dataList = mainDataList
                                  ?.where((element) =>
                                      element.POStatus.toString().contains(
                                          'Approval Pending'.toString()))
                                  .toList();
                              searchDataList = dataList;
                              searchController.clear();
                            });
                          }
                        },
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 10),
                        unselectedBackgroundColor:
                            Color.fromARGB(255, 125, 141, 122),
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
                            text: "Rejected",
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
                                              final poStatus = dataList![index]
                                                  .POStatus
                                                  .toString();
                                              final color =
                                                  poStatus == 'Rejected'
                                                      ? Colors.red
                                                      : poStatus == 'Approved'
                                                          ? Colors.green
                                                          : Colors.grey;
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
                                                    Get.to(VendorDetailsScreen(
                                                        POTxnID: PoTxnId,
                                                        VendorID: VendorID));
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
                                                child: POLogCards(
                                                  POTxnID: dataList![index]
                                                      .POTxnID
                                                      .toString(),
                                                  POCode: dataList![index]
                                                      .POCode
                                                      .toString(),
                                                  PODate: dataList![index]
                                                      .PODate
                                                      .toString()
                                                      .split("T")[0],
                                                  poStatus: dataList![index]
                                                      .POStatus
                                                      .toString(),
                                                  color: color,
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
                                                    Get.to(VendorDetailsScreen(
                                                        POTxnID: PoTxnId,
                                                        VendorID: VendorID));
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
                                                child: POLogCards(
                                                  POTxnID: dataList![index]
                                                      .POTxnID
                                                      .toString(),
                                                  POCode: dataList![index]
                                                      .POCode
                                                      .toString(),
                                                  PODate: dataList![index]
                                                      .PODate
                                                      .toString()
                                                      .split("T")[0],
                                                  poStatus: dataList![index]
                                                      .POStatus
                                                      .toString(),
                                                  // color: color,
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
                                                    Get.to(VendorDetailsScreen(
                                                        POTxnID: PoTxnId,
                                                        VendorID: VendorID));
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
                                                child: POLogCards(
                                                  POTxnID: dataList![index]
                                                      .POTxnID
                                                      .toString(),
                                                  POCode: dataList![index]
                                                      .POCode
                                                      .toString(),
                                                  PODate: dataList![index]
                                                      .PODate
                                                      .toString()
                                                      .split("T")[0],
                                                  poStatus: dataList![index]
                                                      .POStatus
                                                      .toString(),
                                                  // color: color,
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
                                                    Get.to(VendorDetailsScreen(
                                                        POTxnID: PoTxnId,
                                                        VendorID: VendorID));
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
                                                child: POLogCards(
                                                  POTxnID: dataList![index]
                                                      .POTxnID
                                                      .toString(),
                                                  POCode: dataList![index]
                                                      .POCode
                                                      .toString(),
                                                  PODate: dataList![index]
                                                      .PODate
                                                      .toString()
                                                      .split("T")[0],
                                                  poStatus: dataList![index]
                                                      .POStatus
                                                      .toString(),
                                                  // color: color,
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
        // Positioned(
        //   bottom: 0,
        //   left: 10,
        //   child: Container(
        //     height: 120,
        //     width: 430,
        //     color: Colors.white,
        //     child: Row(
        //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //       children: [
        //         ElevatedButton(
        //           onPressed: () {
        //             setState(() {
        //               isPOSelected = true;
        //             });
        //           },
        //           style: ElevatedButton.styleFrom(
        //             backgroundColor: isPOSelected ? Colors.green : Colors.grey,
        //             shape: RoundedRectangleBorder(
        //               borderRadius: BorderRadius.circular(12.0),
        //             ),
        //           ),
        //           child: const Text(
        //             "purchase order",
        //             style: TextStyle(color: Colors.white),
        //           ),
        //         ),
        //         ElevatedButton(
        //           onPressed: () {
        //             // setState(() {
        //             //   isPOSelected = false;
        //             // });
        //             (PrLogDetailsScreen(openDrawer: opneDrawer));
        //           },
        //           style: ElevatedButton.styleFrom(
        //             backgroundColor: isPOSelected ? Colors.grey : Colors.green,
        //             shape: RoundedRectangleBorder(
        //               borderRadius: BorderRadius.circular(12.0),
        //             ),
        //           ),
        //           child: const Text(
        //             "purchase request",
        //             style: TextStyle(color: Colors.white),
        //           ),
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
      ]),
    );
  }
}
