import 'package:coffee_marketplace/models/keranjang_model.dart';
import 'package:coffee_marketplace/utils/app_constants.dart';
import 'package:coffee_marketplace/views/keranjang/item_actions.dart';
import 'package:coffee_marketplace/views/keranjang/item_checkbox.dart';
import 'package:coffee_marketplace/views/keranjang/item_gambar.dart';
import 'package:coffee_marketplace/views/keranjang/item_hapus.dart';
import 'package:coffee_marketplace/views/keranjang/item_judul.dart';
import 'package:flutter/material.dart';

class KeranjangItem extends StatelessWidget {
  final KeranjangModel keranjang;
  const KeranjangItem({super.key, required this.keranjang});

  @override
  Widget build(BuildContext context) {
    final produk = keranjang.produk;

    return Row(
      children: [
        ItemCheckbox(id: keranjang.id!),
        Expanded(
          child: InkWell(
            onTap: () =>
                Navigator.pushNamed(context, "/details", arguments: produk),
            child: Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.symmetric(vertical: 5),
              decoration: BoxDecoration(
                color: AppConstants.secondary,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  ItemGambar(thumbnail: produk.thumbnail),
                  Expanded(
                    child: Column(
                      children: [
                        ItemJudul(
                          nama: produk.nama,
                          harga: produk.harga,
                        ),
                        ItemActions(
                          amount: keranjang.amount,
                          id: keranjang.id!,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        ItemHapus(id: keranjang.id!),
      ],
    );
  }
}
