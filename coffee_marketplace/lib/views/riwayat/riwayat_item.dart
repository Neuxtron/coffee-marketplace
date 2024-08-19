import 'package:coffee_marketplace/models/order_model.dart';
import 'package:coffee_marketplace/utils/app_constants.dart';
import 'package:coffee_marketplace/utils/app_helpers.dart';
import 'package:coffee_marketplace/views/widgets/rounded_image.dart';
import 'package:flutter/material.dart';

class RiwayatItem extends StatelessWidget {
  final OrderModel order;
  final String buttonText;
  final String subtitle;
  final String title;
  final Function(OrderModel order)? itemOnPressed;
  final Function(OrderModel order) buttonOnPressed;

  const RiwayatItem({
    super.key,
    required this.order,
    required this.subtitle,
    required this.title,
    this.itemOnPressed,
    required this.buttonOnPressed,
    required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    final produk = order.keranjang[0].produk;

    int total = 0;
    for (var keranjang in order.keranjang) {
      total += keranjang.amount * keranjang.produk.harga;
    }
    final totalString = AppHelpers.formatHarga(total);

    return Column(
      children: [
        ListTile(
          onTap: itemOnPressed != null ? itemOnPressed!(order) : null,
          title: Row(
            children: [
              RoundedImage(
                imageUrl: produk.thumbnail,
                height: 75,
                width: 75,
                radius: 10,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      produk.nama,
                      style: const TextStyle(fontSize: 14),
                    ),
                    Text(
                      order.keranjang[0].variasi.nama,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          trailing: const Icon(
            Icons.keyboard_arrow_right_rounded,
            color: Colors.grey,
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 15, right: 15),
            child: Text("Total: $totalString"),
          ),
        ),
        Container(
          color: AppConstants.secondary,
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.all(15),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      subtitle,
                      style: const TextStyle(fontSize: 10),
                    ),
                    Text(
                      title,
                    ),
                  ],
                ),
              ),
              MaterialButton(
                onPressed: () => buttonOnPressed(order),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(999),
                ),
                color: AppConstants.primary,
                child: Text(
                  buttonText,
                  style: const TextStyle(
                    color: Colors.white,
                    fontFamily: "Abhaya Libre",
                    fontWeight: FontWeight.w800,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
