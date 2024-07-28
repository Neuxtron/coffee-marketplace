import 'package:coffee_marketplace/viewmodels/keranjang_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ItemHapus extends StatelessWidget {
  final String id;
  const ItemHapus({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: MaterialButton(
        onPressed: () {
          context.read<KeranjangViewModel>().hapusKeranang(id);
        },
        color: Colors.red.shade400,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(999),
        ),
        padding: const EdgeInsets.all(10),
        minWidth: 0,
        child: const Icon(
          Icons.delete_outline,
          color: Colors.white,
          size: 20,
        ),
      ),
    );
  }
}
