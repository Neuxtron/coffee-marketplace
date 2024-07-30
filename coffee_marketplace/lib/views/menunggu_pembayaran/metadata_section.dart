import 'package:coffee_marketplace/models/order_model.dart';
import 'package:coffee_marketplace/utils/app_helpers.dart';
import 'package:flutter/material.dart';

class MetadataSection extends StatelessWidget {
  final OrderModel order;
  const MetadataSection({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final totalString = AppHelpers.formatHarga(order.subtotal + order.ongkir);
    final expiredString = AppHelpers.formatTanggal(order.expiredAt);

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              order.metodeBayar.nama,
              style: const TextStyle(
                fontFamily: "Abhaya Libre",
                fontWeight: FontWeight.w800,
                fontSize: 16,
              ),
            ),
            ...order.bayarDetails.keys.map((key) {
              final value = order.bayarDetails[key];
              return Text("$key: $value");
            }),
            const SizedBox(height: 16),
            Text("Jumlah bayar: $totalString"),
            Text("Bayar sebelum: $expiredString")
          ],
        ),
      ),
    );
  }
}
