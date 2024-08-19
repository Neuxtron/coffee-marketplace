import 'package:coffee_marketplace/views/riwayat/riwayat_item.dart';
import 'package:flutter/material.dart';
import 'package:coffee_marketplace/models/order_model.dart';

class RiwayatListView extends StatelessWidget {
  final List<OrderModel> listRiwayat;
  final String Function(OrderModel order) buttonText;
  final String Function(OrderModel order) title;
  final String Function(OrderModel order)? subtitle;
  final Function(OrderModel order)? itemOnPressed;
  final Function(OrderModel order) buttonOnPressed;

  const RiwayatListView({
    super.key,
    required this.listRiwayat,
    required this.buttonText,
    required this.title,
    this.subtitle,
    this.itemOnPressed,
    required this.buttonOnPressed,
  });

  @override
  Widget build(BuildContext context) {
    if (listRiwayat.isEmpty) {
      return const Padding(
        padding: EdgeInsets.only(top: 50),
        child: Text(
          "Tidak ada data",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 12, color: Colors.grey),
        ),
      );
    }

    return ListView.builder(
      itemCount: listRiwayat.length,
      itemBuilder: (context, index) {
        final order = listRiwayat[index];
        final buttonText = this.buttonText(order);
        final title = this.title(order);
        final subtitle = (this.subtitle ?? (_) => "")(order);

        return RiwayatItem(
          order: order,
          buttonOnPressed: buttonOnPressed,
          // IDEA: halaman detail riwayat, list keranjang + riwayat tracking
          itemOnPressed: itemOnPressed,
          buttonText: buttonText,
          subtitle: subtitle,
          title: title,
        );
      },
    );
  }
}
