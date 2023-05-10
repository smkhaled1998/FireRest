import 'package:firerest/styles/app-colors.dart';
import 'package:flutter/material.dart';

class FloatingButton extends StatelessWidget {
  final String text;
  Color? textColor;
  final VoidCallback callBack;
  FloatingButton({Key? key, required this.text, required this.callBack}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callBack,
      child: Container(
        height: 40,
        width: 140,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: AppColor.mainColor
        ),
        child: Center(child: Text(text)),
      ),
    );
  }
}
