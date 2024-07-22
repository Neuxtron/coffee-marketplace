import 'package:coffee_marketplace/models/produk_model.dart';
import 'package:coffee_marketplace/views/widgets/produk_item.dart';
import 'package:flutter/material.dart';

class BestSellerSection extends StatelessWidget {
  const BestSellerSection({super.key});

  @override
  Widget build(BuildContext context) {
    final List<ProdukModel> listBestSellerProduk = dummyBestSellerProduk;
    const shadowSize = 150.0;
    const verticalPadding = 10.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        const Padding(
          padding: EdgeInsets.only(left: 20),
          child: Text(
            "Best Seller",
            style: TextStyle(
              fontWeight: FontWeight.w800,
              fontFamily: "Abhaya Libre",
              fontSize: 16,
            ),
          ),
        ),
        SizedBox(
          height: shadowSize + (verticalPadding * 2) + 40,
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(
              vertical: verticalPadding,
              horizontal: 10,
            ),
            scrollDirection: Axis.horizontal,
            itemCount: listBestSellerProduk.length,
            itemBuilder: (context, index) {
              final produk = listBestSellerProduk[index];
              return ProdukItem(
                shadowSize: shadowSize,
                produk: produk,
              );
            },
          ),
        )
      ],
    );
  }
}
