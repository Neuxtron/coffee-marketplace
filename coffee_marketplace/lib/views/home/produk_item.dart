import 'package:coffee_marketplace/models/produk_model.dart';
import 'package:coffee_marketplace/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProdukItem extends StatelessWidget {
  final double shadowSize;
  final ProdukModel produk;

  const ProdukItem({
    super.key,
    required this.shadowSize,
    required this.produk,
  });

  @override
  Widget build(BuildContext context) {
    final hargaString = NumberFormat("Rp###,###,###").format(produk.harga);

    return Stack(
      children: [
        Container(
          height: shadowSize,
          width: shadowSize,
          margin: const EdgeInsets.fromLTRB(5, 25, 5, 0),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppConstants.secondary,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(produk.nama),
              Text(
                hargaString,
                style: const TextStyle(fontSize: 12),
              ),
            ],
          ),
        ),
        SizedBox(
          width: shadowSize + 10,
          child: Align(
            alignment: Alignment.topCenter,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              clipBehavior: Clip.hardEdge,
              child: Image.network(
                produk.gambar[0],
                height: 100,
                width: 100,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
