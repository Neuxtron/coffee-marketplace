import 'package:coffee_marketplace/models/keranjang_model.dart';
import 'package:coffee_marketplace/models/order_model.dart';
import 'package:coffee_marketplace/utils/app_constants.dart';
import 'package:coffee_marketplace/views/_penjual/detail_pesanan/kirim_section.dart';
import 'package:flutter/material.dart';
import './keranjang_section.dart';
import './details_section.dart';
import './judul_section.dart';

class DetailPesananPage extends StatelessWidget {
  const DetailPesananPage({super.key});

  static late List<KeranjangModel> _listKeranjang;

  int get _subtotal {
    int subtotal = 0;
    for (var keranjang in _listKeranjang) {
      subtotal += keranjang.produk.harga * keranjang.amount;
    }
    return subtotal;
  }

  @override
  Widget build(BuildContext context) {
    final order = ModalRoute.of(context)!.settings.arguments as OrderModel;
    _listKeranjang = order.keranjang;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstants.background,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            JudulSection(nama: order.pembeli!.nama),
            // IDEA: chat pembeli
            DetailsSection(
              subtotalProduk: _subtotal,
              ongkir: order.ongkir,
              status: order.status,
            ),
            KeranjangSection(
              listKeranjang: order.keranjang,
            ),
            order.status == "settlement"
                ? KirimSection(id: order.id)
                : const SizedBox(),
            // TODO: riwayat tracking
          ],
        ),
      ),
    );
  }
}
