import 'package:firerest/reusable-widgets/big-text.dart';
import 'package:firerest/reusable-widgets/small-text.dart';
import 'package:firerest/screens/card.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(

      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(bottom:20,left: 20,right:20),
              child:CardWidget(cardText: "Taghreed",)
            ),
          ],
        ),
      ),
    );
  }
}
