import 'package:coffee_marketplace/models/keranjang_model.dart';
import 'package:coffee_marketplace/models/kurir_model.dart';
import 'package:coffee_marketplace/models/metode_bayar_model.dart';
import 'package:coffee_marketplace/utils/app_constants.dart';
import 'package:coffee_marketplace/views/checkout/alamat_section.dart';
import 'package:coffee_marketplace/views/checkout/details_section.dart';
import 'package:coffee_marketplace/views/checkout/keranjang_section.dart';
import 'package:coffee_marketplace/views/checkout/pembayaran_section.dart';
import 'package:coffee_marketplace/views/checkout/pengiriman_section.dart';
import 'package:coffee_marketplace/views/checkout/pesan_section.dart';
import 'package:flutter/material.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({super.key});

  static late String _kurir;
  static late String _metodeBayar;
  static late List<KeranjangModel> _listKeranjang;

  int get _subtotal {
    int subtotal = 0;
    for (var keranjang in _listKeranjang) {
      subtotal += keranjang.produk.harga * keranjang.amount;
    }
    return subtotal;
  }

  int get _ongkir {
    // TODO: get ongkir
    return 0;
  }

  bool get _loading {
    // TODO: loading pengiriman, metode bayar, ongkir
    return false;
  }

  void checkout() {
    print(_kurir);
    print(_metodeBayar);
    // TODO halaman baru, tgl expire, va number, jumlah bayar
  }

  @override
  Widget build(BuildContext context) {
    _listKeranjang =
        ModalRoute.of(context)!.settings.arguments as List<KeranjangModel>;

    // TODO: kurir from toko
    final listKurir = dummyKurir;
    _kurir = listKurir[0].id;

    // TODO: metode bayar from api
    final listMetode = dummyMetodeBayar;
    _metodeBayar = listMetode[0].id;

    return Scaffold(
      appBar: buildAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const AlamatSection(),
            KeranjangSection(listKeranjang: _listKeranjang),
            PengirimanSection(
              onChange: (idKurir) => _kurir = idKurir,
              listKurir: listKurir,
            ),
            PembayaranSection(onChange: (idMetode) => _metodeBayar = idMetode),
            DetailsSection(
              subtotalProduk: _subtotal,
              ongkir: _ongkir,
            ),
            PesanSection(
              checkout: checkout,
              total: _subtotal + _ongkir,
            ),
          ],
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: AppConstants.background,
      title: const Text(
        "Checkout",
        style: TextStyle(
          fontFamily: "Abhaya Libre",
          fontWeight: FontWeight.w800,
          fontSize: 18,
        ),
      ),
      surfaceTintColor: Colors.transparent,
      titleSpacing: 0,
      centerTitle: true,
    );
  }
}
