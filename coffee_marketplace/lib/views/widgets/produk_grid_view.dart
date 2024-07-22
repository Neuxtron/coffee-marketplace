import 'package:flutter/material.dart';
import 'package:coffee_marketplace/models/produk_model.dart';
import 'package:coffee_marketplace/views/widgets/produk_item.dart';

class ProdukGridView extends StatelessWidget {
  final List<ProdukModel> listProduk;
  final EdgeInsets padding;

  const ProdukGridView({
    super.key,
    required this.listProduk,
    this.padding = const EdgeInsets.symmetric(vertical: 10),
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 4,
      ),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: padding,
      itemCount: listProduk.length,
      itemBuilder: (context, index) {
        final produk = listProduk[index];
        return ProdukItem(
          shadowSize: 150.0,
          produk: produk,
        );
      },
    );
  }
}
