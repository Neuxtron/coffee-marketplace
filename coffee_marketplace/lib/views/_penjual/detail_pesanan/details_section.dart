import 'package:coffee_marketplace/utils/app_helpers.dart';
import 'package:coffee_marketplace/views/_penjual/helpers/status_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DetailsSection extends StatelessWidget {
  final int subtotalProduk;
  final int ongkir;
  final String status;

  const DetailsSection({
    super.key,
    required this.subtotalProduk,
    required this.ongkir,
    required this.status,
  });

  TextStyle get _textStyle {
    return const TextStyle(
      fontFamily: "Abhaya Libre",
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );
  }

  @override
  Widget build(BuildContext context) {
    final subtotalString = AppHelpers.formatHarga(subtotalProduk);
    final ongkirString = AppHelpers.formatHarga(ongkir);

    return Column(
      children: [
        const SizedBox(height: 40),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 10),
              child: SvgPicture.asset("assets/icons/ic_detail.svg"),
            ),
            const Text(
              "Detail Pembayaran",
              style: TextStyle(
                fontFamily: "Abhaya Libre",
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              detailItem("Subtotal Produk:", subtotalString),
              detailItem("Ongkir:", ongkirString),
              detailItem("Status:", statusMessage[status]!)
            ],
          ),
        ),
        const Divider(
          height: 1,
          thickness: 1,
          color: Colors.black26,
        ),
      ],
    );
  }

  Widget detailItem(String key, String value) {
    return Row(
      children: [
        Expanded(
          child: Text(
            key,
            overflow: TextOverflow.ellipsis,
            style: _textStyle,
          ),
        ),
        Text(value)
      ],
    );
  }
}
