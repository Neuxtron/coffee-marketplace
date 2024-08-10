import 'package:coffee_marketplace/viewmodels/produk_view_model.dart';
import 'package:coffee_marketplace/viewmodels/user_view_model.dart';
import 'package:coffee_marketplace/views/_penjual/toko_saya/produk_item.dart';
import 'package:coffee_marketplace/views/_penjual/toko_saya/tambah_produk_section.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:coffee_marketplace/models/produk_model.dart';

class TokoSayaPage extends StatefulWidget {
  const TokoSayaPage({super.key});

  @override
  State<TokoSayaPage> createState() => _TokoSayaPageState();
}

class _TokoSayaPageState extends State<TokoSayaPage> {
  String get _idPenjual => context.read<UserViewModel>().currentUser!.id!;
  List<ProdukModel> get _produkSaya =>
      context.watch<ProdukViewModel>().produkByPenjual(_idPenjual);

  @override
  void initState() {
    super.initState();
    context.read<ProdukViewModel>().getProduk();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: buildAppBar(),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(20, 80, 0, 10),
                  child: Text(
                    "Produk Saya",
                    style: TextStyle(
                      color: Colors.black12,
                      fontWeight: FontWeight.w900,
                      fontSize: 32,
                    ),
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                  itemCount: _produkSaya.length,
                  itemBuilder: (context, index) {
                    final produk = _produkSaya[index];
                    return ProdukItem(produk: produk);
                  },
                ),
              ],
            ),
          ),
          const TambahProdukSection(),
        ],
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white.withOpacity(.01),
      automaticallyImplyLeading: false,
      surfaceTintColor: Colors.transparent,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: IconButton(
            onPressed: () => Navigator.pushNamed(context, "/pengaturan_toko"),
            icon: const Icon(
              Icons.settings_outlined,
              color: Colors.grey,
            ),
          ),
        )
      ],
    );
  }
}
