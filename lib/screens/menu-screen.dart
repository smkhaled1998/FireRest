import 'package:firerest/home-layout/home-cubit.dart';
import 'package:firerest/home-layout/home-states.dart';
import 'package:firerest/styles/app-colors.dart';
import 'package:firerest/widgets/floating-button.dart';
import 'package:firerest/widgets/text-form-feild.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MenuScreen extends StatelessWidget {
   MenuScreen({Key? key}) : super(key: key);

var categoryController =TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit,HomeStates>(
      listener: (context,state){},
      builder: (context,state){
        var cubit =HomeCubit.get(context);
        return Scaffold(
            body: SafeArea(
              child: Column(
                children: [
                  Container(
                    width: 150,
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: AppColor.mainColor
                    ),
                    child: Center(child: Text("Categories")),
                  ),
                  Expanded(
                    child: ListView.builder(
                        itemCount: 3,
                        itemBuilder:(context,index)=> Card(
                          margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                          child: Container(
                            height: 100,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 110,
                                  height: 110,
                                  child:Image(image: NetworkImage("${cubit.categories[index].img}"),fit: BoxFit.cover,)
                                ),
                                Expanded(child: Container(
                                  padding: const EdgeInsets.only(top: 10,left: 20,right: 20),
                                  height: 110,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("${cubit.categories[index].name}",style: const TextStyle(fontWeight: FontWeight.bold),),
                                          Column(
                                            children: [
                                              GestureDetector(
                                                onTap: (){},
                                                child: Container(
                                                    height: 30,
                                                    width: 30,
                                                    decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(5),
                                                        color: AppColor.paraColor
                                                    ),
                                                    child: const Icon(Icons.arrow_circle_right)),
                                              ),
                                              SizedBox(height: 5,),
                                              GestureDetector(
                                                onTap: (){},
                                                child: Container(
                                                    height: 30,
                                                    width: 30,
                                                    decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(5),
                                                        color: AppColor.paraColor
                                                    ),
                                                    child: const Icon(Icons.edit)),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                      // const SizedBox(height: 5,),
                                      // Text(("Food desception}")),
                                      // const SizedBox(height: 10,),
                                      // Text(("\$price"))
                                    ],
                                  ),
                                )  )
                              ],
                            ),
                          ),
                        ) ),
                  ),
                ],
              ),
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
            floatingActionButton: FloatingButton(
              text: "Add new category",
              callBack: (){
                showModalBottomSheet(
                    isScrollControlled: true,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(20))
                    ),
                    context: context,
                    builder: (context){
                      return Padding(
                        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom)/3,
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          height: 400,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(height: 15,),
                              Row(
                                children: [
                                  Stack(
                                   children: [

                                     SizedBox(
                                       width: 100,
                                       height: 100,
                                       child: Image.asset("assets/logo part 1.png",fit: BoxFit.fitHeight),
                                     ),
                                     Align(
                                       alignment: Alignment.topRight,
                                       child: CircleAvatar(
                                           radius: 20,
                                           backgroundColor: Colors.transparent,
                                           child: IconButton(
                                               onPressed: () {
                                                 cubit.pickCategoryImage();
                                                 print("object");
                                               },
                                               icon: const Icon (
                                                 Icons.camera_alt, size: 15,))),
                                     ),

                                   ],
                                  ),
                                  Expanded(
                                    child: Container(
                                        margin: EdgeInsets.symmetric(horizontal: 7),
                                        decoration: BoxDecoration(
                                            borderRadius:BorderRadius.circular(15)
                                        ),

                                        child: TextFormField(
                                          controller: categoryController,
                                          decoration: InputDecoration(
                                              hintText: "Category Name"
                                          ),
                                        )
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    });
              },)
        );
      }
    );
  }
}