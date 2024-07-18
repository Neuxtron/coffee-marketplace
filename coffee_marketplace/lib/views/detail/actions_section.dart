import 'package:coffee_marketplace/utils/app_constants.dart';
import 'package:flutter/material.dart';

class ActionsSection extends StatefulWidget {
  final Function(int amount) addToCart;
  const ActionsSection({super.key, required this.addToCart});

  @override
  State<ActionsSection> createState() => _ActionsSectionState();
}

class _ActionsSectionState extends State<ActionsSection> {
  int amount = 1;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        MaterialButton(
          onPressed: () {
            if (amount > 1) {
              setState(() => amount--);
            }
          },
          padding: const EdgeInsets.all(8),
          shape: const CircleBorder(),
          color: AppConstants.primary,
          minWidth: 0,
          child: const Icon(
            Icons.remove,
            color: Colors.white,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            amount.toString(),
            style: const TextStyle(fontSize: 18),
          ),
        ),
        MaterialButton(
          onPressed: () => setState(() => amount++),
          padding: const EdgeInsets.all(8),
          shape: const CircleBorder(),
          color: AppConstants.primary,
          minWidth: 0,
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        const Expanded(child: SizedBox()),
        MaterialButton(
          onPressed: () => widget.addToCart(amount),
          color: AppConstants.background,
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
          minWidth: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(999),
          ),
          child: const Row(
            children: [
              Text(
                "Add to cart",
                style: TextStyle(
                  fontFamily: "Abhaya Libre",
                  fontWeight: FontWeight.w800,
                  fontSize: 16,
                ),
              ),
              SizedBox(width: 20),
              Icon(Icons.shopping_basket, size: 20),
            ],
          ),
        ),
        const Expanded(child: SizedBox()),
      ],
    );
  }
}
