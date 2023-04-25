import 'package:flutter/material.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home),label: "Explore"),
          BottomNavigationBarItem(icon: Icon(Icons.menu),label: "menu"),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart_checkout_outlined),label: "Cart"),
        ],),
    );
  }
}
