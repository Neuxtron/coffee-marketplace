import 'package:coffee_marketplace/models/kategori_model.dart';
import 'package:coffee_marketplace/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class KategoriSection extends StatelessWidget {
  const KategoriSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        itemCount: dummyKategori.length,
        itemBuilder: (context, index) {
          final kategori = dummyKategori[index];

          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 13),
            margin: const EdgeInsets.symmetric(horizontal: 5),
            decoration: BoxDecoration(
              color: AppConstants.secondary,
              borderRadius: BorderRadius.circular(999),
            ),
            child: Row(
              children: [
                SvgPicture.asset(
                  kategori.icon,
                  width: 25,
                  colorFilter: const ColorFilter.mode(
                    Colors.black,
                    BlendMode.srcIn,
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  kategori.nama,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
