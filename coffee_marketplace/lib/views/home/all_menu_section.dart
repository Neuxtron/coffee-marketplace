import 'package:coffee_marketplace/models/produk_model.dart';
import 'package:coffee_marketplace/views/home/produk_item.dart';
import 'package:flutter/material.dart';

class AllMenuSection extends StatelessWidget {
  const AllMenuSection({super.key});

  @override
  Widget build(BuildContext context) {
    const shadowSize = 150.0;
    final listProduk = dummyListProduk;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        const Padding(
          padding: EdgeInsets.only(left: 20),
          child: Text(
            "All Menu",
            style: TextStyle(
              fontWeight: FontWeight.w800,
              fontFamily: "Abhaya Libre",
              fontSize: 16,
            ),
          ),
        ),
        GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 4,
          ),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(vertical: 10),
          itemCount: listProduk.length,
          itemBuilder: (context, index) {
            final produk = listProduk[index];
            return ProdukItem(
              shadowSize: shadowSize,
              produk: produk,
            );
          },
        ),
      ],
    );
  }
}
