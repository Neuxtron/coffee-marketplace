import 'package:coffee_marketplace/utils/app_constants.dart';
import 'package:coffee_marketplace/views/home/home_page.dart';
import 'package:flutter/material.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _currentIndex = 0;
  final _pages = [
    const HomePage(),
    const Center(child: Text("Keranjang")),
    const Center(child: Text("Saya")),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: _currentIndex,
        backgroundColor: AppConstants.secondaryAlt,
        iconSize: 35,
        selectedItemColor: Colors.black,
        onTap: (index) => setState(() => _currentIndex = index),
        selectedFontSize: 0,
        unselectedFontSize: 0,
        items: const [
          BottomNavigationBarItem(
            label: "Home",
            tooltip: "Home",
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home_rounded),
          ),
          BottomNavigationBarItem(
            label: "Keranjang",
            tooltip: "Keranjang",
            icon: Icon(Icons.shopping_basket_outlined),
            activeIcon: Icon(Icons.shopping_basket_rounded),
          ),
          BottomNavigationBarItem(
            label: "Saya",
            tooltip: "Saya",
            icon: Icon(Icons.person_outlined),
            activeIcon: Icon(Icons.person_rounded),
          ),
        ],
      ),
    );
  }
}
