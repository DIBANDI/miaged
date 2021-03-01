import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:miage_shop/Widgets/myDrawer.dart';
import 'package:flutter/material.dart';
import 'package:miage_shop/Config/config.dart';
import 'package:flutter/services.dart';
import '../Widgets/loadingWidget.dart';
import '../Widgets/orderCard.dart';

class MyOrders extends StatefulWidget {
  @override
  _MyOrdersState createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
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
            "Mes Commandes ",
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            IconButton(
              icon: Icon(
                Icons.arrow_drop_down_circle_outlined,
                color: Colors.white,
              ),
              onPressed: () {
                SystemNavigator.pop();
              },
            )
          ],
        ),
        drawer: MyDrawer(),
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
            stream: EcommerceApp.firestore
                .collection(EcommerceApp.collectionUser)
                .document(EcommerceApp.sharedPreferences
                    .getString(EcommerceApp.userUID))
                .collection(EcommerceApp.collectionOrders)
                .snapshots(),
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
                                ? OrderCard(
                                    itemCount: snap.data.documents.length,
                                    data: snap.data.documents,
                                    orderID: snapshot
                                        .data.documents[index].documentID,
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
