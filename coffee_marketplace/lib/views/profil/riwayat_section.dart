import 'package:coffee_marketplace/utils/app_constants.dart';
import 'package:coffee_marketplace/views/profil/riwayat_menu_item.dart';
import 'package:flutter/material.dart';

class RiwayatSection extends StatelessWidget {
  const RiwayatSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      margin: const EdgeInsets.only(top: 30),
      decoration: BoxDecoration(
        color: Color.alphaBlend(Colors.white24, AppConstants.background),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.07),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 5),
            color: AppConstants.secondary,
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.list_alt),
                SizedBox(width: 10),
                Text(
                  "Pembelian Saya",
                  style: TextStyle(
                    fontFamily: "Abhaya Libre",
                    fontWeight: FontWeight.w800,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          const Row(
            children: [
              RiwayatMenuItem(
                index: 0,
                iconPath: "assets/icons/ic_bayar.svg",
                text: "Pending",
              ),
              RiwayatMenuItem(
                index: 1,
                iconPath: "assets/icons/ic_dikemas.svg",
                text: "Dikemas",
              ),
              RiwayatMenuItem(
                index: 2,
                iconPath: "assets/icons/ic_dikirim.svg",
                text: "Dikirim",
              ),
            ],
          )
        ],
      ),
    );
  }
}
