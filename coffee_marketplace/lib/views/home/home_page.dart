import 'package:coffee_marketplace/utils/app_constants.dart';
import 'package:coffee_marketplace/viewmodels/produk_view_model.dart';
import 'package:coffee_marketplace/views/home/all_menu_section.dart';
import 'package:coffee_marketplace/views/home/best_seller_section.dart';
import 'package:coffee_marketplace/views/home/kategori_section.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // TODO: loading

  void getData() {
    context.read<ProdukViewModel>().getProduk();
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

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
