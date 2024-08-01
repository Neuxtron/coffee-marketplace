import 'package:coffee_marketplace/models/keranjang_model.dart';
import 'package:coffee_marketplace/models/kurir_model.dart';
import 'package:coffee_marketplace/models/metode_bayar_model.dart';
import 'package:coffee_marketplace/models/ongkir_model.dart';
import 'package:coffee_marketplace/models/order_model.dart';
import 'package:coffee_marketplace/models/pembayaran_model.dart';
import 'package:coffee_marketplace/utils/app_constants.dart';
import 'package:coffee_marketplace/utils/server_status.dart';
import 'package:coffee_marketplace/viewmodels/daerah_view_model.dart';
import 'package:coffee_marketplace/viewmodels/keranjang_view_model.dart';
import 'package:coffee_marketplace/viewmodels/metode_bayar_view_model.dart';
import 'package:coffee_marketplace/viewmodels/order_view_model.dart';
import 'package:coffee_marketplace/viewmodels/user_view_model.dart';
import 'package:coffee_marketplace/views/checkout/alamat_section.dart';
import 'package:coffee_marketplace/views/checkout/details_section.dart';
import 'package:coffee_marketplace/views/checkout/keranjang_section.dart';
import 'package:coffee_marketplace/views/checkout/pembayaran_section.dart';
import 'package:coffee_marketplace/views/checkout/pengiriman_section.dart';
import 'package:coffee_marketplace/views/checkout/pesan_section.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  late String _metodeBayar;
  late OngkirModel _ongkir;

  List<MetodeBayarModel> get _listMetodeBayar =>
      context.read<MetodeBayarViewModel>().listMetode;
  List<KeranjangModel> get _listCheckout =>
      context.read<KeranjangViewModel>().listCheckout;

  int get _subtotal {
    int subtotal = 0;
    for (var keranjang in _listCheckout) {
      subtotal += keranjang.produk.harga * keranjang.amount;
    }
    return subtotal;
  }

  bool get _isLoading {
    List<ServerStatus> listStatus = [];
    listStatus.addAll([
      context.watch<MetodeBayarViewModel>().status,
      context.watch<DaerahViewModel>().ongkirStatus,
      context.watch<UserViewModel>().status,
    ]);

    return listStatus.contains(ServerStatus.loading);
  }

  bool get _isSubmitting =>
      context.watch<OrderViewModel>().status == ServerStatus.loading;

  void checkout() {
    final pembayaran = PembayaranModel(
      subtotal: _subtotal,
      ongkir: _ongkir.ongkir,
      metodeBayar: _metodeBayar,
      listKeranjang: _listCheckout,
    );

    context.read<OrderViewModel>().createOrder(pembayaran).then(handleOrder);
  }

  void handleOrder(OrderModel? order) {
    if (order == null) {
      Fluttertoast.showToast(
        msg: "Terjadi kesalahan",
        backgroundColor: Colors.black54,
      );
      return;
    }
    Navigator.pushNamed(
      context,
      "/menunggu_pembayaran",
      arguments: order,
    ).then((_) => Navigator.pop(context));
  }

  void getOngkir() {
    int totalBerat = 0;
    for (var keranjang in _listCheckout) {
      totalBerat += keranjang.produk.beratProduk;
    }

    final kecamatanPembeli =
        context.read<UserViewModel>().currentUser!.idKecamatan;
    // TODO: kecamatan semua toko
    final kecamatanPenjual = _listCheckout[0].produk.penjual.idKecamatanToko;
    // TODO: kurir from toko
    final listKurir = dummyKurir;

    context
        .read<DaerahViewModel>()
        .getAllOngkir(
          totalBerat,
          kecamatanPembeli,
          kecamatanPenjual,
          listKurir,
        )
        .then((response) {
      if (response) {
        _ongkir = context.read<DaerahViewModel>().listKurir[0].listOngkir![0];
        return;
      }
      Fluttertoast.showToast(
        msg: "Terjadi kesalahan",
        backgroundColor: Colors.black54,
      );
      Navigator.pop(context);
    });
  }

  void getData() {
    // TODO: get kecamatan semua toko
    Future.wait([
      context.read<UserViewModel>().getProfile(),
      context.read<MetodeBayarViewModel>().getMetodeBayar(),
    ]).then((responses) {
      if (!responses.contains(false)) {
        _metodeBayar = _listMetodeBayar[0].id;
        getOngkir();
        return;
      }
      Fluttertoast.showToast(
        msg: "Terjadi kesalahan",
        backgroundColor: Colors.black54,
      );
      Navigator.pop(context);
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        appBar: buildAppBar(),
        body: const Padding(
          padding: EdgeInsets.only(top: 30),
          child: Align(
            alignment: Alignment.topCenter,
            child: SizedBox(
              height: 30,
              width: 30,
              child: CircularProgressIndicator(),
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: buildAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const AlamatSection(),
            KeranjangSection(listKeranjang: _listCheckout),
            PengirimanSection(
              onChange: (ongkir) => setState(() => _ongkir = ongkir),
            ),
            PembayaranSection(onChange: (idMetode) => _metodeBayar = idMetode),
            DetailsSection(
              subtotalProduk: _subtotal,
              ongkir: _ongkir.ongkir,
            ),
            PesanSection(
              checkout: checkout,
              subtotal: _subtotal,
              isSubmitting: _isSubmitting,
              ongkir: _ongkir.ongkir,
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
