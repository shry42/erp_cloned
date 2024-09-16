import 'package:erp_copy/controllers/menu_controllers/get_master_sub_menu_list_controller.dart';
import 'package:erp_copy/widgets/menu_cards/sub_master_menu_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MasterSubMenulistScreen extends StatefulWidget {
  const MasterSubMenulistScreen({
    super.key,
    required this.id,
  });

  final int id;

  @override
  State<MasterSubMenulistScreen> createState() =>
      _MasterSubMenulistScreenState();
}

class _MasterSubMenulistScreenState extends State<MasterSubMenulistScreen> {
  TextEditingController searchController = TextEditingController();

  final GetMasterSubMenulistController gmsmlc =
      GetMasterSubMenulistController(); //used for updating also just by changing isActive value

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 68, 168, 71),
        automaticallyImplyLeading: true,
        actions: [
          const Text(
            ' Master Sub Menu List',
            style: TextStyle(color: Colors.white, fontSize: 15),
          ),
          const SizedBox(width: 130),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 6),
            FutureBuilder(
              future: gmsmlc.getMasterSubMenuList(widget.id),
              builder: (BuildContext ctx, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                } else if (snapshot.data.length == null) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  // Handle your snapshot data here
                  return SizedBox(
                    height: MediaQuery.of(context).size.height * 0.6,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        var subMenuName = snapshot.data[index].subMenuName;
                        var subMenuUrl = snapshot.data[index].subMenuUrl;
                        return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: MasterSubMenulistCard(
                              ht: 120,
                              wd: 300,
                              duration: 200,
                              subMenuName: subMenuName,
                              subMenuUrl: subMenuUrl,
                            ));
                      },
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
