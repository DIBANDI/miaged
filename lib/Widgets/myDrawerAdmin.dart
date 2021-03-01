import 'package:miage_shop/Admin/adminShiftOrders.dart';
import 'package:miage_shop/Admin/products.dart';
import 'package:miage_shop/Authentication/authenication.dart';
import 'package:miage_shop/Config/config.dart';
import 'package:flutter/material.dart';

class MyDrawerAdmin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Container(
            padding: EdgeInsets.only(top: 1.0),
            height: 750.0,
            decoration: new BoxDecoration(
              gradient: new LinearGradient(
                colors: [Colors.blueGrey[500], Colors.blueGrey[900]],
                begin: const FractionalOffset(0.0, 0.0),
                end: const FractionalOffset(0.0, 1.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp,
              ),
            ),
            child: Column(
              children: [
                ListTile(
                  leading: Icon(
                    Icons.home_outlined,
                    color: Colors.white,
                  ),
                  title: Text(
                    "Accueil",
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {
                    Route route =
                        MaterialPageRoute(builder: (c) => ProductsHome());
                    Navigator.pushReplacement(context, route);
                  },
                ),
                Divider(
                  height: 2.0,
                  color: Colors.grey,
                  thickness: 2.0,
                ),
                ListTile(
                  leading: Icon(
                    Icons.card_membership_outlined,
                    color: Colors.white,
                  ),
                  title: Text(
                    "Commandes en cours",
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {
                    Route route =
                        MaterialPageRoute(builder: (c) => AdminShiftOrders());
                    Navigator.pushReplacement(context, route);
                  },
                ),
                Divider(
                  height: 2.0,
                  color: Colors.grey,
                  thickness: 2.0,
                ),
                ListTile(
                  leading: Icon(
                    Icons.logout,
                    color: Colors.white,
                  ),
                  title: Text(
                    "Deconnexion",
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {
                    EcommerceApp.auth.signOut().then((c) {
                      Route route =
                          MaterialPageRoute(builder: (c) => AuthenticScreen());
                      Navigator.pushReplacement(context, route);
                    });
                  },
                ),
                Divider(
                  height: 2.0,
                  color: Colors.grey,
                  thickness: 2.0,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
