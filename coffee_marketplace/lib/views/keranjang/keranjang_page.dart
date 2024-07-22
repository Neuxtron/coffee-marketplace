import 'package:coffee_marketplace/viewmodels/keranjang_view_model.dart';
import 'package:coffee_marketplace/views/keranjang/keranjang_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class KeranjangPage extends StatelessWidget {
  const KeranjangPage({super.key});

  @override
  Widget build(BuildContext context) {
    final listKeranjang = context.watch<KeranjangViewModel>().listKeranjang;

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      itemCount: listKeranjang.length,
      itemBuilder: (context, index) {
        final keranjang = listKeranjang[index];
        return KeranjangItem(
          keranjang: keranjang,
        );
      },
    );
  }
}
