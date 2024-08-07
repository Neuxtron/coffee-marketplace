import 'package:coffee_marketplace/models/pesan_model.dart';
import 'package:coffee_marketplace/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChatItem extends StatelessWidget {
  final PesanModel pesan;
  final bool isSender;

  const ChatItem({
    super.key,
    required this.pesan,
    required this.isSender,
  });

  String? get waktu {
    if (pesan.tglBuat == null) return null;
    return DateFormat("HH.mm").format(pesan.tglBuat!);
  }

  IconData get iconData {
    if (pesan.status == PesanStatus.pending) return Icons.access_time;
    if (pesan.status == PesanStatus.failed) return Icons.error_outline;
    if (pesan.status == PesanStatus.deleted) return Icons.delete_outline;
    if (pesan.status == PesanStatus.read) return Icons.done_all;
    if (pesan.status == PesanStatus.delivered) return Icons.done_all;
    return Icons.done;
  }

  Color get iconColor {
    if (pesan.status == PesanStatus.failed) return Colors.red;
    // if (pesan.status == PesanStatus.read) return Colors.blue.shade300;
    return detailColor;
  }

  Color get detailColor => isSender ? Colors.white60 : Colors.black45;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        margin: EdgeInsets.fromLTRB(isSender ? 40 : 0, 3, isSender ? 0 : 40, 0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color:
              isSender ? AppConstants.primary.withOpacity(.85) : Colors.white,
        ),
        child: Column(
          crossAxisAlignment:
              isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Text(
              pesan.isi,
              style: TextStyle(
                color: isSender ? Colors.white : Colors.black,
              ),
            ),
            const SizedBox(height: 3),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  waktu ?? "",
                  style: TextStyle(fontSize: 10, color: detailColor),
                ),
                const SizedBox(width: 5),
                isSender
                    ? Icon(
                        iconData,
                        color: iconColor,
                        size: 17,
                      )
                    : const SizedBox(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
