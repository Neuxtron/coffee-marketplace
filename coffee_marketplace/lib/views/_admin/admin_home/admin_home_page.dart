import 'package:coffee_marketplace/models/pakar_model.dart';
import 'package:coffee_marketplace/models/pengajuan_pakar_model.dart';
import 'package:coffee_marketplace/viewmodels/user_view_model.dart';
import 'package:coffee_marketplace/views/_admin/admin_home/pengajuan_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  List get _listPengajuan => [
        PengajuanPakarModel(
          id: "1",
          pakar: PakarModel(id: "1", nama: "Pakar 1"),
          pesan: "Saya ingin menjadi pakar\nTrims",
        ),
      ];

  // TODO: get pakar

  void logout() {
    context.read<UserViewModel>().logout();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: buildAppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 80, 0, 10),
              child: Text(
                "Admin",
                style: TextStyle(
                  color: Colors.black12,
                  fontWeight: FontWeight.w900,
                  fontSize: 32,
                ),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
              itemCount: 20,
              itemBuilder: (context, index) {
                final pengajuan = _listPengajuan[0];
                return PengajuanItem(pengajuan: pengajuan);
              },
            ),
          ],
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white.withOpacity(.01),
      automaticallyImplyLeading: false,
      surfaceTintColor: Colors.transparent,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: IconButton(
            onPressed: logout,
            icon: const Icon(
              Icons.logout,
              color: Colors.grey,
            ),
          ),
        )
      ],
    );
  }
}
