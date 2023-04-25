import 'package:flutter/material.dart';


import '../../reusable-widgets/big-text.dart';
import '../../reusable-widgets/expandable-text.dart';
import '../../reusable-widgets/icon-app.dart';
import '../../styles/app-colors.dart';
import '../custom-app-bar.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:  [
                GestureDetector(
                    onTap: (){
                    },
                    child: AppIcon(icon: Icons.clear,)),
                AppIcon(icon: Icons.shopping_cart,)
              ],
            ),
            backgroundColor: kPrimaryColor,
            pinned: true,
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(20),
              child: Container(
                  height: 50,
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20))),
                  child: Center(child: BigText(text: "Chinese Food"))),
            ),
            expandedHeight:100,
            flexibleSpace:FlexibleSpaceBar(
              background: Image.asset(
                "assets/images/dish1.png",
                width: double.maxFinite,

                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: const ExpandableTextWidget(
                      text: "Text Tex Text Text Text Text Text T  TextText Text Text Text T Text Text TextTe TextText Text Text Text T Text Text TextTe TextText Text Text Text T Text Text TextTe TextText Text Text Text T Text Text TextTe TextText Text Text Text T Text Text TextTe TextText Text Text Text T Text Text TextTe TextText Text Text Text T Text Text TextTe TextText Text Text Text T Text Text TextTe TextText Text Text Text T Text Text TextTe TextText Text Text Text  TextText Text Text Text T Text Text TextTe TextText Text Text Text T Text Text TextTe TextText Text Text Text T Text Text TextTe TextText Text Text Text T Text Text TextTe TextText Text Text Text T Text Text TextTe TextText Text Text Text T Text Text TextTe TextText Text Text Text T Text Text TextTe TextText Text Text Text T Text Text TextTe TextText Text Text Text T Text Text TextTe TextText Text Text Text T Text Text TextTe TextText Text Text Text T Text Text TextTe TextText Text Text Text T Text Text TextTe TextText Text Text Text T Text Text TextTe TextText Text Text Text T Text Text TextTe TextText Text Text Text T Text Text TextTe TextText Text Text Text T Text Text TextTe TextText Text Text Text T Text Text TextTe TextText Text Text Text T Text Text TextTe TextText Text Text Text T Text Text TextTe TextText Text Text Text T Text Text TextTe TextText Text Text Text T Text Text TextTe TextText Text Text Text T Text Text TextTe TextText Text Text Text T Text Text TextTe TextText Text Text Text T Text Text TextTe TextText Text Text Text T Text Text TextTe TextText Text Text Text T Text Text TextTe TextText Text Text Text T Text Text TextTe TextText Text Text Text T Text Text TextTe TextText Text Text Text T Text Text TextTe TextText Text Text Text T Text Text TextTe TextText Text Text Text T Text Text TextTe TextText Text Text Text T Text Text TextTe TextText Text Text Text T Text Text TextTe TextText Text Text Text T Text Text TextTe TextText Text Text Text T Text Text TextTe TextText Text Text Text T Text Text TextTe TextText Text Text Text T Text Text TextTe TextText Text Text Text T Text Text TextTe TextText Text Text Text T Text Text TextTeT Text Text TextTe TextText Text Text Text T Text Text TextTeText Text TextText Text Text Text Text TextText Text Text Text Text TextText Text Text Text Text TextText Text Text Text Text TextText Text Text Text Text TextText Text Text Text Text TextText Text Text Text Text TextText Text Text Text Text TextText Text Text Text Text TextText Text Text Text Text TextText Text Text Text Text TextText Text Text Text Text TextText Text Text Text Text TextText Text Text Text Text TextText Text Text Text Text TextText Text Text Text Text TextText Text Text Text Text TextText Text Text Text Text TextText Text Text Text Text TextText Text Text Text Text TextText Text Text Text Text TextText Text Text Text Text TextText Text Text Text Text TextText Text Text Text Text TextText Text Text Text Text TextText Text Text Text Text TextText Text Text Text Text TextText Text Text Text Text TextText Text Text Text Text TextText Text Text Text Text TextText Text Text Text Text TextText Text Text Text Text TextText Text Text Text Text TextText Text Text Text Text TextText Text Text Text Text TextText Text Text"),
                ),
              ],
            ),
          ),
        ],
      )

    );
  }
}
