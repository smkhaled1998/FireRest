import 'package:firerest/category-file/home-cubit.dart';
import 'package:firerest/category-file/category-states.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FoodItemsList extends StatelessWidget {
  const FoodItemsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit,HomeStates>(
      listener: (context,state){},
      builder: (context,state){
        var cubit = HomeCubit.get(context);
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 15),
          child: ListView.builder(
            itemCount: cubit.items.length,
            itemBuilder: (context, index) => Container(
              margin: const EdgeInsets.only(bottom: 20, left: 10, right: 10),
              child: Row(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage("${cubit.items[index].img}"),
                        )
                    ),
                  ),
                  Expanded(
                      child: Container(
                        height: 87,
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.shade200,
                                  offset: const Offset(0, 2)
                              )
                            ],
                            color: Colors.white,
                            borderRadius: const BorderRadius.only(
                                bottomRight: Radius.circular(20),
                                topRight: Radius.circular(20))),
                        child: Padding(
                          padding:
                          const EdgeInsets.only(left: 10, right: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "${cubit.items[index].name}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              // GestureDetector(
                              //   onTap: () {
                              //     // Navigator.push(context,MaterialPageRoute(builder: (context) => ItemsScreen()));
                              //     categoryId ="${cubit.categories[index].name}";
                              //   },
                              //   child: Container(
                              //     height: 30,
                              //     width: 30,
                              //     decoration: BoxDecoration(
                              //       borderRadius: BorderRadius.circular(5),
                              //       // color: AppColor.paraColor,
                              //     ),
                              //     child: const Icon(
                              //         Icons.arrow_circle_right_rounded),
                              //   ),
                              //
                              // )
                            ],
                          ),
                        ),
                      )
                  )
                ],
              ),
            ),
                ),

          );
      }
    );
  }
}
