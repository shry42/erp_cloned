import 'package:erp_copy/controllers/app_controller.dart';
import 'package:erp_copy/controllers/pr_controllers/department_filter_controller.dart';
import 'package:erp_copy/controllers/pr_controllers/department_list_controller.dart';
import 'package:erp_copy/controllers/pr_controllers/pr_details_controller.dart';
import 'package:erp_copy/controllers/pr_controllers/pr_log_controller.dart';
import 'package:erp_copy/models/pr_models/department_filter_model.dart';
import 'package:erp_copy/screens/pr_screens/pr_item_details.dart';
import 'package:erp_copy/screens/pr_screens/pr_view_all.dart';
import 'package:erp_copy/widget/menu_widget/drawer_menu_widget.dart';
import 'package:erp_copy/widgets/pr_cards/dummy_pr_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';

class PrLogDetailsScreen extends StatefulWidget {
  const PrLogDetailsScreen({super.key, required this.openDrawer});
  final VoidCallback openDrawer;
  @override
  State<PrLogDetailsScreen> createState() => _PrLogDetailsScreenState();
}

class _PrLogDetailsScreenState extends State<PrLogDetailsScreen> {
  double _height = 180;

  dynamic _duration = 500;
  bool animated = false;
  final PrLogController prcont = PrLogController();
  final PrDetailsController prdetcon = PrDetailsController();
  final DepartmentListController depListCont =
      Get.put(DepartmentListController());
  final DepartmentFiterController depFilterCont = DepartmentFiterController();
  String newDep = 'production';
  TextEditingController searchController = TextEditingController();

  //
  List? mainDataList;
  List? searchDataList;
  List? dataList; // this will be used to display the ui

