import 'package:flutter/material.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../models/restaurant-model.dart';
import '../styles/app-colors.dart';

import '../widgets/custom-app-bar.dart';
import '../widgets/explore-screen/category-list.dart';
import '../widgets/explore-screen/food-list-view.dart';
import '../widgets/explore-screen/rest-info.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({Key? key}) : super(key: key);

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {

  var selected =0;
  var restaurant=Restaurant.generateRestaurant();
  var pageController=PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackground,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:  [
             // CustomAppBar(
             //  leftIcon: Icons.arrow_back_ios_new,
             //  rightIcon: Icons.search_rounded,),
            RestaurantInfo(),
            const SizedBox(height: 10,),
            FoodList(
              restaurant: restaurant,
              selected: selected,
              callBack: (int index){
                setState(() {
                  selected=index;
                });
                pageController.jumpToPage(index);
              },
            ),
            Expanded(
              child: FoodListView(
                selected:selected,
                  restaurant: restaurant,
                  callback: (int index ){
                  setState(() {
                    selected=index;
                  });
                  },
                pageController:pageController
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 15,top: 10),
              child: SmoothPageIndicator(
                  controller: pageController,
                  count: restaurant.menu!.keys.length,
                  effect: const ExpandingDotsEffect(
                    activeDotColor: kPrimaryColor,
                      expansionFactor: 3, dotWidth: 10, dotHeight: 10)),
            ),
            SizedBox(height: 10,)
          ],
        ),
      ),

    );
  }
}
