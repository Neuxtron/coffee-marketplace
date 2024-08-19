import 'package:coffee_marketplace/models/order_model.dart';
import 'package:coffee_marketplace/models/produk_model.dart';
import 'package:coffee_marketplace/viewmodels/order_view_model.dart';
import 'package:coffee_marketplace/viewmodels/produk_view_model.dart';
import 'package:coffee_marketplace/views/riwayat/riwayat_list_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RiwayatView extends StatelessWidget {
  const RiwayatView({super.key});

  static late BuildContext context;

  ProdukModel getProduk(OrderModel order) {
    final id = order.keranjang[0].produk.id;
    return context.read<ProdukViewModel>().produkById(id);
  }

  @override
  Widget build(BuildContext context) {
    RiwayatView.context = context;
    final listRiwayat = context.watch<OrderViewModel>().listSelesai;

    return RiwayatListView(
      listRiwayat: listRiwayat,
      buttonText: (order) {
        if (order.status == "selesai") {
          return "Beli Lagi";
        }
        return "Beli Ulang";
      },
      title: (order) => order.statusMessage,
      buttonOnPressed: (order) => Navigator.pushNamed(
        context,
        "/details",
        arguments: getProduk(order),
      ),
    );
  }
}
