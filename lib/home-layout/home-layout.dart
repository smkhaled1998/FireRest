import 'package:firerest/home-layout/home-cubit.dart';
import 'package:firerest/home-layout/home-states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:(context)=>HomeCubit(),
      child: BlocConsumer<HomeCubit,HomeStates>(
        listener: (context,state){},
        builder: (context,state){
          var cubit = HomeCubit.get(context);
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
      ),
    );
  }
}
