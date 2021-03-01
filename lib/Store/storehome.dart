import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:miage_shop/Animation/FadeAnimation.dart';
import 'package:miage_shop/Store/Search.dart';
import 'package:miage_shop/Store/cart.dart';
import 'package:miage_shop/Store/product_page.dart';
import 'package:miage_shop/Counters/cartitemcounter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:miage_shop/Config/config.dart';
import '../Widgets/loadingWidget.dart';
import '../Widgets/myDrawer.dart';
import '../Models/item.dart';

double width;

class StoreHome extends StatefulWidget {
  @override
  _StoreHomeState createState() => _StoreHomeState();
}

class _StoreHomeState extends State<StoreHome> {
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blueGrey,
        drawer: MyDrawer(),
        body: Container(
          decoration: new BoxDecoration(
              gradient: new LinearGradient(
                colors: [Colors.blueGrey[200], Colors.blueGrey[900]],
                begin: const FractionalOffset(0.0, 0.0),
                end: const FractionalOffset(0.0, 1.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp,
              ),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(60), topRight: Radius.circular(60))),
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                // title: Text('Miage, Notre Boutique'),
                expandedHeight: 350.0,
                floating: true,
                pinned: true,
                title: Container(
                  height: 36.0,
                  width: double.infinity,
                  child: Center(
                    child: Container(
                      height: 80,
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.only(left: 20, right: 20),
                      child: IconButton(
                        icon: Icon(
                          Icons.search_outlined,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          Route route = MaterialPageRoute(
                              builder: (c) => SearchProduct());
                          Navigator.pushReplacement(context, route);
                        },
                      ),
                    ),
                  ),
                ),

                backgroundColor: Colors.black,
                flexibleSpace: new FlexibleSpaceBar(
                  background: Image.network(
                    'https://media3.giphy.com/media/9G6M3sPQcKAvKMTwPW/giphy.gif',
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
              /*  SliverPersistentHeader(
                  pinned: false, floating: true, delegate: SearchBoxDelegate()),*/
              StreamBuilder<QuerySnapshot>(
                  stream: Firestore.instance
                      .collection("items")
                      .limit(15)
                      .orderBy("publishedDate", descending: true)
                      .snapshots(),
                  builder: (context, dataSnapshot) {
                    return !dataSnapshot.hasData
                        ? SliverToBoxAdapter(
                            child: Center(
                              child: linearProgress(),
                            ),
                          )
                        : SliverStaggeredGrid.countBuilder(
                            crossAxisCount: 1,
                            staggeredTileBuilder: (c) => StaggeredTile.fit(1),
                            itemBuilder: (context, index) {
                              ItemModel model = ItemModel.fromJson(
                                  dataSnapshot.data.documents[index].data);
                              return sourceInfo(model, context);
                            },
                            itemCount: dataSnapshot.data.documents.length,
                          );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

Widget sourceInfo(ItemModel model, BuildContext context,
    {Color background, removeCartFunction}) {
  return InkWell(
    splashColor: Colors.blueGrey,
    child: GestureDetector(
      onTap: () {
        Route route =
            MaterialPageRoute(builder: (c) => ProductPage(itemModel: model));
        Navigator.pushReplacement(context, route);
      },
      child: Container(
        height: 350.0,
        padding: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(bottom: 1.0),
                      ),
                      AspectRatio(
                        aspectRatio: 8 / 1,
                        child: FadeAnimation(
                          1,
                          Center(
                            child: Container(
                              margin: EdgeInsets.only(right: 10),
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Center(
                                child: Text(
                                  model.title,
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              children: [
                FadeAnimation(
                  1.2,
                  Center(
                    child: Container(
                      //width: MediaQuery.of(context).size.width-30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              offset: Offset(0, 10),
                              blurRadius: 10.0,
                              color: Colors.blueGrey[300]),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        child: Image.network(
                          model.thumbnailUrl,
                          height: 230.0,
                          width: width * 0.95,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      FadeAnimation(
                        1.4,
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: removeCartFunction == null
                                  ? IconButton(
                                      icon: Icon(
                                        Icons.add_shopping_cart_outlined,
                                        color: Colors.blueGrey[900],
                                        size: 30,
                                      ),
                                      onPressed: () {
                                        checkItemInCart(
                                            model.shortInfo, context);
                                      },
                                    )
                                  : IconButton(
                                      icon: Icon(
                                        Icons.remove_shopping_cart_outlined,
                                        color: Colors.pink,
                                        size: 30,
                                      ),
                                      onPressed: () {
                                        removeCartFunction();
                                        Route route = MaterialPageRoute(
                                            builder: (c) => StoreHome());
                                        Navigator.pushReplacement(
                                            context, route);
                                      },
                                    ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                FadeAnimation(
                  1.6,
                  Container(
                    width: 120,
                    height: 40,
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: Colors.brown[300],
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          r"Prix : € " + (model.price).toString(),
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

Widget card({Color primaryColor = Colors.redAccent, String imgPath}) {
  return Container(
    height: 150.0,
    width: width * .34,
    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
        boxShadow: <BoxShadow>[
          BoxShadow(
              offset: Offset(0, 5),
              blurRadius: 10.0,
              color: Colors.blueGrey[300]),
        ]),
    child: ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(20.0)),
      child: Image.network(
        imgPath,
        height: 150.0,
        width: width * .34,
        fit: BoxFit.fill,
      ),
    ),
  );
}

void checkItemInCart(String shortInfoAsID, BuildContext context) {
  EcommerceApp.sharedPreferences
          .getStringList(EcommerceApp.userCartList)
          .contains(shortInfoAsID)
      ? Fluttertoast.showToast(msg: "Cet article deja dans la carte .")
      : addItemToCart(shortInfoAsID, context);
}

addItemToCart(String shortInfoAsID, BuildContext context) {
  List tempCartList =
      EcommerceApp.sharedPreferences.getStringList(EcommerceApp.userCartList);
  tempCartList.add(shortInfoAsID);

  EcommerceApp.firestore
      .collection(EcommerceApp.collectionUser)
      .document(EcommerceApp.sharedPreferences.getString(EcommerceApp.userUID))
      .updateData({EcommerceApp.userCartList: tempCartList}).then((v) {
    Fluttertoast.showToast(msg: "Article Ajouté à la carte, avec succes.");

    EcommerceApp.sharedPreferences
        .setStringList(EcommerceApp.userCartList, tempCartList);
    Provider.of<CartItemCounter>(context, listen: false).displayResult();
  });
}
