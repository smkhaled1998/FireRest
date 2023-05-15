import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


void navigateTo(context, page) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => page));

void navigateAndReplace(context, page) => Navigator.pushAndRemoveUntil(
    context, MaterialPageRoute(builder: (context) => page), (route) => false);

void showToast ({
  required String text,
  required ToastStates state
})=> Fluttertoast.showToast(
    msg: text,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: chooseToastColor(state),
    textColor: Colors.white,
    fontSize: 16.0
);

enum ToastStates {SUCCESS,ERROR,WARNING}

Color chooseToastColor(ToastStates state){

  Color color;
  switch(state) {
    case ToastStates.SUCCESS: color= Colors.green;
    break;
    case ToastStates.ERROR: color= Colors.red;
    break;
    case ToastStates.WARNING: color= Colors.amber;
    break;

  }
  return color;
}



String categoryId="";
String categoryIndex="BBQ";