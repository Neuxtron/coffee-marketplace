import 'package:coffee_marketplace/utils/server_status.dart';
import 'package:coffee_marketplace/viewmodels/kategori_view_model.dart';
import 'package:coffee_marketplace/viewmodels/produk_view_model.dart';
import 'package:coffee_marketplace/views/home/all_menu_section.dart';
import 'package:coffee_marketplace/views/home/best_seller_section.dart';
import 'package:coffee_marketplace/views/home/kategori_section.dart';
import 'package:coffee_marketplace/views/widgets/server_error_builder.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({super.key});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  bool _loading = true;

  bool get isError {
    List<ServerStatus> listStatus = [];
    listStatus.addAll([
      context.read<ProdukViewModel>().status,
      context.read<KategoriViewModel>().status,
    ]);

    return listStatus.contains(ServerStatus.error);
  }

  void getData() async {
    await Future.wait([
      context.read<ProdukViewModel>().getProduk(),
      context.read<KategoriViewModel>().getKategori(),
    ]);
    setState(() => _loading = false);
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    if (isError) {
      return Align(
        alignment: Alignment.topCenter,
        child: ServerErrorBuilder(onRetry: getData),
      );
    }

    if (_loading) {
      return loadingBuilder();
    }

    return const Column(
      children: [
        KategoriSection(),
        BestSellerSection(),
        AllMenuSection(),
      ],
    );
  }

  Padding loadingBuilder() {
    return const Padding(
      padding: EdgeInsets.only(top: 40),
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
