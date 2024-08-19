import 'package:coffee_marketplace/utils/app_helpers.dart';
import 'package:coffee_marketplace/viewmodels/order_view_model.dart';
import 'package:coffee_marketplace/views/riwayat/riwayat_list_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DikirimView extends StatelessWidget {
  const DikirimView({super.key});

  @override
  Widget build(BuildContext context) {
    final listRiwayat = context.watch<OrderViewModel>().listDikirim;

    return RiwayatListView(
      listRiwayat: listRiwayat,
      buttonText: (order) {
        if (order.batasKonfirmasi == null) {
          return "Hubungi Penjual";
        }
        return "Pesanan Diterima";
      },
      title: (order) {
        if (order.batasKonfirmasi == null) {
          return "Pesanan dalam perjalanan";
        }
        return AppHelpers.formatTanggal(order.batasKonfirmasi!);
      },
      subtitle: (order) {
        if (order.batasKonfirmasi == null) return "";
        return "Silahkan konfirmasi sebelum:";
      },
      buttonOnPressed: (order) {
        if (order.batasKonfirmasi == null) {
          // TODO: halaman chatroom penjual
          return;
        }
        // TODO: konfirmasi pesanan
      },
    );
  }
}
