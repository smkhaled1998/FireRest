import 'package:flutter/material.dart';

import '../../models/food-model.dart';


class FoodItem extends StatelessWidget {
final Food food;
final Function? callback;
const FoodItem (this.food,{super.key, this.callback});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
            color: Colors.white
      ),
      child: Row(
        children: [
          SizedBox(

            width: 110,
            height: 110,
           child: Image.asset("${food.imgUrl}",fit: BoxFit.fitHeight),
          ),
          Expanded(child: Container(
            padding: const EdgeInsets.only(top: 10,left: 20,right: 20),
            height: 110,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("${food.name}",style: const TextStyle(fontWeight: FontWeight.bold),),
                    GestureDetector(
                      onTap: ()=>callback!,
                      child: const Icon(Icons.arrow_forward_ios_outlined),
                    )
                  ],
                ),
                const SizedBox(height: 5,),
                Text(("${food.desc}")),
                const SizedBox(height: 10,),
                Text(("\$${food.price}"))
              ],
            ),
          )  )
        ],
      ),
    );
  }
}
