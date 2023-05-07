import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

import 'package:firerest/items-file/item-cubit.dart';
import 'package:firerest/items-file/item-states.dart';
import 'package:firerest/shared/const.dart';
import 'package:firerest/styles/app-colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ItemsScreen extends StatelessWidget {
   ItemsScreen({Key? key}) : super(key: key);

  var itemController = TextEditingController();
  var  itemUpdatedController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>ItemsCubit()..getItems(categoryId: categoryId),
      child: BlocConsumer<ItemsCubit,ItemsStates>(
        listener: (context,state){},
        builder: (context,state){
          var cubit =ItemsCubit.get(context);
          return Scaffold(
            body:
            SafeArea(
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Items",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),),
                        MaterialButton(
                          color: AppColor.mainColor,
                          child:const Text ("Add new item"),
                          onPressed: (){
                            showModalBottomSheet(
                                isScrollControlled: true,
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(top: Radius.circular(20))
                                ),
                                context: context,
                                builder: (context){
                                  return buildBottomSheet();
                                }).then((value) {
                              cubit.itemImg = null;
                              itemController.text="";
                            });
                          },
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 10,),
                  Expanded(
                    child: ConditionalBuilder(
                      condition: state is ItemsGettingDataSuccessState,
                      builder: (context)=>RefreshIndicator (
                        onRefresh: () async{},
                        child:itemList(context),
                      ),
                      fallback: (context)=> const  Center(child: CircularProgressIndicator()),

                    ),
                  ),
                ],
              ),
            ),
          );
        },

      ),
    );
  }

  Widget itemList(context){
    var cubit =ItemsCubit.get(context);
    return  ListView.builder(
      itemCount: cubit.items.length,
      itemBuilder:(context,index)=> Slidable(
        startActionPane:ActionPane(
          motion: const StretchMotion(),
          children: [
            SlidableAction(onPressed: (context){
              print("it is clicked");
              showModalBottomSheet(
                  isScrollControlled: true,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(20))
                  ),
                  context: context,
                  builder: (context){
                    return buildBottomSheet();
                  }).then((value) {
                // cubit.categoryImg = null;
                // itemUpdatedController.text="";
              });
            },
              icon: Icons.edit,
              foregroundColor: Colors.blue,
            ),
            SlidableAction(onPressed: (context){
              // cubit.removeCategory(
              //     categoryName: "${cubit.categories[index].name}"
              // );
            },
              icon: Icons.delete,
              foregroundColor: Colors.red,
            ),
          ],
        ) ,
        child: Container(
          margin: const EdgeInsets.only(bottom:20,left: 20,right:20),
          child: Row(
            children: [
              Container(
                width:100,
                height:100,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    image:  DecorationImage(
                      fit: BoxFit.cover,
                      image:NetworkImage("${cubit.items[index].img}"),
                      // NetworkImage("${cubit.categories[index].img}"),
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
                              offset: const Offset(0,2)
                          )
                        ],
                        color: Colors.white,
                        borderRadius: const BorderRadius.only(bottomRight: Radius.circular(20),topRight: Radius.circular(20))),
                    child: Padding(
                      padding:
                      const EdgeInsets.only(left: 10, right: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text("${cubit.items[index].name}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              GestureDetector(
                                onTap: () {
                                  // Navigator.push(context, MaterialPageRoute(builder: (context)=> ItemsScreen()));
                                },
                                child: Container(
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    // color: AppColor.paraColor,
                                  ),
                                  child: const Icon(Icons.arrow_circle_right_rounded),
                                ),

                              ) ],
                          ),
                          Text("${cubit.items[index].description}",
                            style: const TextStyle(
                                ),
                          ),
                          const SizedBox(height: 5,),
                          Text("\$ ${cubit.items[index].price}",
                            style: const TextStyle(
                                ),
                          ),

                        ],
                      ),
                    ),
                  )
              )],
          ),
        ),
      ),
      //     Container(
      //   margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      //   height: 100,
      //   decoration: BoxDecoration(
      //     borderRadius: BorderRadius.circular(20),
      //     color: Colors.white,
      //   ),
      //   child: Row(
      //     children: [
      //       Container(
      //         decoration: BoxDecoration(
      //           borderRadius: BorderRadius.circular(15),
      //         ),
      //         width: 110,
      //         height: 110,
      //         child: Image(
      //           image: NetworkImage("${cubit.categories[index].img}"),
      //           fit: BoxFit.cover,
      //         ),
      //       ),
      //       Expanded(
      //         child: Container(
      //           padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
      //           height: 110,
      //           child: Column(
      //             crossAxisAlignment: CrossAxisAlignment.start,
      //             mainAxisAlignment: MainAxisAlignment.center,
      //             children: [
      //               Row(
      //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                 children: [
      //                   Text(
      //                     "${cubit.categories[index].name}",
      //                     style: const TextStyle(fontWeight: FontWeight.bold),
      //                   ),
      //                   Column(
      //                     children: [
      //                       GestureDetector(
      //                         onTap: () {},
      //                         child: Container(
      //                           height: 30,
      //                           width: 30,
      //                           decoration: BoxDecoration(
      //                             borderRadius: BorderRadius.circular(5),
      //                             color: AppColor.paraColor,
      //                           ),
      //                           child: const Icon(Icons.arrow_circle_right),
      //                         ),
      //                       ),
      //                       const SizedBox(height: 5),
      //                       GestureDetector(
      //                         onTap: () {},
      //                         child: Container(
      //                           height: 30,
      //                           width: 30,
      //                           decoration: BoxDecoration(
      //                             borderRadius: BorderRadius.circular(5),
      //                             color: AppColor.paraColor,
      //                           ),
      //                           child: const Icon(Icons.edit),
      //                         ),
      //                       ),
      //                     ],
      //                   ),
      //                 ],
      //               ),
      //               // const SizedBox(height: 5,),
      //               // Text(("Food desception}")),
      //               // const SizedBox(height: 10,),
      //               // Text(("\$price"))
      //             ],
      //           ),
      //         ),
      //       ),
      //     ],
      //   ),
      // )

    );
  }

  Widget buildBottomSheet() {
     return  BlocConsumer<ItemsCubit,ItemsStates>(
         listener: (context,state){},
         builder: (context,state){
           var cubit =ItemsCubit.get(context);
           return Padding(
             padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom)/3,
             child: Container(
               margin: const EdgeInsets.symmetric(horizontal: 10),
               height: 400,
               decoration: BoxDecoration(
                   borderRadius: BorderRadius.circular(20),
                   color: Colors.white
               ),
               child: Column(
                 mainAxisAlignment: MainAxisAlignment.start,
                 children: [
                   const SizedBox(height: 15,),
                   Row(
                     children: [
                       Stack(
                         children: [
                           ClipOval(
                               child: SizedBox(
                                 width: 100,
                                 height: 100,
                                 child: Image.asset(
                                     "assets/logo part 1.png",
                                     fit: BoxFit.cover)
                                 // cubit.categoryImg == null
                                 //     ? Image.asset(
                                 //     "assets/logo part 1.png",
                                 //     fit: BoxFit.cover)
                                 //     : Image(image: FileImage(
                                 //   cubit.categoryImg!,),fit: BoxFit.cover,),
                               )
                           ),
                           Align(
                             alignment: Alignment.topRight,
                             child: CircleAvatar(
                                 radius: 20,
                                 backgroundColor: Colors.transparent,
                                 child: IconButton(
                                     onPressed: () {
                                       cubit.pickImg();
                                     },
                                     icon: const Icon (
                                       Icons.camera_alt, size: 15,))),
                           ),

                         ],
                       ),
                       Expanded(
                         child: Container(
                             margin: const EdgeInsets.symmetric(horizontal: 7),
                             decoration: BoxDecoration(
                                 borderRadius:BorderRadius.circular(15)
                             ),
                             child: TextFormField(
                               controller: itemController,
                               decoration: const InputDecoration(
                                   hintText: "Category Name"
                               ),
                             )
                         ),
                       ),
                     ],
                   ),
                   MaterialButton(
                     color: AppColor.mainColor,
                     onPressed: (){
                       // cubit.uploadCategoryImg(
                       //     categoryName:itemController.text
                       // );
                       Navigator.pop(context);
                     },
                     child: const Text("Submit"),)
                 ],
               ),
             ),
           );
         }
     );
   }

}