import 'package:coffee_marketplace/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class NamaSection extends StatelessWidget {
  final String nama;
  final String saldo;

  const NamaSection({
    super.key,
    required this.nama,
    required this.saldo,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(3),
          decoration: BoxDecoration(
            color: Colors.transparent,
            shape: BoxShape.circle,
            border: Border.all(
              width: 3,
              color: AppConstants.primary,
            ),
          ),
          child: const Icon(
            Icons.person,
            size: 45,
            color: AppConstants.primary,
          ),
        ),
        const SizedBox(width: 15),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              nama,
              style: const TextStyle(
                fontFamily: "Abhaya Libre",
                fontWeight: FontWeight.w800,
                fontSize: 20,
              ),
            ),
            Row(
              children: [
                SvgPicture.asset("assets/icons/ic_topup.svg"),
                const SizedBox(width: 5),
                Text(
                  saldo,
                  style: const TextStyle(
                    fontFamily: "Abhaya Libre",
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ],
        )
      ],
    );
  }
}
