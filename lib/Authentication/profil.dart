import 'package:miage_shop/Config/config.dart';
import 'package:miage_shop/Widgets/customAppBar.dart';
import 'package:flutter/material.dart';
import 'package:miage_shop/Widgets/myDrawer.dart';

class Profil extends StatelessWidget {
  final formkey = GlobalKey<FormState>();
  final scaffoldkey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blueGrey[900],
        key: scaffoldkey,
        appBar: MyAppBar(),
        drawer: MyDrawer(),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(70),
            decoration: BoxDecoration(
                gradient: new LinearGradient(
                  colors: [Colors.blueGrey[200], Colors.blueGrey[900]],
                  begin: const FractionalOffset(0.0, 0.0),
                  end: const FractionalOffset(0.0, 1.0),
                ),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(60),
                    topRight: Radius.circular(60))),
            child: Column(
              children: [
                Row(children: [
                  Center(
                    child: Material(
                      borderRadius: BorderRadius.all(Radius.circular(130.0)),
                      elevation: 8.0,
                      child: Container(
                        height: 260.0,
                        width: 260.0,
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(
                            EcommerceApp.sharedPreferences
                                .getString(EcommerceApp.userAvatarUrl),
                          ),
                        ),
                      ),
                    ),
                  ),
                ]),
                SizedBox(
                  height: 20.0,
                ),
                Divider(
                  height: 30.0,
                  color: Colors.grey,
                  thickness: 4.0,
                ),
                Row(
                  children: [
                    Center(
                      child: Text(
                        "Votre ID :" +
                            EcommerceApp.sharedPreferences
                                .getString(EcommerceApp.userUID),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontFamily: "signatra"),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),
                Divider(
                  height: 30.0,
                  color: Colors.grey,
                  thickness: 4.0,
                ),
                Row(
                  children: [
                    Center(
                      child: Text(
                        "Votre Nom :" +
                            EcommerceApp.sharedPreferences
                                .getString(EcommerceApp.userName),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30.0,
                            fontFamily: "signatra"),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),
                Divider(
                  height: 30.0,
                  color: Colors.grey,
                  thickness: 4.0,
                ),
                Row(
                  children: [
                    Center(
                      child: Text(
                        "Votre Email :" +
                            EcommerceApp.sharedPreferences
                                .getString(EcommerceApp.userEmail),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30.0,
                            fontFamily: "signatra"),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
