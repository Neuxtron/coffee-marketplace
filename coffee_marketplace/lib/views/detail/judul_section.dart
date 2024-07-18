import 'package:coffee_marketplace/utils/app_helpers.dart';
import 'package:flutter/material.dart';

class JudulSection extends StatelessWidget {
  final String nama;
  final int harga;

  const JudulSection({
    super.key,
    required this.nama,
    required this.harga,
  });

  @override
  Widget build(BuildContext context) {
    final hargaString = AppHelpers.formatHarga(harga);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          nama,
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
