import 'package:coffee_marketplace/views/home/home_banner.dart';
import 'package:coffee_marketplace/views/home/home_body.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final Future Function() getData;
  const HomePage({super.key, required this.getData});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // TODO: search section with chat button
          const HomeBanner(),
          HomeBody(getData: getData),
        ],
      ),
    );
  }
}
