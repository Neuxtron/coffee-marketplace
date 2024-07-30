import 'package:coffee_marketplace/utils/app_constants.dart';
import 'package:flutter/material.dart';

class JudulSection extends StatelessWidget {
  const JudulSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 80, bottom: 10),
          child: Text(
            "Menunggu pembayaran...",
            style: TextStyle(
              fontFamily: "Abhaya Libre",
              fontSize: 18,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        Icon(
          Icons.history,
          size: 40,
          color: AppConstants.primary,
        ),
      ],
    );
  }
}
