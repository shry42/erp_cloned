import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:erp_copy/controllers/app_controller.dart';
import 'package:erp_copy/controllers/po_controllers/vendor_details_controller.dart';
import 'package:erp_copy/controllers/pr_controllers/pr_details_controller.dart';
import 'package:erp_copy/controllers/pr_controllers/pr_log_controller.dart';
import 'package:erp_copy/screens/pr_screens/pr_item_details.dart';
import 'package:erp_copy/widgets/pr_cards/pr_view_all_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class PRViewAllDetails extends StatefulWidget {
  const PRViewAllDetails({super.key});

  @override
  State<PRViewAllDetails> createState() => _PRViewAllDetailsState();
}

class _PRViewAllDetailsState extends State<PRViewAllDetails> {
  double _height = 150;
  double _width = 400;
  dynamic? _duration = 500;
  bool animated = false;
  List<dynamic>? dataList;
  List? searchDataList;
  List? mainDataList;

  bool showApproved = true;

  final PrLogController prcont = PrLogController();
  final PrDetailsController prdetcon = PrDetailsController();
  final VenodorDetailsController vendorCont = VenodorDetailsController();
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    dataList; //Initialize as empty or else data will not be displayed until tapped on searchbar
    // prcont.getPrDetails();   //   for all data;
    WidgetsBinding.instance?.addPostFrameCallback((_) async {
      await prcont.getPrDetails().then((value) {
        setState(() {
          dataList = value;
          mainDataList = value;
          searchDataList = value;
        });
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.sizeOf(context).height;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        // title: const Text('UnApproved PO selection'),
        title: const Text('All PR Details'),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 45,
            width: 360,
            child: TextField(
              controller: searchController,
              onChanged: (value) {
                setState(() {
                  if (value.isEmpty) {
                    // dataList = searchDataList; // Reset to show all data
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
                filled: true,
                fillColor: const Color(0xfff1f1f1),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                hintText: "Search for PrTxnId",
                prefixIcon: const Icon(Icons.search),
                prefixIconColor: Colors.black,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
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
                              ?.where((element) => element.prStatus
                                  .toString()
                                  .contains('OPEN PR'.toString()))
                              .toList();
                          searchDataList = dataList;
                          searchController.clear();
                        });
                      } else if (index == 2) {
                        setState(() {
                          dataList = mainDataList
                              ?.where((element) => element.prStatus
                                  .toString()
                                  .contains('PR Rejected'.toString()))
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
                        horizontal: 10, vertical: 10),
                    unselectedBackgroundColor: Colors.grey[300],
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: <Color>[
                          Color.fromARGB(243, 84, 86, 80),
                          // Color.fromARGB(243, 77, 234, 88),
                          Color.fromARGB(255, 151, 223, 126),
                        ],
                      ),
                    ),
                    unselectedLabelStyle: const TextStyle(color: Colors.black),
                    labelStyle: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    tabs: const [
                      Tab(
                        icon: Icon(Icons.all_inbox),
                        text: "All",
                      ),
                      Tab(
                        icon: Icon(Icons.approval),
                        text: "Approved",
                      ),
                      Tab(
                        icon: Icon(Icons.wrong_location_rounded),
                        text: "Rejected",
                      ),
                      Tab(
                        icon: Icon(Icons.pending),
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
                                          width: 250,
                                        ),
                                        const Text('No records found'),
                                      ],
                                    ));
                                  } else {
                                    return ListView.builder(
                                        // reverse: true,
                                        itemCount: dataList!.length,
                                        itemBuilder: (context, index) {
                                          return GestureDetector(
                                            onTap: () async {
                                              String PrTxnId = dataList![index]
                                                  .prTxnId
                                                  .toString();
                                              await prdetcon
                                                  .getPrDetails(PrTxnId);
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
                                                Get.to(
                                                    PrItemDetails(
                                                        PrTxnId: PrTxnId),
                                                    transition:
                                                        Transition.rightToLeft);
                                              }
                                            },
                                            // child: PRViewAllCard(
                                            //   PRTxnID: dataList![index]
                                            //       .prTxnId
                                            //       .toString(),
                                            //   TxnDate: dataList![index]
                                            //       .txnDate
                                            //       .split("T")[0],
                                            //   ReqDate: dataList![index]
                                            //       .reqDate
                                            //       .split("T")[0],
                                            //   ProjectCode:
                                            //       dataList![index].projectCode,
                                            //   PRStatus:
                                            //       dataList![index].prStatus,
                                            //   // ht: _height,
                                            //   ht: h * 0.23,
                                            //   wd: _width,
                                            //   duration: _duration,
                                            // ),
                                            child: PRViewAllCards(
                                              PRTxnID: dataList![index]
                                                  .prTxnId
                                                  .toString(),
                                              PRTxnDate: dataList![index]
                                                  .txnDate
                                                  .split("T")[0],
                                              ReqDate: dataList![index]
                                                  .reqDate
                                                  .split("T")[0],
                                              ProjectCode:
                                                  dataList![index].projectCode,
                                              PRStatus:
                                                  dataList![index].prStatus,

                                              // ht: _height,
                                              ht: h * 0.27,
                                              wd: _width,
                                              duration: _duration,
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
                                              String PrTxnId = dataList![index]
                                                  .prTxnId
                                                  .toString();
                                              await prdetcon
                                                  .getPrDetails(PrTxnId);
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
                                                Get.to(
                                                    PrItemDetails(
                                                        PrTxnId: PrTxnId),
                                                    transition:
                                                        Transition.rightToLeft);
                                              }
                                            },
                                            child: PRViewAllCards(
                                              PRTxnID: dataList![index]
                                                  .prTxnId
                                                  .toString(),
                                              PRTxnDate: dataList![index]
                                                  .txnDate
                                                  .split("T")[0],
                                              ReqDate: dataList![index]
                                                  .reqDate
                                                  .split("T")[0],
                                              ProjectCode:
                                                  dataList![index].projectCode,
                                              PRStatus:
                                                  dataList![index].prStatus,
                                              // ht: _height,
                                              ht: h * 0.23,

                                              wd: _width,
                                              duration: _duration,
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
                                              String PrTxnId = dataList![index]
                                                  .prTxnId
                                                  .toString();
                                              await prdetcon
                                                  .getPrDetails(PrTxnId);
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
                                                Get.to(
                                                    PrItemDetails(
                                                        PrTxnId: PrTxnId),
                                                    transition:
                                                        Transition.rightToLeft);
                                              }
                                            },
                                            child: PRViewAllCards(
                                              PRTxnID: dataList![index]
                                                  .prTxnId
                                                  .toString(),
                                              PRTxnDate: dataList![index]
                                                  .txnDate
                                                  .split("T")[0],
                                              ReqDate: dataList![index]
                                                  .reqDate
                                                  .split("T")[0],
                                              ProjectCode:
                                                  dataList![index].projectCode,
                                              PRStatus:
                                                  dataList![index].prStatus,
                                              // ht: _height,
                                              ht: h * 0.23,

                                              wd: _width,
                                              duration: _duration,
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
                                              String PrTxnId = dataList![index]
                                                  .prTxnId
                                                  .toString();
                                              await prdetcon
                                                  .getPrDetails(PrTxnId);
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
                                                Get.to(
                                                    PrItemDetails(
                                                        PrTxnId: PrTxnId),
                                                    transition:
                                                        Transition.rightToLeft);
                                              }
                                            },
                                            child: PRViewAllCards(
                                              PRTxnID: dataList![index]
                                                  .prTxnId
                                                  .toString(),
                                              PRTxnDate: dataList![index]
                                                  .txnDate
                                                  .split("T")[0],
                                              ReqDate: dataList![index]
                                                  .reqDate
                                                  .split("T")[0],
                                              ProjectCode:
                                                  dataList![index].projectCode,
                                              PRStatus:
                                                  dataList![index].prStatus,
                                              // ht: _height,
                                              ht: h * 0.23,

                                              wd: _width,
                                              duration: _duration,
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
        ],
      ),
    );
  }
}
