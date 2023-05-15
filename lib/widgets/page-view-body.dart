
import 'package:firerest/home-file/home-cubit.dart';
import 'package:firerest/home-file/home-states.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';


class PageViewBody extends StatefulWidget {

   PageViewBody({Key? key}) : super(key: key);

  @override
  State<PageViewBody> createState() => _PageViewBodyState();
}

class _PageViewBodyState extends State<PageViewBody> {
  PageController pageController = PageController(viewportFraction: .85);// this inform that how much the main card will take from the width of the screen

  double scaleFactor=0.8; // the length of the card >> the main one is 1 so it takes all height, however the other 2 cards only take .8 of the height
  double currentPageValue=0;
  double height=20;



  @override
  void initState(){
    super.initState();
    pageController.addListener(() {
      setState(() {
        currentPageValue=pageController.page! ;
      });
    });

  }
  @override
  void dispose(){
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit,HomeStates>(
    listener: (context,state){},
    builder: (context,state){
      var cubit = HomeCubit.get(context);

      return Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 12),
            height: 210,
            child: PageView.builder(
                controller: pageController,
                itemCount: cubit.categories.length,
                itemBuilder: (context, position) {
                  return _buildPageItem(position,context);
                }),
          ),
          const SizedBox(height: 5,),
          SmoothPageIndicator(
              controller: pageController,
              count: cubit.categories.length,
              effect: const ExpandingDotsEffect(
                  expansionFactor: 3, dotWidth: 10, dotHeight: 10)),
          const SizedBox(height: 10,),


        ],
      );
    },
    );
  }

  Widget _buildPageItem(int index,context){
var cubit =HomeCubit.get(context);
Matrix4 matrix =Matrix4.identity();

    if(index==currentPageValue.floor()){
      var currentScale = 1-(currentPageValue-index)*(1-scaleFactor);
      var currentTrans= height*(1-currentScale)/2;
      matrix = Matrix4.diagonal3Values(1, currentScale, 1)..setTranslationRaw(0, currentTrans, 0);

    }
    else if(index==currentPageValue.floor()+1){
      var currentScale=scaleFactor+(currentPageValue-index+1)*(1-scaleFactor);
      var currentTrans= height*(1-currentScale)/2;
      matrix = Matrix4.diagonal3Values(1, currentScale, 1);
      matrix=Matrix4.diagonal3Values(1, currentScale, 1)..setTranslationRaw(0, currentTrans, 0);

    }
    else if(index==currentPageValue.floor()-1){
      var currentScale = 1-(currentPageValue-index)*(1-scaleFactor);
      var currentTrans= height*(1-currentScale)/2;
      matrix=Matrix4.diagonal3Values(1, currentScale, 1);
      matrix=Matrix4.diagonal3Values(1, currentScale, 1)..setTranslationRaw(0, currentTrans, 0);

    }
    else {
      var currentScale=0.8;
      matrix =Matrix4.diagonal3Values(1, currentScale, 1)..setTranslationRaw(0, height*(1-scaleFactor), 2);
    }
    return Transform(
      transform: matrix,
      child: Stack(
        children: [
          GestureDetector(
            onTap: (){

            },
            child: Container(
              margin: EdgeInsets.only(right: 10,left: 10) ,
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
                  child: Center(child: Text("${cubit.categories[index].name}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24),),)
              ),
            ),
          ),
        ],

      ),
    );

  }
}

