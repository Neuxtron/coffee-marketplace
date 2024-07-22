import 'package:carousel_slider/carousel_slider.dart';
import 'package:coffee_marketplace/utils/app_constants.dart';
import 'package:coffee_marketplace/views/widgets/error_image.dart';
import 'package:coffee_marketplace/views/widgets/loading_image.dart';
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
      child: CarouselSlider(
        items: listBanner.map((banner) {
          return Image.network(
            "${AppConstants.baseUrl}/images/banner/$banner",
            height: 200,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return const LoadingImage();
            },
            errorBuilder: (context, error, stackTrace) {
              return const ErrorImage(height: 200);
            },
          );
        }).toList(),
        options: CarouselOptions(
          height: 200,
          viewportFraction: 1,
          autoPlay: true,
        ),
      ),
    );
  }
}
