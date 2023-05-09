// import 'package:firerest/reusable-widgets/big-text.dart';
// import 'package:flutter/material.dart';
//
// import 'package:smooth_page_indicator/smooth_page_indicator.dart';
//
// class FoodPageBody extends StatefulWidget {
//   const FoodPageBody({Key? key}) : super(key: key);
//
//   @override
//   State<FoodPageBody> createState() => _FoodPageBodyState();
// }
//
// class _FoodPageBodyState extends State<FoodPageBody> {
//
//   PageController pageController = PageController(viewportFraction: .85);
//   double scaleFactor=0.8;
//   double currentPageValue=0;
//   double height=Dimension.pageViewContainer;
//
//   List <String> images=[
//     "assets/image/food0.png",
//     "assets/image/food1.png",
//     "assets/image/food11.png",
//     "assets/image/food12.png",
//     "assets/image/food13.png",
//     "assets/image/food14.png",
//     "assets/image/food15.png",
//   ];
//
//
//   @override
//   void initState(){
//     super.initState();
//     pageController.addListener(() {
//       setState(() {
//         currentPageValue=pageController.page! ;
//       });
//     });
//
//   }
//   @override
//   void dispose(){
//     super.dispose();
//     pageController.dispose();
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         GetBuilder<PopularProductController>(builder: (popularProducts)=>Container(
//           margin: const EdgeInsets.only(top: 12),
//           height: Dimension.pageView,
//           child: PageView.builder(
//               controller: pageController,
//               itemCount: 5,
//               itemBuilder: (context, position) {
//                 // return _buildPageItem(position,popularProducts.popularProductList[position]);
//                 return _buildPageItem(position);
//               }),
//         ),),
//         SmoothPageIndicator(
//             controller: pageController,
//             count: 5,
//             effect: const ExpandingDotsEffect(
//                 expansionFactor: 3, dotWidth: 10, dotHeight: 10)),
//         SizedBox(height: Dimension.height30,),
//         Container(
//             margin: EdgeInsets.only(left: Dimension.width30),
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.end,
//               children: [
//                 BigText(text: "Popular",size: Dimension.font26,),
//                 SizedBox(width: Dimension.width10,),
//                 Container(
//                   margin: const EdgeInsets.only(bottom: 3),
//                   child: SmallText(text: ".",color: Colors.black26,),
//                 ),
//                 SizedBox(width: Dimension.width10,),
//                 Container(
//                   margin: const EdgeInsets.only(bottom: 2),
//                   child: SmallText(text: "Food pairing",),
//                 ),
//               ],
//             )),
//         SizedBox(height: Dimension.height30,),
//         ListView.builder(
//             physics: const NeverScrollableScrollPhysics(),
//             shrinkWrap: true,
//             itemCount: 5,
//             itemBuilder: (context,index){
//               return GestureDetector(
//                 onTap: (){
//                   Get.toNamed(RouteHelper.getRecommendedFood());
//                 },
//                 child: Container(
//                   margin: EdgeInsets.only(bottom:Dimension.height20,left: Dimension.width20,right: Dimension.width20),
//                   child: Row(
//                     children: [
//                       Container(
//                         width:Dimension.listViewImgSize,
//                         height:Dimension.listViewImgSize,
//                         decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.circular(Dimension.radius20),
//                             image:  DecorationImage(
//                               fit: BoxFit.cover,
//                               image: AssetImage(images[index]),
//                             )
//                         ),
//                       ),
//                       Expanded(
//                         child: Container(
//                           height: Dimension.listViewTextContSize,
//                           decoration: BoxDecoration(
//                             // boxShadow: [
//                             //   BoxShadow(
//                             //     color: Colors.grey.shade200,
//                             //     // offset: Offset(0,5)
//                             //   )
//                             // ],
//                               color: Colors.white,
//                               borderRadius: BorderRadius.only(bottomRight: Radius.circular(Dimension.radius20),topRight: Radius.circular(Dimension.radius20))
//                           ),
//                           child: Padding(
//                             padding: EdgeInsets.only(left: Dimension.width10,right: Dimension.width10),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 BigText(text: "Nutritious fruit meal in China"),
//                                 SizedBox(height: Dimension.height10,),
//                                 SmallText(text: 'with chinese characteristics'),
//                                 SizedBox(height: Dimension.height10,),
//                                 Row(
//                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                   children: const [
//                                     IconAndTextWidget(
//                                         icon: Icons.circle_sharp,
//                                         text: "Normal",
//                                         iconColor: AppColor.iconColor1),
//
//                                     IconAndTextWidget(
//                                         icon: Icons.location_on,
//                                         text: "1.7 km",
//                                         iconColor: AppColor.mainColor),
//
//                                     IconAndTextWidget(
//                                         icon: Icons.watch_later_outlined,
//                                         text: "32m",
//                                         iconColor: AppColor.iconColor1),
//
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//               );
//             }),
//       ],
//     );
//   }
//
//   Widget _buildPageItem(int index){
//     // _buildPageItem(int index, ProductModel productModel)
//     Matrix4 matrix =Matrix4.identity();
//
//     if(index==currentPageValue.floor()){
//       var currentScale = 1-(currentPageValue-index)*(1-scaleFactor);
//       var currentTrans= height*(1-currentScale)/2;
//       matrix = Matrix4.diagonal3Values(1, currentScale, 1)..setTranslationRaw(0, currentTrans, 0);
//
//     } else if(index==currentPageValue.floor()+1){
//       var currentScale=scaleFactor+(currentPageValue-index+1)*(1-scaleFactor);
//       var currentTrans= height*(1-currentScale)/2;
//       matrix = Matrix4.diagonal3Values(1, currentScale, 1);
//       matrix=Matrix4.diagonal3Values(1, currentScale, 1)..setTranslationRaw(0, currentTrans, 0);
//
//     } else if(index==currentPageValue.floor()-1){
//       var currentScale = 1-(currentPageValue-index)*(1-scaleFactor);
//       var currentTrans= height*(1-currentScale)/2;
//       matrix=Matrix4.diagonal3Values(1, currentScale, 1);
//       matrix=Matrix4.diagonal3Values(1, currentScale, 1)..setTranslationRaw(0, currentTrans, 0);
//
//     } else {
//       var currentScale=0.8;
//       matrix =Matrix4.diagonal3Values(1, currentScale, 1)..setTranslationRaw(0, height*(1-scaleFactor), 2);
//     }
//
//     return Transform(
//       transform: matrix,
//       child: Stack(
//         children: [
//           GestureDetector(
//             onTap: (){
//
//             },
//             child: Container(
//               margin: EdgeInsets.only(right: Dimension.width10,left: Dimension.width10) ,
//               height: Dimension.pageViewContainer,
//               decoration: BoxDecoration(
//                   color:index.isEven?const Color(0xFF69c5df):const Color(0xFF9294cc),
//                   borderRadius: BorderRadius.circular(Dimension.radius30),
//                   image:  DecorationImage(
//                       fit: BoxFit.cover,
//                       image: AssetImage(images[index])
//                   )
//
//               ),
//             ),
//           ),
//           Align(
//             alignment: Alignment.bottomCenter,
//             child: Container(
//               margin: EdgeInsets.only(right: Dimension.width30,left:Dimension.width30,bottom: Dimension.height30 ) ,
//               height: Dimension.pageViewTextContainer,
//               decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(Dimension.radius20),
//                   boxShadow:  const [
//                     BoxShadow(
//                         color: Color(0xFFe8e8e8),
//                         // spreadRadius: .4,
//                         blurRadius: 5,
//                         offset: Offset(0,3)
//                     ),
//                     // BoxShadow(
//                     //     color: Colors.white,
//                     //     offset: Offset(-3,0)
//                     // ),
//                     // BoxShadow(
//                     //     color: Colors.white,
//                     //     offset: Offset(3,0)
//                     // )
//                   ]
//               ),
//               child: Container(
//                 padding:  EdgeInsets.only(top: Dimension.height15,left: Dimension.width15,right: Dimension.width15),
//                 child: const AppColumn(text: "Chinese Side",),
//               ),
//             ),
//           ),
//         ],
//
//       ),
//     );
//   }
//
// }
