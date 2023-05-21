
import 'package:firerest/home-file/home-cubit.dart';
import 'package:firerest/home-file/home-states.dart';
import 'package:firerest/shared/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<HomeCubit,HomeStates>(
        builder: (context,state){
          var cubit = HomeCubit.get(context);
          return Scaffold(
            body: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: (){
                        print("${cartItems.length}");
                      },
                      child: Container(
                        width: 100,
                        height: 30,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.black
                        ),
                        child: const Center(child: Text("Cart",style: TextStyle(color: Colors.white,fontWeight:FontWeight.bold,fontSize: 20),)),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10,),
                Expanded(
                  child: ListView.builder(
                      itemCount:cartItems.length,
                      itemBuilder: (context,index){
                        return  cartItem(context,index);
                      }),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget cartItem(context,index){
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
                  image: NetworkImage("${cartItems[index].img}"),
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
                        "${cartItems[index].name}",
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
                            "${cartItems[index].price}",
                            style: const TextStyle(
                            ),
                          ),
                          Container(
                            child: Row(
                              children: [
                                IconButton(onPressed: (){}, icon: Icon(Icons.minimize,size: 18,)),
                                Text("${cartItems[index].quantity}"),
                                IconButton(onPressed: (){}, icon: Icon(Icons.add,size: 18,))
                              ],
                            ),
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
