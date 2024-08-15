import 'package:coffee_marketplace/utils/app_constants.dart';
import 'package:coffee_marketplace/utils/server_status.dart';
import 'package:coffee_marketplace/viewmodels/order_view_model.dart';
import 'package:coffee_marketplace/viewmodels/user_view_model.dart';
import 'package:coffee_marketplace/views/riwayat/riwayat_list_view.dart';
import 'package:coffee_marketplace/views/widgets/info_builder.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RiwayatPage extends StatefulWidget {
  const RiwayatPage({super.key});

  @override
  State<RiwayatPage> createState() => _RiwayatPageState();
}

class _RiwayatPageState extends State<RiwayatPage> {
  ServerStatus get _status => context.watch<OrderViewModel>().status;
  OrderViewModel get _viewModelWatch => context.watch<OrderViewModel>();

  void login() {
    Navigator.pushNamed(context, "/login").then((_) => setState(() {}));
  }

  void getData() {
    context.read<OrderViewModel>().getRiwayat();
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    final user = context.read<UserViewModel>().currentUser;
    final initialIndex =
        ModalRoute.of(context)!.settings.arguments as int? ?? 0;

    if (user == null) {
      return Scaffold(
        appBar: buildAppBar(),
        body: Center(
          child: InfoBuilder(
            onPressed: login,
            iconData: Icons.person,
            text: "Anda belum login, silahkan login\nterlebih dahulu",
            buttonText: "Login",
            margin: const EdgeInsets.only(bottom: 50),
          ),
        ),
      );
    }

    if (_status == ServerStatus.loading) {
      return Scaffold(
        appBar: buildAppBar(),
        body: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (_status == ServerStatus.error) {
      return Center(
        child: InfoBuilder(
          onPressed: getData,
          iconData: Icons.error_outline,
        ),
      );
    }

    return DefaultTabController(
      length: 4,
      initialIndex: initialIndex,
      child: Scaffold(
        appBar: buildAppBar(showTabs: true),
        body: TabBarView(
          children: [
            RiwayatListView(
              listRiwayat: _viewModelWatch.listPending,
              buttonText: (_) => "Bayar",
              title: (order) => order.expiredAt.toString(),
              subtitle: "Batas waktu pembayaran",
              // TODO: halaman menunggu pembayaran
              buttonOnPressed: () {},
            ),
            RiwayatListView(
              listRiwayat: _viewModelWatch.listPending,
              buttonText: (_) => "Hubungi Penjual",
              title: (_) => "Pesanan sedang dikemas",
              // TODO: halaman menunggu pembayaran
              buttonOnPressed: () {},
            ),
            Center(child: Text("Dikirim view")),
            Center(child: Text("Riwayat view")),
          ],
        ),
      ),
    );
  }

  AppBar buildAppBar({showTabs = false}) {
    return AppBar(
      backgroundColor: AppConstants.background,
      surfaceTintColor: AppConstants.background,
      elevation: 0,
      title: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.list_alt, size: 25),
          Padding(
            padding: EdgeInsets.only(right: 56, left: 10),
            child: Text(
              "Pembelian Saya",
              style: TextStyle(
                fontFamily: "Abhaya Libre",
                fontWeight: FontWeight.w800,
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
      bottom: showTabs
          ? const TabBar(
              labelColor: AppConstants.primary,
              unselectedLabelColor: Colors.black45,
              labelStyle: TextStyle(
                fontWeight: FontWeight.w800,
                fontFamily: "Abhaya Libre",
              ),
              unselectedLabelStyle: TextStyle(
                fontFamily: "Abhaya Libre",
                fontWeight: FontWeight.w600,
              ),
              indicatorColor: AppConstants.primary,
              overlayColor: WidgetStatePropertyAll(Colors.white24),
              tabs: [
                Tab(child: Text("Pending")),
                Tab(child: Text("Dikemas")),
                Tab(child: Text("Dikirim")),
                Tab(child: Text("Riwayat")),
              ],
            )
          : null,
    );
  }
}
