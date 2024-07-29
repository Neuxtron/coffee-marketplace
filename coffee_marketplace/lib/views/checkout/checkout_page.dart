import 'package:coffee_marketplace/models/keranjang_model.dart';
import 'package:coffee_marketplace/models/kurir_model.dart';
import 'package:coffee_marketplace/utils/app_constants.dart';
import 'package:coffee_marketplace/views/checkout/alamat_section.dart';
import 'package:coffee_marketplace/views/checkout/keranjang_section.dart';
import 'package:coffee_marketplace/views/checkout/pengiriman_section.dart';
import 'package:flutter/material.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({super.key});

  static late String _kurir;
  static late String _metodeBayar;

  @override
  Widget build(BuildContext context) {
    final listKeranjang =
        ModalRoute.of(context)!.settings.arguments as List<KeranjangModel>;

    // TODO: kurir from toko
    final listKurir = dummyKurir;
    _kurir = listKurir[0].id;

    return Scaffold(
      appBar: buildAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const AlamatSection(),
            KeranjangSection(listKeranjang: listKeranjang),
            PengirimanSection(
              onChange: (idKurir) => _kurir = idKurir,
              listKurir: listKurir,
            ),
          ],
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: AppConstants.background,
      title: const Text(
        "Checkout",
        style: TextStyle(
          fontFamily: "Abhaya Libre",
          fontWeight: FontWeight.w800,
          fontSize: 18,
        ),
      ),
      surfaceTintColor: Colors.transparent,
      titleSpacing: 0,
      centerTitle: true,
    );
  }
}
