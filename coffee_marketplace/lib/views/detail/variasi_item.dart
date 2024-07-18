import 'package:coffee_marketplace/models/variasi_model.dart';
import 'package:coffee_marketplace/utils/app_constants.dart';
import 'package:flutter/material.dart';

class VariasiItem extends StatelessWidget {
  final VariasiModel variasi;
  final bool selected;
  final Function() onPressed;

  const VariasiItem({
    super.key,
    required this.variasi,
    required this.selected,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final opacity = selected ? 1.0 : .65;

    return InkWell(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          color: AppConstants.primary.withOpacity(opacity),
          borderRadius: BorderRadius.circular(999),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 15),
        margin: const EdgeInsets.symmetric(horizontal: 5),
        child: Center(
          child: Text(
            variasi.nama,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontFamily: "Abhaya Libre",
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ),
    );
  }
}
