import 'package:coffee_marketplace/models/pesan_model.dart';
import 'package:coffee_marketplace/utils/app_constants.dart';
import 'package:coffee_marketplace/viewmodels/pesan_view_model.dart';
import 'package:coffee_marketplace/viewmodels/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PesanButton extends StatefulWidget {
  const PesanButton({super.key});

  @override
  State<PesanButton> createState() => _PesanButtonState();
}

class _PesanButtonState extends State<PesanButton> {
  void onPressed() {
    Navigator.pushNamed(context, "/pesan").then((_) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    context = context;
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: IconButton(
            onPressed: onPressed,
            icon: Icon(
              Icons.forum_outlined,
              size: 27,
              color: Colors.grey.shade600,
            ),
          ),
        ),
        buildUnreadIndicator(),
      ],
    );
  }

  Widget buildUnreadIndicator() {
    final user = context.watch<UserViewModel>().currentUser;
    final listPesan = context.watch<PesanViewModel>().listPesan;

    final hasUnread = listPesan.any((pesan) {
      if (user == null || user.id == null) return false;
      if (pesan.status != PesanStatus.delivered) return false;
      if (pesan.pengirim == user.id) return false;
      return true;
    });

    if (!hasUnread) return const SizedBox();
    return const Positioned(
      right: 15,
      top: 5,
      child: CircleAvatar(
        radius: 5,
        backgroundColor: AppConstants.primary,
      ),
    );
  }
}
