import 'package:coffee_marketplace/utils/app_constants.dart';
import 'package:coffee_marketplace/viewmodels/daerah_view_model.dart';
import 'package:coffee_marketplace/viewmodels/kategori_view_model.dart';
import 'package:coffee_marketplace/viewmodels/keranjang_view_model.dart';
import 'package:coffee_marketplace/viewmodels/metode_bayar_view_model.dart';
import 'package:coffee_marketplace/viewmodels/order_view_model.dart';
import 'package:coffee_marketplace/viewmodels/pakar_view_model.dart';
import 'package:coffee_marketplace/viewmodels/pesan_view_model.dart';
import 'package:coffee_marketplace/viewmodels/produk_view_model.dart';
import 'package:coffee_marketplace/viewmodels/user_view_model.dart';
import 'package:coffee_marketplace/views/_penjual/edit_produk/edit_produk_page.dart';
import 'package:coffee_marketplace/views/all_pakar/all_pakar_page.dart';
import 'package:coffee_marketplace/views/chat_room/chat_room_page.dart';
import 'package:coffee_marketplace/views/checkout/checkout_page.dart';
import 'package:coffee_marketplace/views/daftar/daftar_page.dart';
import 'package:coffee_marketplace/views/detail/details_page.dart';
import 'package:coffee_marketplace/views/kategori/kategori_page.dart';
import 'package:coffee_marketplace/views/layouts/main_layout.dart';
import 'package:coffee_marketplace/views/login/login_page.dart';
import 'package:coffee_marketplace/views/menunggu_pembayaran/menunggu_pembayaran_page.dart';
import 'package:coffee_marketplace/views/pembayaran/pembayaran_page.dart';
import 'package:coffee_marketplace/views/pengaturan_toko/pengaturan_toko_page.dart';
import 'package:coffee_marketplace/views/pengiriman/pengiriman_page.dart';
import 'package:coffee_marketplace/views/pesan/pesan_page.dart';
import 'package:coffee_marketplace/views/_penjual/tambah_produk/tambah_produk_page.dart';
import 'package:coffee_marketplace/views/toko_saya/toko_saya_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProdukViewModel()),
        ChangeNotifierProvider(create: (context) => KategoriViewModel()),
        ChangeNotifierProvider(create: (context) => KeranjangViewModel()),
        ChangeNotifierProvider(create: (context) => DaerahViewModel()),
        ChangeNotifierProvider(create: (context) => UserViewModel()),
        ChangeNotifierProvider(create: (context) => MetodeBayarViewModel()),
        ChangeNotifierProvider(create: (context) => OrderViewModel()),
        ChangeNotifierProvider(create: (context) => PakarViewModel()),
        ChangeNotifierProvider(create: (context) => PesanViewModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Coffee Marketplace",
        theme: ThemeData(
          fontFamily: "Lato",
          scaffoldBackgroundColor: AppConstants.background,
          colorScheme: ColorScheme.fromSeed(
            seedColor: AppConstants.primary,
          ),
        ),
        initialRoute: "/",
        routes: {
          "/": (context) => const MainLayout(),
          "/details": (context) => const DetailsPage(),
          "/kategori": (context) => const KategoriPage(),
          "/login": (context) => const LoginPage(),
          "/daftar": (context) => const DaftarPage(),
          "/checkout": (context) => const CheckoutPage(),
          "/pengiriman": (context) => const PengirimanPage(),
          "/pembayaran": (context) => const PembayaranPage(),
          "/menunggu_pembayaran": (context) => const MenungguPembayaranPage(),
          "/pesan": (context) => const PesanPage(),
          "/all_pakar": (context) => const AllPakarPage(),
          "/chatroom": (context) => const ChatRoomPage(),
          "/toko_saya": (context) => const TokoSayaPage(),
          "/pengaturan_toko": (context) => const PengaturanTokoPage(),
          "/tambah_produk": (context) => const TambahProdukPage(),
          "/edit_produk": (context) => const EditProdukPage(),
        },
      ),
    );
  }
}
