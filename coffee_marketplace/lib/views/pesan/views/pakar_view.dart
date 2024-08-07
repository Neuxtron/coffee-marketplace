import 'package:coffee_marketplace/viewmodels/pesan_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../chat_room_item.dart';

class PakarView extends StatefulWidget {
  final bool isPakar;
  final Function() updateState;

  const PakarView({
    super.key,
    required this.isPakar,
    required this.updateState,
  });

  @override
  State<PakarView> createState() => _PakarViewState();
}

class _PakarViewState extends State<PakarView> {
  @override
  Widget build(BuildContext context) {
    final allChatRoom = context.watch<PesanViewModel>().listChatRoom;
    final listChatRoom = allChatRoom.where((room) {
      if (widget.isPakar) return room.role != "pakar";
      return room.role == "pakar";
    }).toList();

    return SingleChildScrollView(
      child: Column(
        children: [
          !widget.isPakar
              ? ListTile(
                  onTap: () => Navigator.pushNamed(context, "/all_pakar"),
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
                      Icons.add,
                      size: 25,
                      color: Colors.grey,
                    ),
                  ),
                  title: const Text(
                    "Semua Pakar",
                    style: TextStyle(fontSize: 14),
                  ),
                )
              : const SizedBox(),
          const Divider(
            color: Colors.black12,
            thickness: 1,
            height: 1,
            indent: 50,
            endIndent: 50,
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: listChatRoom.length,
            itemBuilder: (context, index) {
              final chatRoom = listChatRoom[index];
              return ChatRoomItem(
                chatRoom: chatRoom,
                updateState: widget.updateState,
              );
            },
          ),
        ],
      ),
    );
  }
}
