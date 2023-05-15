import 'package:firerest/home-file/home-cubit.dart';
import 'package:firerest/home-file/home-states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PageViewWidget extends StatelessWidget {
  final int index;
  const PageViewWidget({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit,HomeStates>(
        listener: (context,state){},
        builder: (context,state){
          var cubit=HomeCubit.get(context);
          return Stack(
            children: [
              GestureDetector(
                onTap: (){
                },
                child: Container(
                  margin: const EdgeInsets.only(right: 10,left: 10) ,
                  height: 150,
                  decoration: BoxDecoration(
                      color:index.isEven?const Color(0xFF69c5df):const Color(0xFF9294cc),
                      borderRadius: BorderRadius.circular(30),
                      image:  DecorationImage(
                          fit: BoxFit.cover,
                          image:NetworkImage("${cubit.categories[index].img}")
                      )

                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin: const EdgeInsets.only(right: 30,left:30,bottom:30 ) ,
                  height: 60,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow:  const [
                        BoxShadow(
                            color: Color(0xFFe8e8e8),
                            // spreadRadius: .4,
                            blurRadius: 5,
                            offset: Offset(0,3)
                        ),
                        // BoxShadow(
                        //     color: Colors.white,
                        //     offset: Offset(-3,0)
                        // ),
                        // BoxShadow(
                        //     color: Colors.white,
                        //     offset: Offset(3,0)
                        // )
                      ]
                  ),
                  child: Container(
                      padding:  const EdgeInsets.all(15),
                      child: Center(child: Text("${cubit.categories[index].name}",style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 24),),)
                  ),
                ),
              ),
            ],

          );
          //   Container(
          //   width: MediaQuery.of(context).size.width*.6,
          //   height: 350,
          //   padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 17),
          //   margin: const EdgeInsets.only(right: 17,top: 5),
          //   decoration: BoxDecoration(
          //       color: AppColor.mainColor,
          //       borderRadius: BorderRadius.circular(24),
          //       boxShadow: [
          //         BoxShadow(
          //             color: Colors.grey.shade500,
          //             blurRadius: 2,
          //             spreadRadius: 1
          //         )
          //       ]
          //   ),
          //   child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       Container(
          //         height: 180,
          //         decoration:  BoxDecoration(
          //             borderRadius: BorderRadius.circular(16),
          //             image:  DecorationImage(
          //                 fit: BoxFit.cover,
          //                 image:NetworkImage("${cubit.categories[0].img}")
          //                 )
          //             )
          //         ),
          //
          //       SizedBox(height: 10,),
          //       Text("${cubit.categories[0].name}",style: TextStyle(fontWeight: FontWeight.bold)),
          //
          //     ],
          //   ),
          // );
        }

    );
  }
}