  @override
  void initState() {
    prcont;
    depFilterCont;
    WidgetsBinding.instance?.addPostFrameCallback((_) async {
      await depListCont.fetchDepList();
      await depFilterCont.fetchFilterDepList(newDep.toString()).then((value) {
        setState(() {
          dataList = value;
          mainDataList = value;
        });
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.sizeOf(context).height;
    double _width = MediaQuery.sizeOf(context).width * 0.90;

    // _height = h * 0.25;
    return WillPopScope(
      onWillPop: () async {
        return await Get.defaultDialog(
          backgroundColor: Colors.white,
          title: "Menu Screen?",
          middleText: "Are you sure want to go back?",
          textConfirm: 'Yes',
          textCancel: 'No',
          onConfirm: () async {
            // Get.offAll(const OptionScreen());
          },
          onCancel: () async {
            await depListCont.fetchDepList();
            // Get.offAll(
            //   const PrLogDetailsScreen(),
            // );
          },
        );
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 68, 168, 71),
          title: const Text(
            'PR Log Details',
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
        body: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
                child: SizedBox(
                  height: 35,
                  width: _width,
                  child: TextField(
                    style: const TextStyle(color: Colors.black),
                    controller: searchController,
                    onChanged: (value) {
                      if (value.isEmpty) {
                        setState(() {
                          dataList = mainDataList;
                          searchDataList = [];
                        });
                        return;
                      }
                      searchDataList = mainDataList
                          ?.where((element) => element.prTxnId
                              .toString()
                              .contains(value.toString()))
                          .toList();
                      setState(() {
                        dataList = searchDataList;
                      });
                    },
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.green),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
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
                      hintStyle: const TextStyle(fontSize: 12),
                      suffixIcon: const Icon(Icons.search),
                      // suffixIconColor: Colors.white,
                      prefixIconColor: Colors.black,
                    ),
                  ),
                ),
              ),
              // Padding(
              //   padding:
              //       const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
              //   child: Container(
              //     height: 35,
              //     width: 120,
              //     decoration: BoxDecoration(
              //       gradient: const LinearGradient(
              //         colors: <Color>[
              //           Color.fromARGB(243, 84, 86, 80),
              //           // Color.fromARGB(243, 77, 234, 88),
              //           Color.fromARGB(255, 234, 242, 232),
              //         ],
              //       ),
              //       borderRadius: BorderRadius.circular(10),
              //     ),
              //     child: const Center(
              //         child: Text(
              //       'Search History',
              //       style: TextStyle(color: Colors.white),
              //     )),
              //   ),
              // ),
            ],
          ),
          // const SizedBox(height: 6),
          // SizedBox(
          //   height: 45,
          //   width: 360,
          //   child: TextField(
          //     controller: searchController,
          //     onChanged: (value) {
          //       if (value.isEmpty) {
          //         setState(() {
          //           dataList = mainDataList;
          //           searchDataList = [];
          //         });
          //         return;
          //       }
          //       searchDataList = mainDataList
          //           ?.where((element) =>
          //               element.prTxnId.toString().contains(value.toString()))
          //           .toList();
          //       setState(() {
          //         dataList = searchDataList;
          //       });
          //     },
          //     decoration: InputDecoration(
          //       filled: true,
          //       fillColor: const Color(0xfff1f1f1),
          //       border: OutlineInputBorder(
          //         borderRadius: BorderRadius.circular(8),
          //         borderSide: BorderSide.none,
          //       ),
          //       hintText: "Search for PrTxnId",
          //       prefixIcon: const Icon(Icons.search),
          //       prefixIconColor: Colors.black,
          //     ),
          //   ),
          // ),

          /////////////
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.to(const PRViewAllDetails());
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center(
                          child: Text(
                            'View All Purchase Request',
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: 12,
                              decoration: TextDecoration.underline,
                              decorationColor: Colors.green,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 5),
                  SizedBox(
                    width: 150,
                    height: 28,
                    child: DropdownButtonFormField<String>(
                      dropdownColor: Colors.white,
                      value: 'production',
                      style: const TextStyle(fontSize: 12, color: Colors.black),
                      // value: 'Management',
                      borderRadius: BorderRadius.circular(20),
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.green),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 20.0),
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          searchController.clear();
                          mainDataList = null;
                          searchDataList = null;
                          dataList = null;
                        });
                        // Implement department dropdown functionality here
                        depFilterCont
                            .fetchFilterDepList(newValue.toString())
                            .then((List<DepartmentFilterModel>? value) {
                          setState(() {
                            newDep = newValue.toString();
                            mainDataList = value ?? [];
                            dataList = value ?? [];
                          });
                        });
                      },
                      items: depListCont.depList.map((item) {
                        return DropdownMenuItem(
                          value: item.depName.toString(),
                          child: Text(item.depName.toString()),
                        );
                      }).toList(),
                    ),
                  ),
                ]),
          ),

          Expanded(
            child: Builder(
                // future: prcont.getPrDetails(),   for all data
                // future: depFilterCont.fetchFilterDepList(newDep.toString()),
                // future: newDep == 'all'
                //     ? prcont.getPrDetails()
                //     : depFilterCont.fetchFilterDepList(newDep.toString()),  //for all data
                builder: (
              BuildContext ctx,
            ) {
              if (dataList == null || dataList!.isEmpty) {
                return Center(
                  child: Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/loaderr.gif',
                        height: 200,
                        width: 250,
                      ),
                      const Text('No records found')
                    ],
                  )),
                );
              } else {
                return AnimationLimiter(
                  child: ListView.builder(
                    itemCount: dataList!.length,
                    itemBuilder: (ctx, index) => GestureDetector(
                      onTap: () async {
                        String PrTxnId = dataList![index].prTxnId.toString();
                        await prdetcon.getPrDetails(PrTxnId);
                        if (AppController.message != null) {
                          Get.defaultDialog(
                            title: "Oops!",
                            middleText: "${AppController.message}",
                            textConfirm: "OK",
                            confirmTextColor: Colors.white,
                            onConfirm: () {
                              Get.back(); // Close the dialog
                            },
                          );
                          return;
                        } else {
                          Get.to(PrItemDetails(PrTxnId: PrTxnId),
                              transition: Transition.rightToLeft);
                        }
                      },
                      child: AnimationConfiguration.staggeredList(
                        position: index,
                        duration: const Duration(milliseconds: 375),
                        child: SlideAnimation(
                          verticalOffset: 200.0,
                          // child: PRInfoCard(
                          //   PRTxnID: dataList![index].prTxnId.toString(),
                          //   TxnDate: dataList![index].txnDate.split("T")[0],
                          //   ReqDate: dataList![index].reqDate.split("T")[0],
                          //   ProjectCode: dataList![index].projectCode,
                          //   PRStatus: dataList![index].prStatus,
                          //   userName: dataList![index].username,
                          //   // ht: _height,
                          //   ht: h * 0.27,
                          //   wd: _width,
                          //   duration: _duration,
                          // ),
                          child: PRLogCards(
                            PRTxnID: dataList![index].prTxnId.toString(),
                            PRTxnDate: dataList![index].txnDate.split("T")[0],
                            ReqDate: dataList![index].reqDate.split("T")[0],
                            ProjectCode: dataList![index].projectCode,
                            PRStatus: dataList![index].prStatus,
                            UserName: dataList![index].username,
                            // ht: _height,
                            ht: h * 0.27,
                            wd: _width,
                            duration: _duration,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }
            }),
          ),
        ]),
      ),
    );
  }
}
