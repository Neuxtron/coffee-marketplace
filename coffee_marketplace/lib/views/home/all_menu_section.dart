import 'package:coffee_marketplace/viewmodels/produk_view_model.dart';
import 'package:coffee_marketplace/views/widgets/produk_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AllMenuSection extends StatelessWidget {
  const AllMenuSection({super.key});

  @override
  Widget build(BuildContext context) {
    final listProduk = context.watch<ProdukViewModel>().listProduk;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        // const Padding(
        //   padding: EdgeInsets.only(left: 20),
        //   child: Text(
        //     "All Menu",
        //     style: TextStyle(
        //       fontWeight: FontWeight.w800,
        //       fontFamily: "Abhaya Libre",
        //       fontSize: 16,
        //     ),
        //   ),
        // ),
        ProdukGridView(
          listProduk: listProduk,
        ),
      ],
    );
  }
}
