import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

import '../styles/app-colors.dart';

class TextFormFieldWidget extends StatelessWidget {
  final String hint;
  final TextEditingController controller;
  final TextInputType textInputType;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final VoidCallback? callBack;
  final bool secure;

  const TextFormFieldWidget(
      {Key? key,
      required this.hint,
      this.prefixIcon = null,
      this.suffixIcon=null,
      required this.controller,
      this.textInputType = TextInputType.text,
        this.callBack, this.secure=false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(.2),
                offset: Offset(1, 8),
                blurRadius: 10,
                spreadRadius: 4)
          ]),
      child: TextFormField(
        controller: controller,
        keyboardType: textInputType,
        obscureText: secure,
        validator: (value) {
          if (value!.isEmpty) {
            return 'This filed is required';
          }
          return null;
        },
        decoration: InputDecoration(
            prefixIcon: Icon(
              prefixIcon != null ? prefixIcon : null,
              color: AppColor.yellowColor,
            ),
            suffixIcon: IconButton(
                onPressed:callBack,
                icon: Icon(suffixIcon != null ? suffixIcon : null)),
            hintText: hint,
            labelStyle: TextStyle(color: AppColor.yellowColor),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey, width: 1),
                borderRadius: BorderRadius.circular(30)),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 1),
                borderRadius: BorderRadius.circular(30))),
      ),
    );
  }
}
