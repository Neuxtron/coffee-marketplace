import 'package:flutter/material.dart';

class CheckoutSectionItem extends StatelessWidget {
  final Widget icon;
  final String title;
  final Widget child;
  final double minHeight;
  final EdgeInsets padding;

  const CheckoutSectionItem({
    super.key,
    required this.icon,
    required this.title,
    required this.child,
    this.minHeight = 120,
    this.padding = const EdgeInsets.all(20),
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 10),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 10),
              child: icon,
            ),
            Text(
              title,
              style: const TextStyle(
                fontFamily: "Abhaya Libre",
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
        Container(
          constraints: BoxConstraints(minHeight: minHeight),
          padding: padding,
          child: child,
        ),
        const Divider(
          height: 1,
          thickness: 1,
          color: Colors.black26,
        ),
      ],
    );
  }
}
