import 'package:coffee_marketplace/models/alamat_model.dart';
import 'package:coffee_marketplace/views/checkout/checkout_section_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AlamatSection extends StatelessWidget {
  final AlamatModel alamat;
  final Function(AlamatModel alamat) onChange;

  const AlamatSection({
    super.key,
    required this.alamat,
    required this.onChange,
  });

  static late BuildContext _context;

  void onTap() {
    Navigator.pushNamed(_context, "/pilih_alamat").then((Object? value) {
      final alamat = value as AlamatModel;
      onChange(alamat);
    });
  }

  @override
  Widget build(BuildContext context) {
    _context = context;
    return CheckoutSectionItem(
      icon: SvgPicture.asset("assets/icons/ic_lokasi.svg"),
      title: "Alamat",
      padding: const EdgeInsets.only(top: 10),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: Text(alamat.alamat)),
              const Icon(Icons.keyboard_arrow_right_rounded),
            ],
          ),
        ),
      ),
    );
  }
}
