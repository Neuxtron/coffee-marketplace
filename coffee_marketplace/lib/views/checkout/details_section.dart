import 'package:coffee_marketplace/utils/app_helpers.dart';
import 'package:coffee_marketplace/views/checkout/checkout_section_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DetailsSection extends StatelessWidget {
  final int subtotalProduk;
  final int ongkir;

  const DetailsSection({
    super.key,
    required this.subtotalProduk,
    required this.ongkir,
  });

  @override
  Widget build(BuildContext context) {
    final subtotalString = AppHelpers.formatHarga(subtotalProduk);
    final ongkirString = AppHelpers.formatHarga(ongkir);
    const textStyle = TextStyle(
      fontFamily: "Abhaya Libre",
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );

    return CheckoutSectionItem(
      icon: SvgPicture.asset("assets/icons/ic_detail.svg"),
      title: "Detail Pembayaran",
      child: Column(
        children: [
          Row(
            children: [
              const Expanded(
                child: Text(
                  "Subtotal Produk:",
                  overflow: TextOverflow.ellipsis,
                  style: textStyle,
                ),
              ),
              Text(subtotalString)
            ],
          ),
          Row(
            children: [
              const Expanded(
                child: Text(
                  "Ongkir:",
                  overflow: TextOverflow.ellipsis,
                  style: textStyle,
                ),
              ),
              Text(ongkirString)
            ],
          ),
        ],
      ),
    );
  }
}
