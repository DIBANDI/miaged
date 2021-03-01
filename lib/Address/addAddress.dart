import 'package:miage_shop/Config/config.dart';
import 'package:miage_shop/Store/storehome.dart';
import 'package:miage_shop/Widgets/customAppBar.dart';
import 'package:miage_shop/Models/address.dart';
import 'package:flutter/material.dart';
import 'package:miage_shop/Widgets/myDrawer.dart';

class AddAddress extends StatelessWidget {
  final formkey = GlobalKey<FormState>();
  final scaffoldkey = GlobalKey<ScaffoldState>();
  final cName = TextEditingController();
  final cPhoneNumber = TextEditingController();
  final cFlatHomeNumber = TextEditingController();
  final cCity = TextEditingController();
  final cState = TextEditingController();
  final cPinCode = TextEditingController();

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
                SizedBox(
                  height: 15.0,
                ),
                Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Text(
                    "Nouvelle Adresse ",
                    style: TextStyle(
                        color: Colors.blueGrey[900],
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Form(
                  key: formkey,
                  child: Column(
                    children: [
                      MyTextField(
                        hint: "Nom",
                        controller: cName,
                        data: Icons.person_outline,
                      ),
                      MyTextField(
                        hint: "Telphone",
                        controller: cPhoneNumber,
                        data: Icons.phone_outlined,
                      ),
                      MyTextField(
                        hint: "Adresse",
                        controller: cFlatHomeNumber,
                        data: Icons.place_outlined,
                      ),
                      MyTextField(
                        hint: "Ville",
                        controller: cCity,
                        data: Icons.location_city_outlined,
                      ),
                      MyTextField(
                        hint: "Etat/Pays",
                        controller: cState,
                        data: Icons.add_location_outlined,
                      ),
                      MyTextField(
                        hint: "Code Postal",
                        controller: cPinCode,
                        data: Icons.pin_drop_outlined,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                RaisedButton(
                  onPressed: () {
                    if (formkey.currentState.validate()) {
                      final model = AddressModel(
                        name: cName.text.trim(),
                        state: cState.text.trim(),
                        pincode: cPinCode.text,
                        phoneNumber: cPhoneNumber.text,
                        flatNumber: cFlatHomeNumber.text,
                        city: cCity.text.trim(),
                      ).toJson();

                      //Ajouter à firestore
                      EcommerceApp.firestore
                          .collection(EcommerceApp.collectionUser)
                          .document(EcommerceApp.sharedPreferences
                              .getString(EcommerceApp.userUID))
                          .collection(EcommerceApp.subCollectionAddress)
                          .document(
                              DateTime.now().millisecondsSinceEpoch.toString())
                          .setData(model)
                          .then((value) {
                        final snack = SnackBar(
                            content: Text("Nouvelle Adresse ajoutée."));
                        FocusScope.of(context).requestFocus(FocusNode());
                        formkey.currentState.reset();
                      });
                      Route route =
                          MaterialPageRoute(builder: (c) => StoreHome());
                      Navigator.pushReplacement(context, route);
                    }
                  },
                  color: Colors.blueGrey,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                      side: BorderSide(color: Colors.white)),
                  child: Text(
                    "Changer",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MyTextField extends StatelessWidget {
  final String hint;
  final IconData data;
  final TextEditingController controller;
  MyTextField({
    Key key,
    this.hint,
    this.data,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          boxShadow: [
            BoxShadow(
                color: Colors.blueGrey[800],
                blurRadius: 20,
                offset: Offset(0, 10)),
          ]),
      padding: EdgeInsets.all(3.0),
      margin: EdgeInsets.all(6.0),
      child: TextFormField(
        controller: controller,
        cursorColor: Colors.blueGrey[900],
        decoration: InputDecoration(
          border: InputBorder.none,
          prefixIcon: Icon(data, color: Colors.blueGrey[900]),
          focusColor: Colors.blueGrey[900],
          hintText: hint,
        ),
        validator: (val) => val.isEmpty ? "le Champ ne peut etre vide ." : null,
      ),
    );
  }
}
