import 'package:coffee_marketplace/views/checkout/checkout_section_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PengirimanSection extends StatelessWidget {
  const PengirimanSection({super.key});

  @override
  Widget build(BuildContext context) {
    return CheckoutSectionItem(
      icon: SvgPicture.asset("assets/icons/ic_pengiriman.svg"),
      title: "Pengiriman",
      children: [],
    );
  }
}
