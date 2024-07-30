import 'package:coffee_marketplace/models/keranjang_model.dart';
import 'package:coffee_marketplace/models/kurir_model.dart';
import 'package:coffee_marketplace/models/metode_bayar_model.dart';
import 'package:coffee_marketplace/models/order_model.dart';
import 'package:coffee_marketplace/models/pembayaran_model.dart';
import 'package:coffee_marketplace/utils/app_constants.dart';
import 'package:coffee_marketplace/viewmodels/daerah_view_model.dart';
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
  late String _kurir;
  late String _metodeBayar;
  late List<KeranjangModel> _listKeranjang;

  // TODO: kurir from toko
  List<KurirModel> get _listKurir => dummyKurir;
  // TODO: metode bayar from api
  List<MetodeBayarModel> get _listMetodeBayar => dummyMetodeBayar;

  int get _subtotal {
    int subtotal = 0;
    for (var keranjang in _listKeranjang) {
      subtotal += keranjang.produk.harga * keranjang.amount;
    }
    return subtotal;
  }

  bool get _loading {
    // TODO: loading pengiriman, metode bayar, ongkir, order
    return false;
  }

  void checkout() {
    final ongkir = context.read<DaerahViewModel>().ongkir;

    final pembayaran = PembayaranModel(
      subtotal: _subtotal,
      ongkir: ongkir,
      metodeBayar: _metodeBayar,
      listKeranjang: _listKeranjang,
    );

    // context.read<OrderViewModel>().createOrder(pembayaran).then(handleOrder);
    final order = dummyOrder;
    handleOrder(order);
  }

  void handleOrder(OrderModel? order) {
    // if (order == null) {
    //   Fluttertoast.showToast(
    //     msg: "Terjadi kesalahan",
    //     backgroundColor: Colors.black54,
    //   );
    //   return;
    // }
    Navigator.pushNamed(
      context,
      "/menunggu_pembayaran",
      arguments: order,
    ).then((_) => Navigator.pop(context));
  }

  void getOngkir() {
    int totalBerat = 0;
    for (var keranjang in _listKeranjang) {
      totalBerat += keranjang.produk.beratProduk;
    }

    final kecamatanPembeli =
        context.read<UserViewModel>().currentUser!.idKecamatan;
    // TODO: from api
    final kecamatanPenjual = "235"; // Lhokseumawe

    context
        .read<DaerahViewModel>()
        .getOngkir(totalBerat, _kurir, kecamatanPembeli, kecamatanPenjual);
  }

  void getData() {
    // TODO: get profile, get kecamatan toko, get kurir, get metode
    _kurir = _listKurir[0].id;
    _metodeBayar = _listMetodeBayar[0].id;
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      // TODO: loading builder
    }

    _listKeranjang =
        ModalRoute.of(context)!.settings.arguments as List<KeranjangModel>;

    getOngkir();

    return Scaffold(
      appBar: buildAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const AlamatSection(),
            KeranjangSection(listKeranjang: _listKeranjang),
            PengirimanSection(
              onChange: (idKurir) => _kurir = idKurir,
              listKurir: _listKurir,
            ),
            PembayaranSection(onChange: (idMetode) => _metodeBayar = idMetode),
            DetailsSection(
              subtotalProduk: _subtotal,
            ),
            PesanSection(
              checkout: checkout,
              subtotal: _subtotal,
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
