import 'package:coffee_marketplace/utils/app_constants.dart';
import 'package:flutter/material.dart';

class PengaturanSection extends StatelessWidget {
  const PengaturanSection({super.key});

  static List<PengaturanItem> get _listPengaturan => [
        PengaturanItem(
          route: "",
          icon: const Icon(Icons.settings),
          text: "Pengaturan Akun",
        ),
        PengaturanItem(
          route: "",
          icon: const Icon(Icons.lock_outline),
          text: "Ubah Password",
        ),
      ];

  @override
  Widget build(BuildContext context) {
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
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: _listPengaturan.length,
        itemBuilder: (context, index) {
          final item = _listPengaturan[index];
          return Material(
            color: Colors.transparent,
            child: ListTile(
              // TODO: navigate
              onTap: () {},
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
    );
  }
}

class PengaturanItem {
  final String route;
  final Widget icon;
  final String text;

  PengaturanItem({
    required this.route,
    required this.icon,
    required this.text,
  });
}
