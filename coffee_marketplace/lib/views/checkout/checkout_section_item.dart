import 'package:flutter/material.dart';

class CheckoutSectionItem extends StatelessWidget {
  final Widget icon;
  final String title;
  final List<Widget> children;

  const CheckoutSectionItem({
    super.key,
    required this.icon,
    required this.title,
    required this.children,
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
          constraints: const BoxConstraints(minHeight: 120),
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: children,
          ),
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
