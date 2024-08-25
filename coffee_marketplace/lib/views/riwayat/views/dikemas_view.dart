import 'package:coffee_marketplace/models/chat_room_model.dart';
import 'package:coffee_marketplace/models/order_model.dart';
import 'package:coffee_marketplace/viewmodels/order_view_model.dart';
import 'package:coffee_marketplace/views/riwayat/riwayat_list_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DikemasView extends StatelessWidget {
  const DikemasView({super.key});

  static late BuildContext _context;

  void onPressed(OrderModel order) {
    final penjual = order.keranjang[0].produk.penjual;
    final chatRoom = ChatRoomModel(
      idUser: penjual.id,
      namaUser: penjual.namaToko,
      role: "penjual",
    );
    Navigator.pushNamed(_context, "/chatroom", arguments: chatRoom);
  }

  @override
  Widget build(BuildContext context) {
    _context = context;
    final listRiwayat = context.watch<OrderViewModel>().listDikemas;

    return RiwayatListView(
      listRiwayat: listRiwayat,
      buttonText: (_) => "Hubungi Penjual",
      title: (_) => "Pesanan sedang dikemas",
      buttonOnPressed: onPressed,
    );
  }
}
