import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:miage_shop/Config/config.dart';
import 'package:miage_shop/Address/address.dart';
import 'package:miage_shop/Widgets/loadingWidget.dart';
import 'package:miage_shop/Models/item.dart';
import 'package:miage_shop/Counters/cartitemcounter.dart';
import 'package:miage_shop/Counters/totalMoney.dart';
import 'package:miage_shop/Widgets/myDrawer.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:miage_shop/Store/storehome.dart';

import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  double totalAmount;

  @override
  void initState() {
    super.initState();
    totalAmount = 0;
    Provider.of<TotalAmount>(context, listen: false).display(0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          if (EcommerceApp.sharedPreferences
                  .getStringList(EcommerceApp.userCartList)
                  .length ==
              1) {
            Fluttertoast.showToast(msg: "Votre Carte est vide !");
          } else {
            Route route = MaterialPageRoute(
                builder: (c) => Address(totalAmount: totalAmount));
            Navigator.pushReplacement(context, route);
          }
        },
        label: Text("Check Out"),
        backgroundColor: Colors.blueGrey[900],
        icon: Icon(Icons.navigate_next_outlined),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      /* appBar: MyAppBar(),*/
      drawer: MyDrawer(),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text('Gerez votre Panier'),
            expandedHeight: 300.0,
            floating: true,
            pinned: true,
            backgroundColor: Colors.black,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                'https://thumbs.gfycat.com/GiantThinHalicore-small.gif',
                fit: BoxFit.cover,
              ),
            ),
            actions: [
              Stack(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.shopping_cart_outlined,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Route route =
                          MaterialPageRoute(builder: (c) => CartPage());
                      Navigator.pushReplacement(context, route);
                    },
                  ),
                  Positioned(
                    child: Stack(
                      children: [
                        Icon(
                          Icons.brightness_1,
                          size: 20.0,
                          color: Colors.green,
                        ),
                        Positioned(
                          top: 3.0,
                          bottom: 4.0,
                          left: 5.0,
                          child: Consumer<CartItemCounter>(
                              builder: (context, counter, _) {
                            return Text(
                              (EcommerceApp.sharedPreferences
                                          .getStringList(
                                              EcommerceApp.userCartList)
                                          .length -
                                      1)
                                  .toString(),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w500),
                            );
                          }),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Consumer2<TotalAmount, CartItemCounter>(
              builder: (context, amountProvider, cartProvider, c) {
                return Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Center(
                    child: cartProvider.count == 0
                        ? Container(
                            child: Text(
                              "Le Prix Au Total : € ${amountProvider.totalAmount.toString()}",
                              style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 30.0,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        : Container(
                            child: Text(
                              "Le Prix Au Total : € ${amountProvider.totalAmount.toString()}",
                              style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 30.0,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                  ),
                );
              },
            ),
          ),
          StreamBuilder<QuerySnapshot>(
              stream: EcommerceApp.firestore
                  .collection("items")
                  .where("shortInfo",
                      whereIn: EcommerceApp.sharedPreferences
                          .getStringList(EcommerceApp.userCartList))
                  .snapshots(),
              builder: (context, snapshot) {
                return !snapshot.hasData
                    ? SliverToBoxAdapter(
                        child: Center(
                          child: circularProgress(),
                        ),
                      )
                    : snapshot.data.documents.length == 0
                        ? beginbuildingCart()
                        : SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (context, index) {
                                ItemModel model = ItemModel.fromJson(
                                    snapshot.data.documents[index].data);
                                if (index == 0) {
                                  totalAmount = 0;
                                  totalAmount = model.price + totalAmount;
                                } else {
                                  totalAmount = model.price + totalAmount;
                                }

                                if (snapshot.data.documents.length - 1 ==
                                    index) {
                                  WidgetsBinding.instance
                                      .addPostFrameCallback((t) {
                                    Provider.of<TotalAmount>(context,
                                            listen: false)
                                        .display(totalAmount);
                                  });
                                }
                                return sourceInfo(model, context,
                                    removeCartFunction: () =>
                                        removeItemFromUserCart(
                                            model.shortInfo));
                              },
                              childCount: snapshot.hasData
                                  ? snapshot.data.documents.length
                                  : 0,
                            ),
                          );
              })
        ],
      ),
    );
  }

  beginbuildingCart() {
    return SliverToBoxAdapter(
      child: Card(
        color: Theme.of(context).primaryColor.withOpacity(0.5),
        child: Container(
          height: 100.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.insert_emoticon_outlined, color: Colors.white),
              Text("La Carte est vide"),
              Text("Ajoutez des Articles à votre Carte"),
            ],
          ),
        ),
      ),
    );
  }

  removeItemFromUserCart(String shortInfoAsId) {
    List tempCartList =
        EcommerceApp.sharedPreferences.getStringList(EcommerceApp.userCartList);
    tempCartList.remove(shortInfoAsId);

    EcommerceApp.firestore
        .collection(EcommerceApp.collectionUser)
        .document(
            EcommerceApp.sharedPreferences.getString(EcommerceApp.userUID))
        .updateData({EcommerceApp.userCartList: tempCartList}).then((v) {
      Fluttertoast.showToast(msg: "Article supprimé de la carte avec succes.");

      EcommerceApp.sharedPreferences
          .setStringList(EcommerceApp.userCartList, tempCartList);
      Provider.of<CartItemCounter>(context, listen: false).displayResult();

      totalAmount = 0;
    });
  }
}
