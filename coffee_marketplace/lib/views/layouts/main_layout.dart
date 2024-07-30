import 'package:coffee_marketplace/utils/app_constants.dart';
import 'package:coffee_marketplace/viewmodels/kategori_view_model.dart';
import 'package:coffee_marketplace/viewmodels/keranjang_view_model.dart';
import 'package:coffee_marketplace/viewmodels/produk_view_model.dart';
import 'package:coffee_marketplace/viewmodels/user_view_model.dart';
import 'package:coffee_marketplace/views/home/home_page.dart';
import 'package:coffee_marketplace/views/keranjang/keranjang_page.dart';
import 'package:coffee_marketplace/views/profil/profil_page.dart';
import 'package:coffee_marketplace/views/widgets/nav_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _currentIndex = 0;

  List<Widget> get _pages => [
        HomePage(getData: getData),
        const KeranjangPage(),
        const ProfilPage(),
      ];

  final _appBars = [
    AppBar(
      toolbarHeight: 0,
      backgroundColor: AppConstants.background,
      surfaceTintColor: Colors.transparent,
    ),
    AppBar(
      elevation: 0,
      backgroundColor: AppConstants.background,
      title: const Text(
        "Keranjang",
        style: TextStyle(
          fontFamily: "Abhaya Libre",
          fontWeight: FontWeight.w800,
          fontSize: 18,
        ),
      ),
      surfaceTintColor: Colors.transparent,
      titleSpacing: 0,
      centerTitle: true,
    ),
    AppBar(
      elevation: 0,
      backgroundColor: AppConstants.background,
      title: const Text(
        "Profil",
        style: TextStyle(
          fontFamily: "Abhaya Libre",
          fontWeight: FontWeight.w800,
          fontSize: 18,
        ),
      ),
      surfaceTintColor: Colors.transparent,
      titleSpacing: 0,
      centerTitle: true,
    ),
  ];

  void changePage(int index) {
    if (index != 1) {
      context.read<KeranjangViewModel>().updateKeranjang();
    }
    setState(() => _currentIndex = index);
  }

  Future getData() async {
    await Future.wait([
      context.read<ProdukViewModel>().getProduk(),
      context.read<KategoriViewModel>().getKategori(),
      context.read<UserViewModel>().authCheck(),
    ]);
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      appBar: _appBars[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: _currentIndex,
        backgroundColor: AppConstants.secondaryAlt,
        iconSize: 35,
        selectedItemColor: Colors.black,
        onTap: changePage,
        selectedFontSize: 0,
        unselectedFontSize: 0,
        items: const [
          // TODO: active icons
          BottomNavigationBarItem(
            label: "Home",
            tooltip: "Home",
            icon: NavItem(
              iconPath: "assets/icons/ic_nav_home.svg",
              isActive: false,
            ),
            activeIcon: NavItem(
              iconPath: "assets/icons/ic_nav_home.svg",
              isActive: true,
            ),
          ),
          BottomNavigationBarItem(
            label: "Keranjang",
            tooltip: "Keranjang",
            icon: NavItem(
              iconPath: "assets/icons/ic_nav_keranjang.svg",
              isActive: false,
            ),
            activeIcon: NavItem(
              iconPath: "assets/icons/ic_nav_keranjang.svg",
              isActive: true,
            ),
          ),
          BottomNavigationBarItem(
            label: "Profil",
            tooltip: "Profil",
            icon: NavItem(
              iconPath: "assets/icons/ic_nav_profil.svg",
              isActive: false,
            ),
            activeIcon: NavItem(
              iconPath: "assets/icons/ic_nav_profil.svg",
              isActive: true,
            ),
          ),
        ],
      ),
    );
  }
}
