import 'package:firerest/category-file/category-cubit.dart';
import 'package:firerest/category-file/category-states.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CategoryCubit,CategoryStates>(
      listener: (context,state){},
      builder: (context,state){
        var cubit = CategoryCubit.get(context);
        return Scaffold(
          backgroundColor: Colors.white,
          body: cubit.screen[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(

            onTap: (index){
               cubit.changeBottomNavBar(index);
             },
             currentIndex: cubit.currentIndex,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home),label: "Explore"),
              BottomNavigationBarItem(icon: Icon(Icons.menu),label: "menu"),
              BottomNavigationBarItem(icon: Icon(Icons.shopping_cart_checkout_outlined),label: "Cart"),
            ],),
        );
      },
    );
  }
}
