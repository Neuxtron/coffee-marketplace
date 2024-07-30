import 'package:coffee_marketplace/models/order_model.dart';
import 'package:coffee_marketplace/views/menunggu_pembayaran/kembali_button.dart';
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
              const KembaliButton(),
            ],
          ),
        ),
      ),
    );
  }
}
