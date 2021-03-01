import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:miage_shop/Admin/products.dart';
import 'package:miage_shop/Animation/FadeAnimation.dart';
import 'package:miage_shop/Authentication/authenication.dart';
import 'package:miage_shop/Widgets/customTextField.dart';
import 'package:miage_shop/DialogBox/errorDialog.dart';
import 'package:flutter/material.dart';

class AdminSignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      appBar: AppBar(
        toolbarHeight: 230.0,
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
      ),
      body: AdminSignInScreen(),
    );
  }
}

class AdminSignInScreen extends StatefulWidget {
  @override
  _AdminSignInScreenState createState() => _AdminSignInScreenState();
}

class _AdminSignInScreenState extends State<AdminSignInScreen> {
  final TextEditingController _passwordTextEditingController =
      TextEditingController();
  final TextEditingController _adminIDTextEditingController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    /*  double _screenwidth = MediaQuery.of(context).size.width,
        _screenheight = MediaQuery.of(context).size.height;*/
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.only(top: 10),
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
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(
              height: 10.0,
            ),
            FadeAnimation(
              1,
              Container(
                child: Image.asset(
                  "images/adminsetting.png",
                  height: 160.0,
                  width: 160.0,
                  color: Colors.blueGrey[900],
                ),
              ),
            ),
            FadeAnimation(
              1.3,
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Admin",
                  style: TextStyle(
                      color: Colors.blueGrey[900],
                      fontSize: 28.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  FadeAnimation(
                    1.5,
                    CustomTextField(
                      controller: _adminIDTextEditingController,
                      data: Icons.person,
                      hintText: "id",
                      isObsecure: false,
                    ),
                  ),
                  FadeAnimation(
                    1.6,
                    CustomTextField(
                      controller: _passwordTextEditingController,
                      data: Icons.lock,
                      hintText: "Password",
                      isObsecure: true,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
            FadeAnimation(
              1.7,
              RaisedButton(
                onPressed: () {
                  _adminIDTextEditingController.text.isNotEmpty &&
                          _passwordTextEditingController.text.isNotEmpty
                      ? loginAdmin()
                      : showDialog(
                          context: context,
                          builder: (c) {
                            return ErrorAlertDialog(
                              message:
                                  "Please write your Email and Your password",
                            );
                          });
                },
                color: Colors.blueGrey,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                    side: BorderSide(color: Colors.white)),
                child: Text(
                  "Login",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
            FadeAnimation(
              1.8,
              RaisedButton(
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AuthenticScreen())),
                color: Colors.blueGrey,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                    side: BorderSide(color: Colors.white)),
                child: Text(
                  "Retour à la page user",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  loginAdmin() {
    Firestore.instance.collection("admins").getDocuments().then((snapshot) {
      snapshot.documents.forEach((result) {
        if (result.data["id"] != _adminIDTextEditingController.text.trim()) {
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text("Your ID is Incorrect"),
          ));
        } else if (result.data["password"] !=
            _passwordTextEditingController.text.trim()) {
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text("Your Password is Incorrect"),
          ));
        } else {
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text("Welcom Dear Admini, " + result.data["name"]),
          ));

          setState(() {
            _adminIDTextEditingController.text = "";
            _passwordTextEditingController.text = "";
          });

          Route route = MaterialPageRoute(builder: (c) => ProductsHome());
          Navigator.pushReplacement(context, route);
        }
      });
    });
  }
}
