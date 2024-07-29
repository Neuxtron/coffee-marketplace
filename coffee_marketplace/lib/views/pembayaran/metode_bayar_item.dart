import 'package:coffee_marketplace/models/metode_bayar_model.dart';
import 'package:coffee_marketplace/views/widgets/rounded_image.dart';
import 'package:flutter/material.dart';

class MetodeBayarItem extends StatelessWidget {
  final MetodeBayarModel metodeBayar;
  const MetodeBayarItem({super.key, required this.metodeBayar});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pop(context, metodeBayar),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Row(
          children: [
            RoundedImage(
              imageUrl: metodeBayar.imgUrl,
              height: 60,
              width: 60,
              radius: 10,
            ),
            const SizedBox(width: 20),
            Text(
              metodeBayar.nama,
              style: const TextStyle(
                fontFamily: "Abhaya Libre",
                fontWeight: FontWeight.w800,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
