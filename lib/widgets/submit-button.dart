import 'package:flutter/material.dart';

import '../reusable-widgets/big-text.dart';
import '../styles/app-colors.dart';

class SubmitButton extends StatelessWidget {
  final String text;
  final VoidCallback callBack;
  const SubmitButton({Key? key, required this.text, required this.callBack}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callBack,
      child: Container(
        height: 60,
        width: MediaQuery.of(context).size.width/2,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
          color: AppColor.mainColor
        ),
        child: Center(child: BigText(text: text,colorText: Colors.white,)),
      ),
    );
  }
}
