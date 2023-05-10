import 'package:flutter/material.dart';


import '../styles/app-colors.dart';



class CustomAppBar extends StatelessWidget {
  final IconData leftIcon;
  final IconData rightIcon;
  Function? leftCallBack;

   CustomAppBar(
      {Key? key,
      required this.leftIcon,
      required this.rightIcon,
      this.leftCallBack})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top, left: 30, right: 30),
      // color: kPrimaryColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.all(5),
            decoration:BoxDecoration(
              shape: BoxShape.circle,
              color: kBackground
            ) ,
            child: Icon(
              leftIcon
            ),
          ),
          // GestureDetector(
          //     onTap: leftCallBack!=null? ()=>leftCallBack:null,
          //     child: AppIcon(icon: leftIcon)),
          // AppIcon(icon: rightIcon),
          Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color:kBackground
            ),
            child: Icon(rightIcon),
          )
        ],
      ),
    );
  }
}
