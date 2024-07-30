import 'package:coffee_marketplace/models/order_model.dart';
import 'package:coffee_marketplace/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'judul_section.dart';
import 'details_section.dart';

class MenungguPembayaranPage extends StatelessWidget {
  const MenungguPembayaranPage({super.key});

  @override
  Widget build(BuildContext context) {
    final order = ModalRoute.of(context)!.settings.arguments as OrderModel;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const JudulSection(),
              DetailsSection(order: order),
              MaterialButton(
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
