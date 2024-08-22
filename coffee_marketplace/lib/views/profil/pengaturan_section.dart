import 'package:coffee_marketplace/utils/app_constants.dart';
import 'package:coffee_marketplace/viewmodels/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PengaturanSection extends StatelessWidget {
  const PengaturanSection({super.key});

  static late BuildContext _context;
  static late String _role;
  static late bool _terkonfirmasi;

  static List<PengaturanItem> get _listPengaturan {
    final listPengaturan = [
      PengaturanItem(
        route: "/pengaturan_akun",
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

    if (_role == "penjual") {
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

    if (_role == "pelanggan" && _terkonfirmasi) {
      listPengaturan.insert(
        1,
        PengaturanItem(
          route: "/mengajukan_pakar",
          icon: const Icon(Icons.person_2),
          text: "Mengajukan Sebagai Pakar",
        ),
      );
    }

    if (!_terkonfirmasi) {
      listPengaturan.insert(
        0,
        PengaturanItem(
          route: "/konfirmasi_email",
          icon: const Icon(Icons.mark_email_read_outlined),
          text: "Konfirmasi Email",
        ),
      );
    }

    return listPengaturan;
  }

  @override
  Widget build(BuildContext context) {
    _context = context;
    final viewModel = _context.watch<UserViewModel>();
    _role = viewModel.currentUser!.role;
    _terkonfirmasi = viewModel.currentUser!.terkonfirmasi!;

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

            return _PengaturanItem(item: item);
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

class _PengaturanItem extends StatefulWidget {
  final PengaturanItem item;
  const _PengaturanItem({required this.item});

  @override
  State<_PengaturanItem> createState() => _PengaturanItemState();
}

class _PengaturanItemState extends State<_PengaturanItem> {
  void _onTilePressed() {
    if (widget.item.replace) {
      Navigator.pushReplacementNamed(context, widget.item.route);
      return;
    }
    Navigator.pushNamed(context, widget.item.route);
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: _onTilePressed,
      leading: widget.item.icon,
      trailing: Icon(
        Icons.keyboard_arrow_right,
        color: Colors.grey.shade400,
      ),
      title: Text(
        widget.item.text,
        style: const TextStyle(
          fontFamily: "Abhaya Libre",
          fontWeight: FontWeight.w800,
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
