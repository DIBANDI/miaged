import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:miage_shop/Admin/adminOrderCard.dart';
import 'package:miage_shop/Config/config.dart';
import 'package:flutter/material.dart';
import 'package:miage_shop/Widgets/myDrawerAdmin.dart';
import '../Widgets/loadingWidget.dart';

class AdminShiftOrders extends StatefulWidget {
  @override
  _MyOrdersState createState() => _MyOrdersState();
}

class _MyOrdersState extends State<AdminShiftOrders> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blueGrey[900],
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
          flexibleSpace: Container(
            decoration: new BoxDecoration(
              gradient: new LinearGradient(
                colors: [Colors.blueGrey[500], Colors.blueGrey[900]],
                begin: const FractionalOffset(0.0, 0.0),
                end: const FractionalOffset(0.0, 1.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp,
              ),
            ),
          ),
          centerTitle: true,
          title: Text(
            "Les Commandes ",
            style: TextStyle(color: Colors.white),
          ),
        ),
        drawer: MyDrawerAdmin(),
        body: Container(
          padding: EdgeInsets.only(top: 50.0, bottom: 50.0),
          decoration: BoxDecoration(
              gradient: new LinearGradient(
                colors: [Colors.blueGrey[100], Colors.blueGrey[800]],
                begin: const FractionalOffset(0.0, 0.0),
                end: const FractionalOffset(0.0, 1.0),
              ),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(60),
                  topRight: Radius.circular(60),
                  bottomLeft: Radius.circular(60),
                  bottomRight: Radius.circular(60))),
          child: StreamBuilder<QuerySnapshot>(
            stream: Firestore.instance.collection("orders").snapshots(),
            builder: (c, snapshot) {
              return snapshot.hasData
                  ? ListView.builder(
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (c, index) {
                        return FutureBuilder<QuerySnapshot>(
                          future: Firestore.instance
                              .collection("items")
                              .where("shortInfo",
                                  whereIn: snapshot.data.documents[index]
                                      .data[EcommerceApp.productID])
                              .getDocuments(),
                          builder: (c, snap) {
                            return snap.hasData
                                ? AdminOrderCard(
                                    itemCount: snap.data.documents.length,
                                    data: snap.data.documents,
                                    orderID: snapshot
                                        .data.documents[index].documentID,
                                    orderBy: snapshot
                                        .data.documents[index].data["orderBy"],
                                    addressID: snapshot.data.documents[index]
                                        .data["addressID"],
                                  )
                                : Center(
                                    child: linearProgress(),
                                  );
                          },
                        );
                      },
                    )
                  : Center(
                      child: linearProgress(),
                    );
            },
          ),
        ),
      ),
    );
  }
}
