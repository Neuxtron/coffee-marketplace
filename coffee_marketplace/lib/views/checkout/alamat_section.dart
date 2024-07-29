import 'package:coffee_marketplace/viewmodels/user_view_model.dart';
import 'package:coffee_marketplace/views/checkout/checkout_section_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class AlamatSection extends StatelessWidget {
  const AlamatSection({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.read<UserViewModel>().currentUser!;

    return CheckoutSectionItem(
      icon: SvgPicture.asset("assets/icons/ic_lokasi.svg"),
      title: "Alamat",
      children: [Text(user.alamat)],
    );
  }
}
