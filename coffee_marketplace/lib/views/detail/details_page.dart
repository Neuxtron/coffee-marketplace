import 'package:coffee_marketplace/models/keranjang_model.dart';
import 'package:coffee_marketplace/models/produk_model.dart';
import 'package:coffee_marketplace/models/variasi_model.dart';
import 'package:coffee_marketplace/utils/app_constants.dart';
import 'package:coffee_marketplace/viewmodels/keranjang_view_model.dart';
import 'package:coffee_marketplace/viewmodels/user_view_model.dart';
import 'package:coffee_marketplace/views/detail/actions_section.dart';
import 'package:coffee_marketplace/views/detail/deskripsi_section.dart';
import 'package:coffee_marketplace/views/detail/gambar_section.dart';
import 'package:coffee_marketplace/views/detail/judul_section.dart';
import 'package:coffee_marketplace/views/detail/variasi_section.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({super.key});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  final _scrollController = ScrollController();
  bool get _isLoggedIn => context.watch<UserViewModel>().currentUser != null;

  late ProdukModel _produk;
  VariasiModel? _selectedVariasi;
  String _error = "";

  void addToCart(int amount) {
    setState(() => _error = "");
    if (_selectedVariasi == null) {
      setState(() => _error = "Silahkan pilih variasi");
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      return;
    }

    final keranjang = KeranjangModel(
      produk: _produk,
      variasi: _selectedVariasi!,
      amount: amount,
    );
    context
        .read<KeranjangViewModel>()
        .updateKeranjang(keranjang: keranjang)
        .then((success) {
      String msg = "Berhasil dimasukkan ke keranjang";
      if (!success) msg = "Gagal memasukkan ke keranjang";
      Fluttertoast.showToast(
        msg: msg,
        backgroundColor: Colors.black54,
      );
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    _produk = ModalRoute.of(context)!.settings.arguments as ProdukModel;

    // TODO: penjual
    return Scaffold(
      appBar: buildAppBar(),
      bottomNavigationBar: _isLoggedIn
          ? Container(
              color: AppConstants.secondaryAlt,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: ActionsSection(addToCart: addToCart),
            )
          : null,
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  JudulSection(nama: _produk.nama, harga: _produk.harga),
                  GambarSection(gambar: _produk.gambar[0]),
                  DeskripsiSection(deskripsi: _produk.deskripsi),
                ],
              ),
            ),
            _isLoggedIn
                ? VariasiSection(
                    listVariasi: _produk.variasi,
                    selectVariasi: (variasi) => _selectedVariasi = variasi,
                    error: _error,
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      centerTitle: true,
      title: const Text(
        "Detail",
        style: TextStyle(
          fontFamily: "Abhaya Libre",
          fontWeight: FontWeight.w800,
          fontSize: 18,
        ),
      ),
      backgroundColor: Colors.white.withOpacity(.01),
      surfaceTintColor: Colors.transparent,
      titleSpacing: 0,
    );
  }
}
