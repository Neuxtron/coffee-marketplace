import 'package:coffee_marketplace/utils/app_constants.dart';
import 'package:flutter/material.dart';

class GambarSection extends StatelessWidget {
  final String gambar;
  const GambarSection({
    super.key,
    required this.gambar,
  });

  @override
  Widget build(BuildContext context) {
    const shadowSize = 300.0;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: Stack(
        children: [
          Container(
            height: shadowSize,
            width: shadowSize,
            margin: const EdgeInsets.fromLTRB(5, 40, 5, 0),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppConstants.secondary,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          SizedBox(
            width: shadowSize + 10,
            child: Align(
              alignment: Alignment.topCenter,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                clipBehavior: Clip.hardEdge,
                child: Image.network(
                  gambar,
                  height: 260,
                  width: 260,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
