
import 'package:firerest/cart-file/cart-cubit.dart';
import 'package:firerest/cart-file/cart-states.dart';
import 'package:firerest/home-file/home-cubit.dart';
import 'package:firerest/home-file/home-states.dart';
import 'package:firerest/shared/const.dart';
import 'package:firerest/styles/app-colors.dart';

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
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: ListView.builder(
            itemCount: cubit.items.length,
            itemBuilder: (context, index) =>foodItem(context,index)
                ),

          );
      }
    );
  }
  Widget foodItem(context,index){
    var cubit = HomeCubit.get(context);
    return  Container(
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
                  const EdgeInsets.only(left: 10,top: 5,bottom: 10,right: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        "${cubit.items[index].name}",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            "\$${cubit.items[index].price}",
                            style: const TextStyle(
                            ),
                          ),
                          Container(
                              child: cubit.itemQuantity==0
                                  ? GestureDetector(
                                onTap: (){
                                  cubit.editItemQuantity("plus");
                                },
                                child: Container(
                                  padding: EdgeInsets.all(7),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25),
                                      color: AppColor.mainColor
                                  ),
                                  child: Text("Add to Cart",style: TextStyle(fontSize: 11,fontWeight: FontWeight.bold),),
                                ),
                              )
                                  : SizedBox(
                                width: 65,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      onTap: (){
                                        cubit.editItemQuantity("minus");
                                      },
                                      child: const Icon(Icons.remove,color: AppColor.signColor,),
                                    ),
                                    Text("${cubit.itemQuantity}"),
                                    GestureDetector(
                                        onTap: (){
                                          cubit.editItemQuantity("plus");
                                        },
                                        child: const Icon(Icons.add,color: AppColor.signColor,size: 24,))
                                  ],
                                ),
                              )
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              )
          )
        ],
      ),
    );
  }
}
