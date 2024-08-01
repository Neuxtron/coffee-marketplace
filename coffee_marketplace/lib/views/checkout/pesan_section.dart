import 'package:coffee_marketplace/utils/app_constants.dart';
import 'package:coffee_marketplace/utils/app_helpers.dart';
import 'package:flutter/material.dart';

class PesanSection extends StatelessWidget {
  final Function() checkout;
  final int subtotal;
  final bool isSubmitting;
  final int ongkir;

  const PesanSection({
    super.key,
    required this.checkout,
    required this.subtotal,
    required this.isSubmitting,
    required this.ongkir,
  });

  @override
  Widget build(BuildContext context) {
    final total = subtotal + ongkir;

    final totalString = AppHelpers.formatHarga(total);

    return Container(
      color: AppConstants.secondary,
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Text(
                "Total\n$totalString",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          InkWell(
            onTap: isSubmitting ? null : checkout,
            child: Container(
              color: isSubmitting
                  ? AppConstants.primary.withOpacity(.7)
                  : AppConstants.primary,
              padding: const EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 25,
              ),
              child: const Text(
                "Pesan",
                style: TextStyle(
                  fontFamily: "Abhaya Libre",
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
