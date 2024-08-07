import 'package:coffee_marketplace/models/chat_room_model.dart';
import 'package:coffee_marketplace/models/pakar_model.dart';
import 'package:flutter/material.dart';

class PakarItem extends StatelessWidget {
  final PakarModel pakar;
  const PakarItem({super.key, required this.pakar});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        final chatRoom = ChatRoomModel(
          idUser: pakar.id,
          namaUser: pakar.nama,
          role: "pakar",
        );
        Navigator.pushNamed(
          context,
          "/chatroom",
          arguments: chatRoom,
        ).then((_) => Navigator.pop(context));
      },
      contentPadding: const EdgeInsets.only(left: 25),
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
        pakar.nama,
        style: const TextStyle(fontSize: 14),
      ),
    );
  }
}
