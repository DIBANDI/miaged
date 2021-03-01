import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:miage_shop/Admin/uploadItems.dart';
import 'package:miage_shop/Animation/FadeAnimation.dart';
import 'package:miage_shop/Counters/cartitemcounter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:miage_shop/Widgets/myDrawerAdmin.dart';
import 'package:provider/provider.dart';
import 'package:miage_shop/Config/config.dart';
import '../Widgets/loadingWidget.dart';
import '../Models/item.dart';

double width;

class ProductsHome extends StatefulWidget {
  @override
  _ProductsHomeState createState() => _ProductsHomeState();
}

class _ProductsHomeState extends State<ProductsHome> {
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blueGrey,
        drawer: MyDrawerAdmin(),
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
                title: Text('Miage, Partie Admin'),
                expandedHeight: 260.0,
                floating: true,
                pinned: true,
                backgroundColor: Colors.black,
                flexibleSpace: new FlexibleSpaceBar(
                  background: Image.network(
                    'https://media.giphy.com/media/xThuWtUto8ueXNETde/giphy.gif',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              /*  SliverPersistentHeader(
                  pinned: false, floating: true, delegate: SearchBoxDelegate()),*/
              StreamBuilder<QuerySnapshot>(
                  stream: Firestore.instance
                      .collection("items")
                      .limit(25)
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
                            crossAxisCount: 2,
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
        floatingActionButton: FloatingActionButton.extended(
          label: Text("Ajouter"),
          backgroundColor: Colors.black,
          icon: Icon(Icons.add_circle_outline),
          onPressed: () {
            Route route = MaterialPageRoute(builder: (c) => UploadPage());
            Navigator.pushReplacement(context, route);
          },
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
      child: Container(
        height: 180.0,
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
                              width: 180,
                              height: 60,
                              decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  color: Colors.blueGrey,
                                  borderRadius: BorderRadius.circular(6)),
                              child: Center(
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    model.title,
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      color: Colors.white,
                                    ),
                                  ),
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
                  1.3,
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
                          height: 130.0,
                          width: width * 0.45,
                          fit: BoxFit.cover,
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
