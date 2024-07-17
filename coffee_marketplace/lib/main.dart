import 'package:coffee_marketplace/utils/app_constants.dart';
import 'package:coffee_marketplace/views/layouts/main_layout.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
        "/": (context) => const MainLayout(),
      },
    );
  }
}
