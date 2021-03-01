import 'package:miage_shop/Animation/FadeAnimation.dart';
import 'package:miage_shop/Widgets/customAppBar.dart';
import 'package:miage_shop/Widgets/myDrawer.dart';
import 'package:miage_shop/Models/item.dart';
import 'package:flutter/material.dart';
import 'package:miage_shop/Store/storehome.dart';

class ProductPage extends StatefulWidget {
  final ItemModel itemModel;
  ProductPage({this.itemModel});

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  int quantityOfItems = 1;
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        appBar: MyAppBar(),
        drawer: MyDrawer(),
        body: ListView(
          children: [
            FadeAnimation(
              1.2,
              Padding(
                padding: EdgeInsets.only(top: 12.0),
                child: Center(
                  child: InkWell(
                    onTap: () =>
                        checkItemInCart(widget.itemModel.shortInfo, context),
                    child: Container(
                      decoration: new BoxDecoration(
                        gradient: new LinearGradient(
                          colors: [Colors.blueGrey[200], Colors.blueGrey[900]],
                          begin: const FractionalOffset(0.0, 0.0),
                          end: const FractionalOffset(0.0, 1.0),
                          stops: [0.0, 1.0],
                          tileMode: TileMode.clamp,
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      width: MediaQuery.of(context).size.width - 40.0,
                      height: 50.0,
                      child: Center(
                        child: Text(
                          "Ajouter à la carte",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(8.0),
              width: MediaQuery.of(context).size.height,
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      FadeAnimation(
                        1.5,
                        Center(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                    offset: Offset(0, 10),
                                    blurRadius: 10.0,
                                    color: Colors.blueGrey[300]),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              child: Image.network(
                                widget.itemModel.thumbnailUrl,
                                height: 500.0,
                                width: width * 0.95,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.all(20.0),
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AspectRatio(
                            aspectRatio: 8 / 1,
                            child: FadeAnimation(
                              1.6,
                              Container(
                                margin: EdgeInsets.only(right: 10),
                                decoration: BoxDecoration(
                                  color: Colors.grey[400],
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: Text(
                                    widget.itemModel.title,
                                    style: boldTextStyle,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          AspectRatio(
                            aspectRatio: 3 / 1,
                            child: FadeAnimation(
                              1.7,
                              Container(
                                padding: EdgeInsets.all(20),
                                margin: EdgeInsets.only(right: 10),
                                decoration: BoxDecoration(
                                  color: Colors.brown[100],
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: Text(widget.itemModel.longDescription,
                                      style: TextStyle(
                                        fontSize: 20,
                                      )),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          AspectRatio(
                            aspectRatio: 8 / 1,
                            child: FadeAnimation(
                              1.8,
                              Container(
                                padding: EdgeInsets.all(10),
                                margin: EdgeInsets.only(right: 10),
                                decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: Text(
                                      "€" + widget.itemModel.price.toString(),
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold)),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          AspectRatio(
                            aspectRatio: 8 / 1,
                            child: FadeAnimation(
                              1.9,
                              Container(
                                padding: EdgeInsets.all(10),
                                margin: EdgeInsets.only(right: 10),
                                decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: Text(
                                      "Taille :" +
                                          widget.itemModel.size.toString(),
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold)),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

const boldTextStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 20);
const largeTextStyle = TextStyle(fontWeight: FontWeight.normal, fontSize: 20);
