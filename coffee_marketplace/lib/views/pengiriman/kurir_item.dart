import 'package:coffee_marketplace/models/kurir_model.dart';
import 'package:coffee_marketplace/views/widgets/rounded_image.dart';
import 'package:flutter/material.dart';

class KurirItem extends StatelessWidget {
  final KurirModel kurir;
  const KurirItem({super.key, required this.kurir});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pop(context, kurir),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Row(
          children: [
            RoundedImage(
              imageUrl: kurir.imgUrl,
              height: 60,
              width: 60,
              radius: 10,
            ),
            const SizedBox(width: 20),
            Text(
              kurir.nama,
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
