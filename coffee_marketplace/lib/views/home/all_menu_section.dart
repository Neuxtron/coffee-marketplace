import 'package:coffee_marketplace/viewmodels/produk_view_model.dart';
import 'package:coffee_marketplace/views/widgets/produk_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:coffee_marketplace/models/produk_model.dart';

class AllMenuSection extends StatelessWidget {
  final String? searchText;
  const AllMenuSection({super.key, this.searchText});

  static late BuildContext _context;

  List<ProdukModel> get _listProduk {
    final allProduk = _context.watch<ProdukViewModel>().listProduk;
    if (searchText == null) return allProduk;

    return allProduk.where((produk) {
      final namaProduk = produk.nama.toLowerCase();
      return namaProduk.contains(searchText!);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    _context = context;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        _buildLabel(isSearching: searchText != null),
        ProdukGridView(
          listProduk: _listProduk,
        ),
      ],
    );
  }

  Widget _buildLabel({required bool isSearching}) {
    if (isSearching) return const SizedBox();
    return const Padding(
      padding: EdgeInsets.only(left: 20),
      child: Text(
        "All Menu",
        style: TextStyle(
          fontWeight: FontWeight.w800,
          fontFamily: "Abhaya Libre",
          fontSize: 16,
        ),
      ),
    );
  }
}
