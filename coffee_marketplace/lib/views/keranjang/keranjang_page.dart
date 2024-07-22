import 'package:coffee_marketplace/utils/server_status.dart';
import 'package:coffee_marketplace/viewmodels/keranjang_view_model.dart';
import 'package:coffee_marketplace/views/keranjang/keranjang_item.dart';
import 'package:coffee_marketplace/views/widgets/server_error_builder.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class KeranjangPage extends StatelessWidget {
  const KeranjangPage({super.key});

  @override
  Widget build(BuildContext context) {
    final listKeranjang = context.watch<KeranjangViewModel>().listKeranjang;
    final status = context.watch<KeranjangViewModel>().status;

    if (status == ServerStatus.error) {
      return ServerErrorBuilder(onRetry: () {});
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      itemCount: listKeranjang.length,
      itemBuilder: (context, index) {
        final keranjang = listKeranjang[index];
        return KeranjangItem(
          keranjang: keranjang,
        );
      },
    );
  }
}
