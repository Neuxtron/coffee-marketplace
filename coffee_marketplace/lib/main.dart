import 'package:coffee_marketplace/utils/app_constants.dart';
import 'package:coffee_marketplace/viewmodels/kategori_view_model.dart';
import 'package:coffee_marketplace/viewmodels/keranjang_view_model.dart';
import 'package:coffee_marketplace/viewmodels/produk_view_model.dart';
import 'package:coffee_marketplace/views/detail/details_page.dart';
import 'package:coffee_marketplace/views/kategori/kategori_page.dart';
import 'package:coffee_marketplace/views/layouts/main_layout.dart';
import 'package:coffee_marketplace/views/login/login_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProdukViewModel()),
        ChangeNotifierProvider(create: (context) => KategoriViewModel()),
        ChangeNotifierProvider(create: (context) => KeranjangViewModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Coffee Marketplace",
        theme: ThemeData(
          fontFamily: "Lato",
          scaffoldBackgroundColor: AppConstants.background,
          colorScheme: ColorScheme.fromSeed(
            seedColor: AppConstants.primary,
          ),
        ),
        initialRoute: "/",
        routes: {
          // TODO: auth
          // TODO: login & register
          "/": (context) => const MainLayout(),
          "/details": (context) => const DetailsPage(),
          "/kategori": (context) => const KategoriPage(),
          "/login": (context) => const LoginPage(),
        },
      ),
    );
  }
}
