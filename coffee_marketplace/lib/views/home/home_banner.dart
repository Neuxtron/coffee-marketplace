import 'package:carousel_slider/carousel_slider.dart';
import 'package:coffee_marketplace/utils/app_constants.dart';
import 'package:flutter/material.dart';

class HomeBanner extends StatelessWidget {
  const HomeBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final dummyBanner = [
      "banner_1.png",
      "banner_2.png",
      "banner_3.png",
      "banner_4.png",
      "banner_5.png",
    ];
    final listBanner = dummyBanner;

    return Container(
      color: AppConstants.secondaryAlt,
      child: SafeArea(
        child: CarouselSlider(
          items: listBanner.map((banner) {
            return Image.network(
              "${AppConstants.baseUrl}/images/banner/$banner",
              height: 200,
              fit: BoxFit.cover,
            );
          }).toList(),
          options: CarouselOptions(
            height: 200,
            viewportFraction: 1,
            autoPlay: true,
          ),
        ),
      ),
    );
  }
}
