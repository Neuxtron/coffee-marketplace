import 'package:coffee_marketplace/models/produk_model.dart';
import 'package:coffee_marketplace/utils/app_constants.dart';
import 'package:coffee_marketplace/views/detail/actions_section.dart';
import 'package:coffee_marketplace/views/detail/deskripsi_section.dart';
import 'package:coffee_marketplace/views/detail/gambar_section.dart';
import 'package:coffee_marketplace/views/detail/judul_section.dart';
import 'package:coffee_marketplace/views/detail/variasi_section.dart';
import 'package:flutter/material.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({super.key});

  static late ProdukModel produk;
  static String? selectedVariasi;

  void addToCart(int amount) {
    print("Variasi id: $selectedVariasi");
    print("amount: $amount");
    print("Produk id: ${produk.id}");
  }

  @override
  Widget build(BuildContext context) {
    produk = ModalRoute.of(context)!.settings.arguments as ProdukModel;

    return Scaffold(
      appBar: buildAppBar(),
      bottomNavigationBar: Container(
        color: AppConstants.secondaryAlt,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: ActionsSection(addToCart: addToCart),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                children: [
                  JudulSection(nama: produk.nama, harga: produk.harga),
                  GambarSection(gambar: produk.gambar[0]),
                  DeskripsiSection(deskripsi: produk.deskripsi),
                ],
              ),
            ),
            VariasiSection(
              listVariasi: produk.variasi,
              selectVariasi: (variasiId) => selectedVariasi = variasiId,
            ),
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
      backgroundColor: Colors.white.withOpacity(.01),
      surfaceTintColor: Colors.transparent,
      titleSpacing: 0,
    );
  }
}
