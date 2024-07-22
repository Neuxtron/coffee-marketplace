import 'package:coffee_marketplace/models/kategori_model.dart';
import 'package:coffee_marketplace/utils/app_constants.dart';
import 'package:coffee_marketplace/viewmodels/produk_view_model.dart';
import 'package:coffee_marketplace/views/widgets/produk_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class KategoriPage extends StatelessWidget {
  const KategoriPage({super.key});

  @override
  Widget build(BuildContext context) {
    final kategori =
        ModalRoute.of(context)!.settings.arguments as KategoriModel;

    // TODO: produk by kategori
    final listProduk = context.watch<ProdukViewModel>().listProduk;

    return Scaffold(
      appBar: buildAppBar(kategori),
      body: Column(
        children: [
          ProdukGridView(
            listProduk: listProduk,
            padding: const EdgeInsets.symmetric(vertical: 30),
          ),
        ],
      ),
    );
  }

  AppBar buildAppBar(KategoriModel kategori) {
    return AppBar(
      backgroundColor: AppConstants.background,
      titleSpacing: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.network(
            kategori.icon,
            width: 25,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 50),
            child: Text(
              kategori.nama,
              style: const TextStyle(
                fontFamily: "Abhaya Libre",
                fontWeight: FontWeight.w800,
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
