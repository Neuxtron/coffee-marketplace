import 'package:coffee_marketplace/models/order_model.dart';
import 'package:coffee_marketplace/viewmodels/order_view_model.dart';
import 'package:coffee_marketplace/views/riwayat/riwayat_list_view.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PendingView extends StatelessWidget {
  const PendingView({super.key});

  static late BuildContext context;

  void buttonOnPressed(OrderModel order) {
    Navigator.pushNamed(
      context,
      "/menunggu_pembayaran",
      arguments: order,
    ).then((_) => context.read<OrderViewModel>().getRiwayat());
  }

  @override
  Widget build(BuildContext context) {
    PendingView.context = context;
    final listRiwayat = context.watch<OrderViewModel>().listPending;
    final formatter = DateFormat("dd-MM-yyyy  HH:mm");

    return RiwayatListView(
        listRiwayat: listRiwayat,
        buttonText: (_) => "Bayar",
        title: (order) => formatter.format(order.expiredAt),
        subtitle: (_) => "Batas waktu pembayaran:",
        buttonOnPressed: buttonOnPressed);
  }
}
