import 'package:erp_copy/controllers/po_controllers/po_details_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PoByItemDetailsScreen extends StatefulWidget {
  final String PoTxnID;
  PoByItemDetailsScreen({
    super.key,
    required this.PoTxnID,
  });

  @override
  State<PoByItemDetailsScreen> createState() => _PoByItemDetailsScreenState();
}

class _PoByItemDetailsScreenState extends State<PoByItemDetailsScreen> {
  double _height = 560;
  double _width = 400;
  dynamic? _duration = 500;
  bool animated = false;

  final PoDetailsSelectByItemIdController poBySelectItemCont =
      PoDetailsSelectByItemIdController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Purchase Order Items'),
      ),
      body: FutureBuilder(
        future: poBySelectItemCont.getPoDetailsById(widget.PoTxnID),
        builder: (BuildContext ctx, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
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
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (ctx, index) {
                  // return PoItemInfoCard(
                  //   ht: _height,
                  //   wd: _width,
                  //   duration: _duration,
                  //   PODetailsID: snapshot.data[index].PODetailsID.toString(),
                  //   POTxnID: snapshot.data[index].POTxnID.toString(),
                  //   ItemID: snapshot.data[index].ItemID.toString(),
                  //   SAPID: snapshot.data[index].SAPID.toString(),
                  //   ItemName: snapshot.data[index].ItemName.toString(),
                  //   HSN_Code: snapshot.data[index].HSN_Code.toString(),
                  //   POQty: snapshot.data[index].POQty.toString(),
                  //   PurchaseUOM: snapshot.data[index].PurchaseUOM.toString(),
                  //   DeliveryDate: snapshot.data[index].DeliveryDate.toString(),
                  //   UnitPrice: snapshot.data[index].UnitPrice.toString(),
                  //   TaxCode: snapshot.data[index].TaxCode.toString(),
                  //   TaxPercent: snapshot.data[index].TaxPercent.toString(),
                  //   LineTotal: snapshot.data[index].LineTotal.toString(),
                  //   TaxAmt: snapshot.data[index].TaxAmt.toString(),
                  //   FinalAmt: snapshot.data[index].FinalAmt.toString(),
                  //   // RevisionNumber:
                  //   //     snapshot.data[index].RevisionNumber.toString(),
                  //   // BuyerName: snapshot.data[index].BuyerName.toString(),
                  //   // BuyerEmailID: snapshot.data[index].BuyerEmailID.toString(),
                  //   // BuyerTel: snapshot.data[index].BuyerTel.toString(),
                  //   // BuyerMob: snapshot.data[index].BuyerMob.toString(),
                  //   // SupplierPOCName:
                  //   //     snapshot.data[index].SupplierPOCName.toString(),
                  //   // QuoteDate: snapshot.data[index].QuoteDate.toString(),
                  // );
                });
          }
        },
      ),
    );
  }
}
