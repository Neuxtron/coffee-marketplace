import 'package:coffee_marketplace/utils/app_helpers.dart';
import 'package:flutter/material.dart';

class ItemJudul extends StatelessWidget {
  final String nama;
  final int harga;

  const ItemJudul({
    super.key,
    required this.nama,
    required this.harga,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              nama,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontFamily: "Abhaya Libre",
                fontWeight: FontWeight.w800,
                fontSize: 16,
              ),
            ),
            Text(
              AppHelpers.formatHarga(harga),
              style: const TextStyle(
                fontFamily: "Abhaya Libre",
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
