import 'package:firerest/home-file/home-cubit.dart';
import 'package:firerest/home-file/home-states.dart';
import 'package:firerest/shared/const.dart';
import 'package:firerest/widgets/food-items-list.dart';
import 'package:firerest/widgets/page-view-widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../styles/app-colors.dart';

class ExploreScreen extends StatelessWidget {
   ExploreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: kBackground,
      body: BlocProvider(
        create: (context)=>HomeCubit()..getItems(categoryId: categoryIndex)..getCategory(),
        child: BlocBuilder<HomeCubit,HomeStates>(
          builder: (context,state){
            var cubit = HomeCubit.get(context);
            return SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                    SizedBox(
                      height: 210,
                      child: PageView.builder(
                        controller: cubit.categoryPageController,
                        onPageChanged: (position){
                          categoryIndex= "${cubit.categories[position].name}";
                          cubit.getItems(categoryId: categoryIndex);
                          // cubit.itemPageController.jumpToPage(position);
                          cubit.categoryPageController.animateToPage(
                            position,
                            duration: Duration(milliseconds: 500), // Adjust animation duration as needed
                            curve: Curves.easeInOut, // Adjust animation curve as needed
                          );
                        },
                        itemCount: cubit.categories.length,
                        itemBuilder: (context, index) {
                          return PageViewWidget(
                            index: index,
                          );
                        },
                      ),
                    ),
                    SmoothPageIndicator(
                        controller: cubit.categoryPageController,
                        count: cubit.categories.length,
                        effect: const ExpandingDotsEffect(
                          activeDotColor: Colors.black,
                            expansionFactor: 3, dotWidth: 10, dotHeight: 10)),
                  ],),
                  const SizedBox(
                    height: 10,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(
                      child: PageView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                            controller: cubit.itemPageController,
                             onPageChanged: (position) {
                               // cubit.categoryPageController.animateToPage(
                               //   position,
                               //   duration: const Duration(milliseconds: 500), // Adjust animation duration as needed
                               //   curve: Curves.easeInOut, // Adjust animation curve as needed
                               // );
                              // cubit.categoryPageController.jumpToPage(position);
                                                       },
                    itemCount: cubit.categories.length,
                    itemBuilder: (context, index) {
                      return const FoodItemsList();
                    },
                  )),
                ],
              ),
            );
          },
        ),
      ),

    );
  }
}

