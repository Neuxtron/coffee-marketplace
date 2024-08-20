import 'package:coffee_marketplace/utils/app_helpers.dart';
import 'package:coffee_marketplace/viewmodels/order_view_model.dart';
import 'package:coffee_marketplace/views/riwayat/riwayat_list_view.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class DikirimView extends StatelessWidget {
  const DikirimView({super.key});

  static late BuildContext _context;

  void postNextStatus(bool success) {
    if (success) {
      Fluttertoast.showToast(
        msg: "Pesanan telah diterima",
        backgroundColor: Colors.black54,
      );
      _context.read<OrderViewModel>().getRiwayat();
      return;
    }
    Fluttertoast.showToast(
      msg: "Terjadi kesalahan",
      backgroundColor: Colors.black54,
    );
  }

  @override
  Widget build(BuildContext context) {
    _context = context;
    final listRiwayat = context.watch<OrderViewModel>().listDikirim;

    return RiwayatListView(
      listRiwayat: listRiwayat,
      buttonText: (order) => "Pesanan Diterima",
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
        context
            .read<OrderViewModel>()
            .nextStatus(order.id, status: "selesai")
            .then(postNextStatus);
      },
    );
  }
}
