import 'package:coffee_marketplace/models/keranjang_model.dart';
import 'package:coffee_marketplace/utils/app_constants.dart';
import 'package:coffee_marketplace/utils/app_helpers.dart';
import 'package:coffee_marketplace/viewmodels/keranjang_view_model.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class CheckoutSection extends StatelessWidget {
  final KeranjangViewModel viewModel;
  const CheckoutSection({super.key, required this.viewModel});

  List<KeranjangModel> get _checkedKeranjang {
    return viewModel.listKeranjang.where((keranjang) {
      return keranjang.isChecked;
    }).toList();
  }

  int get _total {
    int total = 0;
    for (var keranjang in _checkedKeranjang) {
      total += keranjang.produk.harga * keranjang.amount;
    }
    return total;
  }

  void checkout(BuildContext context) {
    if (_checkedKeranjang.isEmpty) {
      Fluttertoast.showToast(
        msg: "Pilih satu produk untuk di checkout",
        backgroundColor: Colors.black54,
      );
      return;
    }
    context.read<KeranjangViewModel>().updateKeranjang();
    Navigator.pushNamed(
      context,
      "/checkout",
      arguments: _checkedKeranjang,
    ).then((_) {
      context.read<KeranjangViewModel>().getKeranjang();
    });
  }

  @override
  Widget build(BuildContext context) {
    final totalString = AppHelpers.formatHarga(_total);

    return Container(
      color: AppConstants.secondary,
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Text(
                "Total\n$totalString",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () => checkout(context),
            child: Container(
              color: AppConstants.primary,
              padding: const EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 20,
              ),
              child: const Text(
                "Checkout",
                style: TextStyle(
                  fontFamily: "Abhaya Libre",
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
