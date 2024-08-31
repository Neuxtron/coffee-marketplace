import 'package:coffee_marketplace/models/chat_room_model.dart';
import 'package:coffee_marketplace/utils/app_constants.dart';
import 'package:coffee_marketplace/viewmodels/pesan_view_model.dart';
import 'package:coffee_marketplace/viewmodels/user_view_model.dart';
import 'package:coffee_marketplace/views/chat_room/chat_item.dart';
import 'package:coffee_marketplace/views/chat_room/pesan_baru_section.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatRoomPage extends StatelessWidget {
  const ChatRoomPage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.read<UserViewModel>().currentUser;
    if (user == null) {
      Navigator.pop(context);
      return const SizedBox();
    }

    final chatRoom =
        ModalRoute.of(context)!.settings.arguments as ChatRoomModel;
    final listPesan =
        context.watch<PesanViewModel>().messagesFromId(chatRoom.idUser);
    context.read<PesanViewModel>().readPesan(chatRoom.idUser);

    return Scaffold(
      appBar: buildAppBar(chatRoom),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                reverse: true,
                padding: const EdgeInsets.only(top: 12),
                itemCount: listPesan.length,
                itemBuilder: (context, index) {
                  final pesan = listPesan[index];
                  return ChatItem(
                    pesan: pesan,
                    isSender: user.id == pesan.pengirim,
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
            PesanBaruSection(
              penerima: chatRoom.idUser,
              myId: user.id!,
            ),
          ],
        ),
      ),
    );
  }

  AppBar buildAppBar(ChatRoomModel chatRoom) {
    return AppBar(
      backgroundColor: AppConstants.primary,
      foregroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
      titleSpacing: 0,
      title: Text(
        chatRoom.namaUser,
        style: const TextStyle(fontSize: 18),
      ),
      // OPTIMIZE: actions: search chat
    );
  }
}
