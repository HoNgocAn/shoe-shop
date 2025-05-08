import 'package:flutter/material.dart';
import 'package:shoe_shop_flutter/view/cart_screen.dart';
import 'package:shoe_shop_flutter/view/favorite_list_screen.dart';
import 'package:shoe_shop_flutter/view/home_screen.dart';
import 'package:shoe_shop_flutter/view/order_screen.dart';
import 'package:shoe_shop_flutter/view/profile_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  final List<Widget> pages = [
    const HomeScreen(),
    const FavoriteListScreen(),
    const CartScreen(),
    const OrderScreen(),
    const ProfileScreen(),
  ];

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        elevation: 5,
        iconSize: 32,
        selectedItemColor: Colors.pinkAccent,
        unselectedItemColor: Colors.black45,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        type: BottomNavigationBarType.fixed,
        currentIndex: selectedIndex,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Image.asset(
              "asset/images/home_dashboard.png",
              height: 30,
              color: selectedIndex == 0 ? Colors.pinkAccent : Colors.black45,
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              "asset/images/favorite_dashboard.png",
              height: 30,
              color: selectedIndex == 1 ? Colors.pinkAccent : Colors.black45,
            ),
            label: "Favorite",
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              "asset/images/cart_dashboard.png",
              height: 30,
              color: selectedIndex == 2 ? Colors.pinkAccent : Colors.black45,
            ),
            label: "Cart",
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              "asset/images/order_dashboard.png",
              height: 30,
              color: selectedIndex == 3 ? Colors.pinkAccent : Colors.black45,
            ),
            label: "Order",
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              "asset/images/profile_dashboard.png",
              height: 30,
              color: selectedIndex == 4 ? Colors.pinkAccent : Colors.black45,
            ),
            label: "Profile",
          ),
        ],
      ),
      body: pages[selectedIndex],
    );
  }
}