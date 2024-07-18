import 'package:coffee_marketplace/models/produk_model.dart';
import 'package:coffee_marketplace/views/detail/gambar_section.dart';
import 'package:coffee_marketplace/views/detail/judul_section.dart';
import 'package:flutter/material.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final produk = ModalRoute.of(context)!.settings.arguments as ProdukModel;

    return Scaffold(
      appBar: buildAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: [
            const SizedBox(height: 30),
            JudulSection(produk: produk),
            GambarSection(produk: produk),
          ],
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: const Text(
        "Detail",
        style: TextStyle(
          fontFamily: "Abhaya Libre",
          fontWeight: FontWeight.w800,
          fontSize: 18,
        ),
      ),
      backgroundColor: Colors.white10,
      titleSpacing: 0,
    );
  }
}
