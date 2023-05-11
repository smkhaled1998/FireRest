
import 'package:firerest/category-file/home-cubit.dart';
import 'package:firerest/category-file/category-states.dart';

import 'package:firerest/shared/const.dart';
import 'package:firerest/widgets/food-items-list.dart';
import 'package:firerest/widgets/page-view-body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../styles/app-colors.dart';


class ExploreScreen extends StatelessWidget {
   ExploreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackground,
      body: BlocConsumer<HomeCubit,HomeStates>(
        listener: (context,state){},
        builder: (context,state){
          var cubit = HomeCubit.get(context);
          return SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:  [
                PageViewBody(),
                const SizedBox(height: 10,),
                Expanded(
                    child: PageView.builder(
                      controller:cubit.pageController,
                      itemCount:cubit.categories.length ,
                      itemBuilder: (context,index){
                        return  FoodItemsList();
                      },
                    )
                ),

              ],
            ),
          );
        },
      ),

    );
  }
}

