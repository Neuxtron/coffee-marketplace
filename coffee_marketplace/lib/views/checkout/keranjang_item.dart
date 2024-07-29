import 'package:coffee_marketplace/models/keranjang_model.dart';
import 'package:coffee_marketplace/utils/app_helpers.dart';
import 'package:coffee_marketplace/views/widgets/rounded_image.dart';
import 'package:flutter/material.dart';

class KeranjangItem extends StatelessWidget {
  final KeranjangModel keranjang;
  const KeranjangItem({super.key, required this.keranjang});

  @override
  Widget build(BuildContext context) {
    final produk = keranjang.produk;
    final hargaString = AppHelpers.formatHarga(produk.harga);

    return Stack(
      children: [
        Row(
          children: [
            RoundedImage(
              imageUrl: produk.thumbnail,
              height: 75,
              width: 75,
              radius: 10,
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    produk.nama,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontFamily: "Abhaya Libre",
                      fontWeight: FontWeight.w800,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    hargaString,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontFamily: "Abhaya Libre",
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Positioned(
          top: 0,
          right: 0,
          child: Text(
            "x${keranjang.amount}",
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }
}
