

import 'package:firerest/home-file/home-cubit.dart';
import 'package:firerest/home-file/home-states.dart';
import 'package:firerest/models/cart-model.dart';
import 'package:firerest/models/items-model.dart';
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
                borderRadius: BorderRadius.only(topLeft: Radius.circular(10),bottomLeft: Radius.circular(10)),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage("${cubit.items[index].img}"),
                )
            ),
          ),
          Expanded(
              child: Container(
                height: 100,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.shade200,
                          offset: const Offset(0, 2)
                      )
                    ],
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(
                        bottomRight: Radius.circular(10),
                        topRight: Radius.circular(10))),
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
                          GestureDetector(
                            onTap: (){
                              ItemsModel(
                                addedToCart: true
                              );
                              ItemsModel itemsModel= cubit.items[index];
                              String name ="${itemsModel.name}";
                              String img ="${itemsModel.img}";
                              String price ="${itemsModel.price}";
                              itemsModel.addedToCart=true;
                              print(itemsModel.addedToCart);
                              // cubit.toggleCartState();
                              // cartItems[index].addedToCart = !(cartItems[index].addedToCart);
                              cubit.addItemsToCart(name,img,price);
                            },
                            child: cubit.items[index].addedToCart!
                                ?Container(
                              padding: EdgeInsets.all(7),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  color: Colors.black
                              ),

                              child:
                              const Text("Remove from Cart",style: TextStyle(color:Colors.white,fontSize: 11,fontWeight: FontWeight.bold),),
                            )
                                : Container(
                              padding: EdgeInsets.all(7),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Colors.black
                  ),
                  child: const Text("Add to Cart",style: TextStyle(color:Colors.white,fontSize: 11,fontWeight: FontWeight.bold),),
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
