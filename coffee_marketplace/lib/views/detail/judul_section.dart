import 'package:coffee_marketplace/models/produk_model.dart';
import 'package:coffee_marketplace/utils/app_helpers.dart';
import 'package:flutter/material.dart';

class JudulSection extends StatelessWidget {
  final ProdukModel produk;
  const JudulSection({super.key, required this.produk});

  @override
  Widget build(BuildContext context) {
    final hargaString = AppHelpers.formatHarga(produk.harga);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          produk.nama,
          style: const TextStyle(
            fontWeight: FontWeight.w800,
            fontFamily: "Abhaya Libre",
            fontSize: 16,
          ),
        ),
        Text(
          hargaString,
          style: const TextStyle(
            fontWeight: FontWeight.w800,
            fontFamily: "Abhaya Libre",
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
