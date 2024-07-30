import 'package:coffee_marketplace/utils/app_constants.dart';
import 'package:flutter/material.dart';

class KembaliButton extends StatelessWidget {
  const KembaliButton({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () => Navigator.pop(context),
      minWidth: double.infinity,
      color: AppConstants.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(999),
      ),
      child: const Text(
        "Kembali",
        style: TextStyle(
          color: Colors.white,
          fontFamily: "Abhaya Libre",
          fontWeight: FontWeight.w800,
          fontSize: 17,
        ),
      ),
    );
  }
}
