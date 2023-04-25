import 'package:flutter/material.dart';

import '../../models/food-model.dart';
import '../../models/restaurant-model.dart';
import '../../reusable-widgets/big-text.dart';
import '../../reusable-widgets/small-text.dart';
import '../../styles/app-colors.dart';


class RestaurantInfo extends StatelessWidget {

final restaurant=Restaurant.generateRestaurant();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      margin: const EdgeInsets.only(top:15,left: 15,right: 15 ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BigText(text: "${restaurant.name}",),
              SizedBox(height: 10,),

              Row(
                children: [
                  Container(
                    width: 80,
                    height: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.blueGrey
                    ),
                    child: Center(child: Text("${restaurant.waitTime}")),

                  ),
                  SizedBox(width: 10,),
                  SmallText(text: "${restaurant.label}"),
                  SizedBox(width: 10,),
                  SmallText(text:"${restaurant.name}")
                ],
              ),
              SizedBox(height: 10,),
              Text("${restaurant.desc}"),
            ],
          ),
          Column(
            children: [
          ClipRRect(
                borderRadius: BorderRadius.circular(80),
                child: Image.asset("${restaurant.logoUrl}",width: 80,)),
              // SizedBox(height: ,),
              Row(children: [
                Icon(Icons.star_border_outlined,color: kPrimaryColor,),
                Text("${restaurant.score}")
              ],)
            ],
          )
        ],
      ),
    );
  }
}

//
// class RestaurantInfo extends StatelessWidget {
// final restaurant=Restaurant.generateRestaurant();
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.symmetric(horizontal: 20),
//       child: Column(
//
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text("${restaurant.name}",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
//                       SizedBox(height: 7,),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                     Container(
//                       height: 25,
//                         width: 100,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(8),
//                           color: Colors.grey
//                         ),
//                         child: Center(child: Text("${restaurant.waitTime}"))),
//                       SizedBox(width: 10,),
//                       SmallText(text: "${restaurant.label}"),
//                       SizedBox(width: 10,),
//                       SmallText(text: "${restaurant.name}")
//
//                   ],)
//                 ],
//               ),
//               ClipRRect(
//                 borderRadius: BorderRadius.circular(80),
//                 child: Image.asset("${restaurant.logoUrl}",width: 80,),
//               )
//
//             ],
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text('"${restaurant.desc}" Bla Bla Bla'),
//               Row(
//                 children: [
//                   Icon(Icons.star_border_outlined,color: kPrimaryColor,),
//                   Text("${restaurant.score}")
//                 ],
//               )
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
