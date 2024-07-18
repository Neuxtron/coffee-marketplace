import 'package:coffee_marketplace/utils/app_constants.dart';
import 'package:coffee_marketplace/views/home/all_menu_section.dart';
import 'package:coffee_marketplace/views/home/best_seller_section.dart';
import 'package:coffee_marketplace/views/home/kategori_section.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 200,
            color: AppConstants.primary,
          ),
          const KategoriSection(),
          const BestSellerSection(),
          const AllMenuSection(),
        ],
      ),
    );
  }
}
