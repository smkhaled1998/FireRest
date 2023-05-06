import 'package:firerest/category-file/category-cubit.dart';
import 'package:firerest/category-file/category-states.dart';
import 'package:firerest/home-layout/home-cubit.dart';
import 'package:firerest/home-layout/home-states.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/restaurant-model.dart';
import '../../styles/app-colors.dart';


class FoodList extends StatelessWidget {
  final Restaurant restaurant;
  final int selected;
  final Function callBack;
  FoodList ({required this.restaurant,required this.selected,required this.callBack,});
  @override
  Widget build(BuildContext context) {
    final category =restaurant.menu!.keys.toList();
    return BlocProvider(
      create: (context)=>CategoryCubit(),
      child: BlocConsumer<CategoryCubit,CategoryStates>(
        listener: (context,state){},
        builder: (context,state){
          var cubit =CategoryCubit.get(context);
          return Container(
            height: 100,
            margin: const EdgeInsets.only(left: 15),
            padding:const EdgeInsets.symmetric(vertical:30),
            child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  print(cubit.categories.length);
                  return GestureDetector(
                    onTap: () => callBack(index),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 15),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: selected == index ? kPrimaryColor : Colors.white),
                      child: Text(category[index]),
                    ),
                  );
                },
                separatorBuilder: (context, index) => const SizedBox(width: 15,),
                itemCount: category.length),
          );
        },

      ),
    );
  }
}


