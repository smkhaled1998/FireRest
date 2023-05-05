import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firerest/home-layout/home-cubit.dart';
import 'package:firerest/home-layout/home-states.dart';
import 'package:firerest/screens/items-screen.dart';


import 'package:firerest/styles/app-colors.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class MenuScreen extends StatelessWidget {
   MenuScreen({Key? key}) : super(key: key);

var categoryController =TextEditingController();
var categoryUpdatedController =TextEditingController();

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<HomeCubit,HomeStates>(
        listener: (context,state){},
        builder: (context,state){
          var cubit =HomeCubit.get(context);
          return Scaffold(
              body: SafeArea(
                child: Column(
                  children: [
                    Container(
                       margin: const EdgeInsets.symmetric(horizontal: 15),
                       child: Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Categories",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),),
                            MaterialButton(
                              color: AppColor.mainColor,
                              child:const Text ("Add new category"),
                              onPressed: (){
                                showModalBottomSheet(
                                    isScrollControlled: true,
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.vertical(top: Radius.circular(20))
                                    ),
                                    context: context,
                                    builder: (context){
                                      return buildBottomSheet(context);
                                    }).then((value) {
                                  cubit.categoryImg = null;
                                  categoryController.text="";
                                });
                              },
                            )
                          ],
                        ),
                     ),
                    const SizedBox(height: 10,),
                    Expanded(
                      child: ConditionalBuilder(
                        condition: state is HomeGettingCategoryLoadingState,
                        builder: (context)=>const  Center(child: CircularProgressIndicator()),
                        fallback: (context)=> RefreshIndicator (
                          onRefresh: () async {cubit.getCategory();},
                          child:categoryList(context),
                        ),

                      ),
                    ),
                  ],
                ),
              ),
              // floatingActionButton: FloatingButton(
              // text: "Add new category",
              // callBack: (){
              //   showModalBottomSheet(
              //       isScrollControlled: true,
              //       shape: const RoundedRectangleBorder(
              //           borderRadius: BorderRadius.vertical(top: Radius.circular(20))
              //       ),
              //       context: context,
              //       builder: (context){
              //         return Padding(
              //           padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom)/3,
              //           child: Container(
              //             margin: const EdgeInsets.symmetric(horizontal: 10),
              //             height: 400,
              //             decoration: BoxDecoration(
              //                 borderRadius: BorderRadius.circular(20),
              //                 color: Colors.white
              //             ),
              //             child: Column(
              //               mainAxisAlignment: MainAxisAlignment.start,
              //               children: [
              //                 const SizedBox(height: 15,),
              //                 Row(
              //                   children: [
              //                     Stack(
              //                       children: [
              //                         ClipOval(
              //
              //                             child: SizedBox(
              //                               width: 100,
              //                               height: 100,
              //                               child: cubit.categoryImg == null
              //                                   ? Image.asset(
              //                                   "assets/logo part 1.png",
              //                                   fit: BoxFit.cover)
              //                                   : Image(image: FileImage(
              //                                 cubit.categoryImg!,),fit: BoxFit.cover,),
              //                             )
              //                         ),
              //
              //                         Align(
              //                           alignment: Alignment.topRight,
              //                           child: CircleAvatar(
              //                               radius: 20,
              //                               backgroundColor: Colors.transparent,
              //                               child: IconButton(
              //                                   onPressed: () {
              //                                     cubit.pickCategoryImg();
              //                                     print("object");
              //                                   },
              //                                   icon: const Icon (
              //                                     Icons.camera_alt, size: 15,))),
              //                         ),
              //
              //                       ],
              //                     ),
              //                     Expanded(
              //                       child: Container(
              //                           margin: const EdgeInsets.symmetric(horizontal: 7),
              //                           decoration: BoxDecoration(
              //                               borderRadius:BorderRadius.circular(15)
              //                           ),
              //                           child: TextFormField(
              //                             controller: categoryController,
              //                             decoration: const InputDecoration(
              //                                 hintText: "Category Name"
              //                             ),
              //                           )
              //                       ),
              //                     ),
              //                   ],
              //                 ),
              //                 MaterialButton(
              //                   color: AppColor.mainColor,
              //                   onPressed: (){
              //                     cubit.uploadCategoryImg(
              //                         categoryName:categoryController.text
              //                     );
              //                     Navigator.pop(context);
              //                   },
              //                   child: const Text("Submit"),)
              //               ],
              //             ),
              //           ),
              //         );
              //       }).then((value) {
              //     cubit.categoryImg = null;
              //     categoryController.text="";
              //   });
              // },),
              // floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,

          );
        }
      );
  }

  Widget categoryList(context){
    var cubit =HomeCubit.get(context);
    return  ListView.builder(
      itemCount: cubit.categories.length,
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
                    return buildBottomSheet(context);
                  }).then((value) {
                cubit.categoryImg = null;
                categoryUpdatedController.text="";
              });
            },
              icon: Icons.edit,
              foregroundColor: Colors.blue,
            ),
            SlidableAction(onPressed: (context){
              cubit.removeCategory(
                  categoryName: "${cubit.categories[index].name}"
              );
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
                      image: NetworkImage("${cubit.categories[index].img}"),
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "${cubit.categories[index].name}",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context)=> ItemsScreen()));
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

  Widget buildBottomSheet(context){
    var cubit =HomeCubit.get(context);
    return  Padding(
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
                          child: cubit.categoryImg == null
                              ? Image.asset(
                              "assets/logo part 1.png",
                              fit: BoxFit.cover)
                              : Image(image: FileImage(
                            cubit.categoryImg!,),fit: BoxFit.cover,),
                        )
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.transparent,
                          child: IconButton(
                              onPressed: () {
                                cubit.pickCategoryImg();
                                print("object");
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
                        controller: categoryController,
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
                cubit.uploadCategoryImg(
                    categoryName:categoryController.text
                );
                Navigator.pop(context);
              },
              child: const Text("Submit"),)
          ],
        ),
      ),
    );;
  }
}

