import 'package:flutter/material.dart';

class HapusSection extends StatelessWidget {
  final String idProduk;
  const HapusSection({super.key, required this.idProduk});

  void hapusProduk() {}

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50, bottom: 10),
      child: Column(
        children: [
          const Divider(
            color: Colors.black12,
            indent: 30,
            endIndent: 30,
          ),
          Center(
            child: TextButton(
              onPressed: () {},
              style: ButtonStyle(
                padding: const WidgetStatePropertyAll(
                  EdgeInsets.symmetric(horizontal: 50),
                ),
                overlayColor:
                    WidgetStatePropertyAll(Colors.red.withOpacity(.1)),
              ),
              child: const Text(
                "Hapus produk",
                style: TextStyle(color: Colors.red),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
