import 'package:flutter/material.dart';

class BigText extends StatelessWidget {
  final String text;
  Color colorText;
  double sizeText;

   BigText({Key? key,
     required this.text,
     this.colorText=const Color(0xFF332d2b),
     this.sizeText=24
   }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text,
    style: TextStyle(
      color: colorText,
      fontSize: sizeText
    ),);
  }
}
