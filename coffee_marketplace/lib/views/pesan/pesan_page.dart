import 'package:coffee_marketplace/viewmodels/pesan_view_model.dart';
import 'package:coffee_marketplace/viewmodels/user_view_model.dart';
import 'package:coffee_marketplace/views/pesan/pesan_page_wrapper.dart';
import 'package:coffee_marketplace/views/pesan/views/pakar_view.dart';
import 'package:coffee_marketplace/views/pesan/views/penjual_view.dart';
import 'package:coffee_marketplace/views/widgets/info_builder.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PesanPage extends StatefulWidget {
  const PesanPage({super.key});

  @override
  State<PesanPage> createState() => _PesanPageState();
}

class _PesanPageState extends State<PesanPage> {
  void login() {
    Navigator.pushNamed(context, "/login").then((_) => setState(() {}));
  }

  @override
  void initState() {
    super.initState();
    context.read<PesanViewModel>().getChatRooms();
  }

  @override
  Widget build(BuildContext context) {
    final user = context.read<UserViewModel>().currentUser;

    if (user == null) {
      return PesanPageWrapper(
        isPakar: false,
        isPenjual: false,
        body: Center(
          child: InfoBuilder(
            onPressed: login,
            iconData: Icons.person,
            text: "Anda belum login, silahkan login\nterlebih dahulu",
            buttonText: "Login",
            margin: const EdgeInsets.only(bottom: 50),
          ),
        ),
      );
    }

    final isPenjual = user.role == "penjual";
    final isPakar = user.role == "pakar";
    return PesanPageWrapper(
      isPakar: isPakar,
      isPenjual: isPenjual,
      body: TabBarView(
        children: [
          PenjualView(
            isPenjual: isPenjual,
            updateState: () => setState(() {}),
          ),
          PakarView(
            isPakar: isPakar,
            updateState: () => setState(() {}),
          ),
        ],
      ),
    );
  }
}
