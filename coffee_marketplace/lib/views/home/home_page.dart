import 'package:coffee_marketplace/views/home/home_banner.dart';
import 'package:coffee_marketplace/views/home/home_body.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HomeBanner(),
          HomeBody(),
        ],
      ),
    );
  }
}
