import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class NavItem extends StatelessWidget {
  final String iconPath;
  final bool isActive;

  const NavItem({
    super.key,
    required this.iconPath,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: isActive ? 1 : .5,
      child: SvgPicture.asset(
        iconPath,
        height: isActive ? 30 : 26,
        width: isActive ? 30 : 26,
      ),
    );
  }
}
