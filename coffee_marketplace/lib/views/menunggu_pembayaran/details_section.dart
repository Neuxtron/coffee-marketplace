import 'package:coffee_marketplace/models/order_model.dart';
import 'package:coffee_marketplace/utils/app_constants.dart';
import 'package:coffee_marketplace/views/menunggu_pembayaran/metadata_section.dart';
import 'package:coffee_marketplace/views/widgets/rounded_image.dart';
import 'package:flutter/material.dart';

class DetailsSection extends StatelessWidget {
  final OrderModel order;
  const DetailsSection({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 50, bottom: 30),
      decoration: BoxDecoration(
        color: AppConstants.background,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.07),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      clipBehavior: Clip.hardEdge,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 5,
              horizontal: 20,
            ),
            color: AppConstants.secondary,
            child: const Text(
              "Detail Pembayaran",
              style: TextStyle(
                fontFamily: "Abhaya Libre",
                fontWeight: FontWeight.w800,
                fontSize: 16,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                RoundedImage(
                  imageUrl: order.metodeBayar.imgUrl,
                  height: 55,
                  width: 55,
                  radius: 10,
                ),
                const SizedBox(width: 15),
                MetadataSection(order: order),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
