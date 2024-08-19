import 'package:coffee_marketplace/viewmodels/order_view_model.dart';
import 'package:coffee_marketplace/views/riwayat/riwayat_list_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DikemasView extends StatelessWidget {
  const DikemasView({super.key});

  @override
  Widget build(BuildContext context) {
    final listRiwayat = context.watch<OrderViewModel>().listDikemas;

    return RiwayatListView(
      listRiwayat: listRiwayat,
      buttonText: (_) => "Hubungi Penjual",
      title: (_) => "Pesanan sedang dikemas",
      // TODO: halaman chatroom penjual
      buttonOnPressed: (order) {},
    );
  }
}
