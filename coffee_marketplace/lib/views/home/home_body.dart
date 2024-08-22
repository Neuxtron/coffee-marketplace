import 'package:coffee_marketplace/utils/server_status.dart';
import 'package:coffee_marketplace/viewmodels/kategori_view_model.dart';
import 'package:coffee_marketplace/viewmodels/produk_view_model.dart';
import 'package:coffee_marketplace/views/home/all_menu_section.dart';
import 'package:coffee_marketplace/views/home/kategori_section.dart';
import 'package:coffee_marketplace/views/widgets/info_builder.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeBody extends StatelessWidget {
  final Future Function() getData;
  final String searchText;

  const HomeBody({
    super.key,
    required this.getData,
    required this.searchText,
  });

  static late BuildContext _context;

  bool get _isError {
    List<ServerStatus> listStatus = [];
    listStatus.addAll([
      _context.watch<ProdukViewModel>().status,
      _context.watch<KategoriViewModel>().status,
    ]);

    return listStatus.contains(ServerStatus.error);
  }

  bool get _isLoading {
    List<ServerStatus> listStatus = [];
    listStatus.addAll([
      _context.watch<ProdukViewModel>().status,
      _context.watch<KategoriViewModel>().status,
    ]);

    return listStatus.contains(ServerStatus.loading);
  }

  @override
  Widget build(BuildContext context) {
    _context = context;

    if (_isError) {
      return Align(
        alignment: Alignment.topCenter,
        child: InfoBuilder(
          onPressed: getData,
          iconData: Icons.error_outline,
        ),
      );
    }

    if (_isLoading) {
      return const Padding(
        padding: EdgeInsets.only(top: 40),
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (searchText.isNotEmpty) {
      return AllMenuSection(searchText: searchText);
    }

    return const Column(
      children: [
        KategoriSection(),
        // BestSellerSection(),
        AllMenuSection(),
      ],
    );
  }
}
