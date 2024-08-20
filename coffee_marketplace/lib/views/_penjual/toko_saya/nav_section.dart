import 'package:coffee_marketplace/utils/app_constants.dart';
import 'package:flutter/material.dart';

class NavSection extends StatelessWidget {
  const NavSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: SizedBox(
        height: 90,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              height: 70,
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
              decoration: const BoxDecoration(
                color: AppConstants.secondaryAlt,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, "/pesanan_penjual");
                    },
                    child: const Column(
                      children: [
                        Icon(
                          (Icons.receipt),
                          size: 30,
                          color: Colors.white54,
                        ),
                        Text(
                          "Pesanan",
                          style: TextStyle(color: Colors.white54),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, "/pengaturan_toko");
                    },
                    child: const Column(
                      children: [
                        Icon(
                          (Icons.settings),
                          size: 30,
                          color: Colors.white54,
                        ),
                        Text(
                          "Pengaturan",
                          style: TextStyle(color: Colors.white54),
                        ),
                      ],
                    ),
                  ),
                ],
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
