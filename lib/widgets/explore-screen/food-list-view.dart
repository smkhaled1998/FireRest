import 'package:flutter/material.dart';


import '../../models/restaurant-model.dart';

import 'food-details.dart';
import 'food-item.dart';

class FoodListView extends StatelessWidget {
final int selected;
final Function callback;
final PageController pageController;
final Restaurant restaurant;

FoodListView( {required this.pageController,required this.selected,required this.callback, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    final category= restaurant.menu!.keys.toList();

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      child: PageView(
        controller: pageController,
        onPageChanged: (index)=> callback(index),
        children: category.map((e) => ListView.separated(
          itemCount: restaurant.menu![category[selected]]!.length,
          itemBuilder: (ctx,index)=>GestureDetector(
            onTap: (){
              Navigator.push(context,MaterialPageRoute(builder: (context)=> DetailPage()));
            },
            child: FoodItem(
              restaurant.menu![category[selected]]![index]
              // restaurant.menu![category[selected]]![index]
            ),
          ),
         separatorBuilder:(ctx,index)=>SizedBox(height: 10,) ,
        )).toList()
        ,
      )

    );
  }
}

