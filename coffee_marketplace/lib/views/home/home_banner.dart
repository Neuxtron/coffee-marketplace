import 'package:carousel_slider/carousel_slider.dart';
import 'package:coffee_marketplace/utils/app_constants.dart';
import 'package:coffee_marketplace/viewmodels/banner_view_model.dart';
import 'package:coffee_marketplace/views/widgets/error_image.dart';
import 'package:coffee_marketplace/views/widgets/loading_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeBanner extends StatelessWidget {
  final bool isSearching;
  const HomeBanner({super.key, required this.isSearching});

  @override
  Widget build(BuildContext context) {
    if (isSearching) return const SizedBox();

    final listBanner = context.watch<BannerViewModel>().listBanners;

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
