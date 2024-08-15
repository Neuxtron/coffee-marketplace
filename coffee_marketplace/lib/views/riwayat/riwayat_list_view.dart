import 'package:flutter/material.dart';
import 'package:coffee_marketplace/models/order_model.dart';

class RiwayatListView extends StatelessWidget {
  final List<OrderModel> listRiwayat;
  final String Function(String status) buttonText;
  final String Function(OrderModel order) title;
  final String? subtitle;
  final Function()? itemOnPressed;
  final Function() buttonOnPressed;

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
    return ListView.builder(
      itemCount: listRiwayat.length,
      itemBuilder: (context, index) {
        // final riwayat = listRiwayat[index];
        // TODO: riwayat item
        return SizedBox();
      },
    );
  }
}
