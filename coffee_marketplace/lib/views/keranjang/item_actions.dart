import 'package:coffee_marketplace/utils/app_constants.dart';
import 'package:coffee_marketplace/viewmodels/keranjang_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ItemActions extends StatelessWidget {
  final int amount;
  final String id;

  const ItemActions({
    super.key,
    required this.amount,
    required this.id,
  });

  static late BuildContext _context;

  void setAmount(int amount) {
    _context.read<KeranjangViewModel>().setAmount(id, amount);
  }

  @override
  Widget build(BuildContext context) {
    _context = context;

    return Column(
      children: [
        Row(
          children: [
            MaterialButton(
              onPressed: () {
                if (amount > 1) {
                  setAmount(amount - 1);
                }
              },
              padding: const EdgeInsets.all(5),
              shape: const CircleBorder(),
              color: AppConstants.primary,
              minWidth: 0,
              child: const Icon(
                Icons.remove,
                color: Colors.white,
                size: 25,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3),
              child: Text(
                amount.toString(),
                style: const TextStyle(fontSize: 14),
              ),
            ),
            MaterialButton(
              onPressed: () => setAmount(amount + 1),
              padding: const EdgeInsets.all(5),
              shape: const CircleBorder(),
              color: AppConstants.primary,
              minWidth: 0,
              child: const Icon(
                Icons.add,
                color: Colors.white,
                size: 25,
              ),
            ),
          ],
        ),
        MaterialButton(
          onPressed: () {
            context.read<KeranjangViewModel>().hapusKeranang(id);
          },
          color: Colors.red.shade400,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(999),
          ),
          child: const Row(
            children: [
              Icon(
                Icons.delete_outline,
                color: Colors.white,
                size: 20,
              ),
              SizedBox(width: 10),
              Text(
                "Hapus",
                style: TextStyle(color: Colors.white),
              )
            ],
          ),
        ),
      ],
    );
  }
}
