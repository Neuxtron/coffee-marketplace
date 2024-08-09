import 'package:coffee_marketplace/utils/server_status.dart';
import 'package:coffee_marketplace/viewmodels/produk_view_model.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class HapusSection extends StatelessWidget {
  final String idProduk;
  const HapusSection({super.key, required this.idProduk});

  static late BuildContext context;

  void hapusProduk() {
    // TODO: konfirmasi
    final viewModel = context.read<ProdukViewModel>();
    viewModel.hapusProduk(idProduk).then((_) {
      if (viewModel.status == ServerStatus.error) {
        Fluttertoast.showToast(
          msg: "Terjadi kesalahan",
          backgroundColor: Colors.black54,
        );
        return;
      }
      Fluttertoast.showToast(
        msg: "Produk berhasil dihapus",
        backgroundColor: Colors.black54,
      );
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    HapusSection.context = context;

    return Padding(
      padding: const EdgeInsets.only(top: 50, bottom: 10),
      child: Column(
        children: [
          const Divider(
            color: Colors.black12,
            indent: 30,
            endIndent: 30,
          ),
          Center(
            child: TextButton(
              onPressed: hapusProduk,
              style: ButtonStyle(
                padding: const WidgetStatePropertyAll(
                  EdgeInsets.symmetric(horizontal: 50),
                ),
                overlayColor:
                    WidgetStatePropertyAll(Colors.red.withOpacity(.1)),
              ),
              child: const Text(
                "Hapus produk",
                style: TextStyle(color: Colors.red),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
