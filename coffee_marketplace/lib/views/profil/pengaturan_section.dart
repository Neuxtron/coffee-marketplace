import 'package:coffee_marketplace/utils/app_constants.dart';
import 'package:coffee_marketplace/viewmodels/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PengaturanSection extends StatelessWidget {
  const PengaturanSection({super.key});

  static late BuildContext _context;

  static List<PengaturanItem> get _listPengaturan {
    final role = _context.read<UserViewModel>().currentUser!.role;

    final listPengaturan = [
      // TODO: route
      PengaturanItem(
        route: "",
        icon: const Icon(Icons.settings),
        text: "Pengaturan Akun",
      ),
      // TODO: route
      PengaturanItem(
        route: "",
        icon: const Icon(Icons.lock_outline),
        text: "Ubah Password",
      ),
    ];

    if (role == "penjual") {
      listPengaturan.insert(
        1,
        PengaturanItem(
          route: "/toko_saya",
          icon: const Icon(Icons.store),
          text: "Toko Saya",
          replace: true,
        ),
      );
    }

    if (role == "pelanggan") {
      listPengaturan.insert(
        1,
        PengaturanItem(
          route: "/mengajukan_pakar",
          icon: const Icon(Icons.store),
          text: "Mengjukan sebagai pakar",
        ),
      );
    }

    return listPengaturan;
  }

  @override
  Widget build(BuildContext context) {
    PengaturanSection._context = context;

    return Container(
      clipBehavior: Clip.hardEdge,
      margin: const EdgeInsets.only(top: 30),
      decoration: BoxDecoration(
        color: Color.alphaBlend(Colors.white24, AppConstants.background),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.07),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _listPengaturan.length,
          itemBuilder: (context, index) {
            final item = _listPengaturan[index];

            return ListTile(
              onTap: () {
                if (item.replace) {
                  Navigator.pushReplacementNamed(context, item.route);
                  return;
                }
                Navigator.pushNamed(context, item.route);
              },
              leading: item.icon,
              trailing: Icon(
                Icons.keyboard_arrow_right,
                color: Colors.grey.shade400,
              ),
              title: Text(
                item.text,
                style: const TextStyle(
                  fontFamily: "Abhaya Libre",
                  fontWeight: FontWeight.w800,
                ),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return const Divider(
              color: Colors.black12,
              height: 1,
              thickness: 1,
              indent: 30,
              endIndent: 30,
            );
          },
        ),
      ),
    );
  }
}

class PengaturanItem {
  final String route;
  final Widget icon;
  final String text;
  final bool replace;

  PengaturanItem({
    required this.route,
    required this.icon,
    required this.text,
    this.replace = false,
  });
}
