import 'package:miage_shop/Authentication/authenication.dart';
import 'package:miage_shop/Authentication/profil.dart';
import 'package:miage_shop/Config/config.dart';
import 'package:miage_shop/Address/addAddress.dart';
import 'package:miage_shop/Store/Search.dart';
import 'package:miage_shop/Store/cart.dart';
import 'package:miage_shop/Orders/myOrders.dart';
import 'package:miage_shop/Store/storehome.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Container(
            padding: EdgeInsets.only(top: 25.0, bottom: 10.0),
            decoration: new BoxDecoration(
              gradient: new LinearGradient(
                colors: [Colors.blueGrey[900], Colors.blueGrey[500]],
                begin: const FractionalOffset(0.0, 0.0),
                end: const FractionalOffset(0.0, 1.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp,
              ),
            ),
            child: Column(
              children: [
                Material(
                  borderRadius: BorderRadius.all(Radius.circular(100.0)),
                  elevation: 8.0,
                  child: Container(
                    height: 200.0,
                    width: 200.0,
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(
                        EcommerceApp.sharedPreferences
                            .getString(EcommerceApp.userAvatarUrl),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  EcommerceApp.sharedPreferences
                      .getString(EcommerceApp.userName),
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 35.0,
                      fontFamily: "signatra"),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 1.0,
          ),
          Container(
            padding: EdgeInsets.only(top: 1.0),
            height: 630.0,
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
                        MaterialPageRoute(builder: (c) => StoreHome());
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
                    "Mes Commandes",
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {
                    Route route = MaterialPageRoute(builder: (c) => MyOrders());
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
                    Icons.shopping_cart_outlined,
                    color: Colors.white,
                  ),
                  title: Text(
                    "Mon Panier",
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {
                    Route route = MaterialPageRoute(builder: (c) => CartPage());
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
                    Icons.search_outlined,
                    color: Colors.white,
                  ),
                  title: Text(
                    "Recherche",
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {
                    Route route =
                        MaterialPageRoute(builder: (c) => SearchProduct());
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
                    Icons.add_location_outlined,
                    color: Colors.white,
                  ),
                  title: Text(
                    "Nouvelle Adresse",
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {
                    Route route =
                        MaterialPageRoute(builder: (c) => AddAddress());
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
                    Icons.person_outline,
                    color: Colors.white,
                  ),
                  title: Text(
                    "Profil",
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {
                    Route route = MaterialPageRoute(builder: (c) => Profil());
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
