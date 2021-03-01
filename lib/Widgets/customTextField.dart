import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final IconData data;
  final String hintText;
  bool isObsecure = true;

  CustomTextField(
      {Key key, this.controller, this.data, this.hintText, this.isObsecure})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
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
      margin: EdgeInsets.all(5.0),
      child: TextFormField(
        controller: controller,
        obscureText: isObsecure,
        cursorColor: Colors.blueGrey[900],
        decoration: InputDecoration(
          border: InputBorder.none,
          prefixIcon: Icon(data, color: Colors.blueGrey[900]),
          focusColor: Colors.blueGrey[900],
          hintText: hintText,
        ),
      ),
    );
  }
}
