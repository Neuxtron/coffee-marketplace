import 'package:coffee_marketplace/utils/app_constants.dart';
import 'package:flutter/material.dart';

class TambahProdukSection extends StatelessWidget {
  const TambahProdukSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: SizedBox(
        height: 80,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              height: 45,
              decoration: const BoxDecoration(
                color: AppConstants.secondaryAlt,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: MaterialButton(
                onPressed: () => Navigator.pushNamed(context, "/tambah_produk"),
                shape: const CircleBorder(),
                minWidth: 0,
                padding: const EdgeInsets.all(5),
                color: AppConstants.primary,
                child: const Icon(
                  Icons.add_rounded,
                  color: Colors.white,
                  size: 50,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
