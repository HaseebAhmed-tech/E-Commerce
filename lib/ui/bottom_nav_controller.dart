import 'package:e_commerce/const/AppColors.dart';
import 'package:e_commerce/ui/bottom_nav_pages/cart.dart';
import 'package:e_commerce/ui/bottom_nav_pages/favorite.dart';
import 'package:e_commerce/ui/bottom_nav_pages/home.dart';
import 'package:e_commerce/ui/bottom_nav_pages/profile.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class BottomNavController extends StatefulWidget {
  const BottomNavController({Key? key}) : super(key: key);

  @override
  State<BottomNavController> createState() => _BottomNavControllerState();
}

class _BottomNavControllerState extends State<BottomNavController> {
  final List _pages = const [Home(), Favorite(), Cart(), Profile()];
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      //   title: Text(
      //     "E-Commerce",
      //     style: TextStyle(
      //       fontSize: 35.sm,
      //       color: Colors.black,
      //     ),
      //   ),
      //   centerTitle: true,
      //   automaticallyImplyLeading: false,
      // ),
      bottomNavigationBar: GNav(
        duration: const Duration(milliseconds: 300),
        gap: 4, // the tab button gap between icon and text
        color: Colors.grey, // unselected icon color
        activeColor: AppColors.deepOrange, // selected icon and text color
        iconSize: 24, // tab button icon size
        // selected tab background color
        padding: const EdgeInsets.symmetric(
            horizontal: 20, vertical: 10), // navigation bar padding
        tabs: const [
          GButton(
            icon: Icons.home,
            iconSize: 30,
            text: 'Home',
          ),
          GButton(
            icon: Icons.favorite_outline,
            text: 'Favorites',
            iconSize: 30,
          ),
          GButton(
            icon: Icons.add_shopping_cart_outlined,
            text: 'Cart',
            iconSize: 30,
          ),
          GButton(
            icon: Icons.person,
            text: 'Profile',
            iconSize: 30,
          )
        ],
        onTabChange: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      body: _pages[_currentIndex],
    );
  }
}
