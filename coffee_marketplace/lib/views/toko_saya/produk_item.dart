import 'package:coffee_marketplace/models/produk_model.dart';
import 'package:coffee_marketplace/utils/app_constants.dart';
import 'package:coffee_marketplace/views/widgets/rounded_image.dart';
import 'package:flutter/material.dart';

class ProdukItem extends StatelessWidget {
  final ProdukModel produk;
  const ProdukItem({super.key, required this.produk});

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Material(
        color: Color.alphaBlend(Colors.white24, AppConstants.background),
        child: InkWell(
          onTap: () {},
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 15, 10),
                child: RoundedImage(
                  imageUrl: produk.thumbnail,
                  height: 75,
                  width: 75,
                  radius: 10,
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      produk.nama,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      "Total Stok: ${produk.totalStok}",
                      style: const TextStyle(
                        color: Colors.black45,
                        fontSize: 12,
                      ),
                    )
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(right: 10, left: 5),
                child: Icon(
                  Icons.keyboard_arrow_right,
                  color: Colors.black26,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
