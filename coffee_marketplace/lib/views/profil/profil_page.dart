import 'package:coffee_marketplace/models/user_model.dart';
import 'package:coffee_marketplace/utils/app_helpers.dart';
import 'package:coffee_marketplace/viewmodels/keranjang_view_model.dart';
import 'package:coffee_marketplace/viewmodels/order_view_model.dart';
import 'package:coffee_marketplace/viewmodels/pesan_view_model.dart';
import 'package:coffee_marketplace/viewmodels/user_view_model.dart';
import 'package:coffee_marketplace/views/profil/logout_section.dart';
import 'package:coffee_marketplace/views/profil/nama_section.dart';
import 'package:coffee_marketplace/views/profil/pengaturan_section.dart';
import 'package:coffee_marketplace/views/profil/riwayat_section.dart';
import 'package:coffee_marketplace/views/widgets/info_builder.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilPage extends StatefulWidget {
  const ProfilPage({super.key});

  @override
  State<ProfilPage> createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  UserModel? get _user => context.read<UserViewModel>().currentUser;
  bool get _loggedIn => _user != null;

  String get _nama => _user?.nama ?? "-";
  String get _saldo {
    if (_user == null) return "-";
    return AppHelpers.formatHarga(_user!.saldo);
  }

  void login() {
    Navigator.pushNamed(context, "/login");
  }

  void logout() {
    // TODO: konfirmasi
    context.read<UserViewModel>().logout().then((_) {
      Navigator.pushNamed(context, "/login").then((_) => setState(() {}));
    });
    context.read<KeranjangViewModel>().onLogout();
    context.read<PesanViewModel>().onLogout();
    context.read<OrderViewModel>().onLogout();
  }

  @override
  void initState() {
    super.initState();
    if (AppHelpers.token != null) context.read<UserViewModel>().getProfile();
  }

  @override
  Widget build(BuildContext context) {
    if (!_loggedIn) {
      return Center(
        child: InfoBuilder(
          onPressed: login,
          iconData: Icons.person,
          text: "Anda belum login, silahkan login\nterlebih dahulu",
          buttonText: "Login",
          margin: const EdgeInsets.only(bottom: 50),
        ),
      );
    }

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            NamaSection(
              nama: _nama,
              saldo: _saldo,
            ),
            const RiwayatSection(),
            const PengaturanSection(),
            LogoutSection(logout: logout),
          ],
        ),
      ),
    );
  }
}
