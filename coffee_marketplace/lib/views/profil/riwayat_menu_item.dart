import 'package:coffee_marketplace/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class RiwayatMenuItem extends StatelessWidget {
  final int index;
  final String iconPath;
  final String text;

  const RiwayatMenuItem({
    super.key,
    required this.index,
    required this.iconPath,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          // TODO: navigate
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                SvgPicture.asset(
                  iconPath,
                  colorFilter: const ColorFilter.mode(
                    AppConstants.secondaryAlt,
                    BlendMode.srcIn,
                  ),
                  height: 35,
                  width: 35,
                ),
                Text(
                  text,
                  style: const TextStyle(
                    fontFamily: "Abhaya Libre",
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
