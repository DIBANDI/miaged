import 'package:miage_shop/Animation/FadeAnimation.dart';
import 'package:flutter/material.dart';
import 'login.dart';
import 'register.dart';

class AuthenticScreen extends StatefulWidget {
  @override
  _AuthenticScreenState createState() => _AuthenticScreenState();
}

class _AuthenticScreenState extends State<AuthenticScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.blueGrey[900],
        appBar: AppBar(
          toolbarHeight: 250.0,
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
          bottom: TabBar(
            tabs: [
              FadeAnimation(
                1,
                Tab(
                  icon: Icon(
                    Icons.lock,
                    color: Colors.white,
                    size: 30.0,
                  ),
                  text: "Connexion",
                ),
              ),
              FadeAnimation(
                1.3,
                Tab(
                  icon: Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 35.0,
                  ),
                  text: "Enregistrement",
                ),
              ),
            ],
            indicatorColor: Colors.blueGrey[900],
            indicatorWeight: 1.0,
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
              gradient: new LinearGradient(
                colors: [Colors.blueGrey[200], Colors.blueGrey[900]],
                begin: const FractionalOffset(0.0, 0.0),
                end: const FractionalOffset(0.0, 1.0),
              ),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(60), topRight: Radius.circular(60))),
          child: TabBarView(children: [
            FadeAnimation(
              1.5,
              Login(),
            ),
            FadeAnimation(
              1.7,
              Register(),
            )
          ]),
        ),
      ),
    );
  }
}
