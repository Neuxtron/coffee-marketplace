import 'package:coffee_marketplace/utils/app_constants.dart';
import 'package:coffee_marketplace/utils/server_status.dart';
import 'package:coffee_marketplace/viewmodels/order_view_model.dart';
import 'package:coffee_marketplace/views/_penjual/riwayat_pesanan/list_view_wrapper.dart';
import 'package:coffee_marketplace/views/_penjual/riwayat_pesanan/pesanan_item.dart';
import 'package:coffee_marketplace/views/widgets/info_builder.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:coffee_marketplace/models/order_model.dart';

class RiwayatPesananPage extends StatefulWidget {
  const RiwayatPesananPage({super.key});

  @override
  State<RiwayatPesananPage> createState() => _RiwayatPesananPageState();
}

class _RiwayatPesananPageState extends State<RiwayatPesananPage> {
  OrderViewModel get _viewModelWatch => context.watch<OrderViewModel>();

  List<OrderModel> get _listBelumDikirim {
    return _viewModelWatch.listPesananPenjual.where((order) {
      return order.status == "settlement";
    }).toList();
  }

  List<OrderModel> get _listPesanan {
    return _viewModelWatch.listPesananPenjual.where((order) {
      return order.status != "settlement";
    }).toList();
  }

  void getData() {
    context.read<OrderViewModel>().getPesananPenjual();
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    if (_viewModelWatch.status == ServerStatus.error) {
      return Scaffold(
        appBar: buildAppBar(),
        body: Align(
          alignment: Alignment.topCenter,
          child: InfoBuilder(
            onPressed: () => getData(),
            iconData: Icons.error_outline,
          ),
        ),
      );
    }

    if (_viewModelWatch.status == ServerStatus.loading) {
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
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              ListViewWrapper(
                length: _listBelumDikirim.length,
                itemBuilder: (context, index) {
                  return itemBuilder(
                    context,
                    index,
                    _listBelumDikirim,
                  );
                },
              ),
              ListViewWrapper(
                length: _listPesanan.length,
                itemBuilder: (context, index) {
                  return itemBuilder(
                    context,
                    index,
                    _listPesanan,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget itemBuilder(BuildContext context, int index, List<OrderModel> list) {
    final order = list[index];
    return PesananItem(order: order);
  }

  AppBar buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: AppConstants.background,
      title: const Text(
        "Riwayat Pesanan",
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
