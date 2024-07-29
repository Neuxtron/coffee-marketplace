import 'package:flutter/material.dart';
import 'package:coffee_marketplace/models/keranjang_model.dart';
import 'keranjang_item.dart';

class KeranjangSection extends StatelessWidget {
  final List<KeranjangModel> listKeranjang;
  const KeranjangSection({super.key, required this.listKeranjang});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.builder(
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: listKeranjang.length,
          itemBuilder: (context, index) {
            final keranjang = listKeranjang[index];
            return KeranjangItem(keranjang: keranjang);
          },
        ),
        const Divider(
          height: 1,
          thickness: 1,
          color: Colors.black26,
        ),
      ],
    );
  }
}
