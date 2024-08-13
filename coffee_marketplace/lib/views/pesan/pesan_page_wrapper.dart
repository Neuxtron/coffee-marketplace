import 'package:coffee_marketplace/models/pesan_model.dart';
import 'package:coffee_marketplace/utils/app_constants.dart';
import 'package:coffee_marketplace/viewmodels/pesan_view_model.dart';
import 'package:coffee_marketplace/viewmodels/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PesanPageWrapper extends StatelessWidget {
  final Widget body;
  final bool isPenjual;
  final bool isPakar;

  const PesanPageWrapper({
    super.key,
    required this.body,
    required this.isPenjual,
    required this.isPakar,
  });

  static late BuildContext _context;

  @override
  Widget build(BuildContext context) {
    _context = context;
    return DefaultTabController(
      length: 2,
      initialIndex: 1,
      child: Scaffold(
        appBar: buildAppBar(isPenjual, isPakar),
        body: body,
      ),
    );
  }

  AppBar buildAppBar(bool isPenjual, bool isPakar) {
    return AppBar(
      backgroundColor: AppConstants.background,
      surfaceTintColor: AppConstants.background,
      elevation: 0,
      title: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.forum_outlined, size: 25),
          Padding(
            padding: EdgeInsets.only(right: 56, left: 10),
            child: Text(
              "Messages",
              style: TextStyle(
                fontFamily: "Abhaya Libre",
                fontWeight: FontWeight.w800,
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
      bottom: TabBar(
        labelColor: AppConstants.primary,
        unselectedLabelColor: Colors.black45,
        labelStyle: const TextStyle(
          fontWeight: FontWeight.w800,
          fontFamily: "Abhaya Libre",
        ),
        unselectedLabelStyle: const TextStyle(
          fontFamily: "Abhaya Libre",
          fontWeight: FontWeight.w600,
        ),
        indicatorColor: AppConstants.primary,
        overlayColor: const WidgetStatePropertyAll(Colors.white24),
        tabs: [
          Tab(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(isPenjual ? "Pelanggan" : "Penjual"),
                const SizedBox(width: 10),
                notifIcon("penjual", isPenjual),
              ],
            ),
          ),
          Tab(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(isPakar ? "Konsultasi" : "Pakar"),
                const SizedBox(width: 10),
                notifIcon("pakar", isPakar),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget notifIcon(String role, bool cond) {
    final user = _context.watch<UserViewModel>().currentUser;
    final listPesan = _context.watch<PesanViewModel>().listPesan;

    final hasUnread = listPesan.any((pesan) {
      if (user == null || user.id == null) return false;
      if (pesan.status != PesanStatus.delivered) return false;
      if (pesan.pengirim == user.id) return false;
      if (cond) {
        if (pesan.role == role) return false;
      } else {
        if (pesan.role != role) return false;
      }
      return true;
    });

    if (!hasUnread) return const SizedBox();
    return const Icon(
      Icons.circle,
      size: 10,
      color: AppConstants.primary,
    );
  }
}
