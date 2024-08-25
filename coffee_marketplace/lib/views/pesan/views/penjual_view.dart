import 'package:coffee_marketplace/viewmodels/pesan_view_model.dart';
import 'package:coffee_marketplace/views/pesan/chat_room_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PenjualView extends StatelessWidget {
  final bool isPenjual;
  final Function() updateState;

  const PenjualView({
    super.key,
    required this.isPenjual,
    required this.updateState,
  });

  @override
  Widget build(BuildContext context) {
    final allChatRoom = context.watch<PesanViewModel>().listChatRoom;
    final listChatRoom = allChatRoom.where((room) {
      if (isPenjual) return room.role != "penjual";
      return room.role == "penjual";
    }).toList();

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: listChatRoom.length,
      itemBuilder: (context, index) {
        final chatRoom = listChatRoom[index];
        return ChatRoomItem(
          chatRoom: chatRoom,
          updateState: updateState,
        );
      },
    );
  }
}
