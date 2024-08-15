import 'package:coffee_marketplace/models/chat_room_model.dart';
import 'package:coffee_marketplace/utils/app_constants.dart';
import 'package:coffee_marketplace/viewmodels/pesan_view_model.dart';
import 'package:coffee_marketplace/viewmodels/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatRoomItem extends StatelessWidget {
  final ChatRoomModel chatRoom;
  final Function() updateState;

  const ChatRoomItem({
    super.key,
    required this.chatRoom,
    required this.updateState,
  });

  @override
  Widget build(BuildContext context) {
    final lastPesan =
        context.read<PesanViewModel>().lastMessage(chatRoom.idUser);
    final unreadCount =
        context.read<PesanViewModel>().unreadCount(chatRoom.idUser);
    final myId = context.read<UserViewModel>().currentUser!.id!;
    final isLastSender = lastPesan?.pengirim == myId;

    return ListTile(
      onTap: () {
        Navigator.pushNamed(
          context,
          "/chatroom",
          arguments: chatRoom,
        ).then((_) => updateState());
      },
      contentPadding: const EdgeInsets.symmetric(horizontal: 25),
      minVerticalPadding: 20,
      leading: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            width: 1.5,
            color: Colors.grey,
          ),
        ),
        child: const Icon(
          Icons.person,
          size: 25,
          color: Colors.grey,
        ),
      ),
      title: Text(
        chatRoom.namaUser,
        style: const TextStyle(fontSize: 14),
      ),
      subtitle: lastPesan != null
          ? Text(
              (isLastSender ? "Anda: " : "") + lastPesan.isi,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: Colors.black45),
            )
          : null,
      trailing: unreadCount > 0
          ? CircleAvatar(
              radius: 15,
              backgroundColor: AppConstants.primary.withOpacity(.8),
              child: Text(
                unreadCount.toString(),
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
            )
          : null,
    );
  }
}
