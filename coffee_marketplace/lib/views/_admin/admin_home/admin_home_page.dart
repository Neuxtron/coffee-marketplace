import 'package:coffee_marketplace/utils/server_status.dart';
import 'package:coffee_marketplace/viewmodels/pengajuan_pakar_view_model.dart';
import 'package:coffee_marketplace/viewmodels/user_view_model.dart';
import 'package:coffee_marketplace/views/_admin/admin_home/pengajuan_list_view.dart';
import 'package:coffee_marketplace/views/widgets/info_builder.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  ServerStatus get _status => context.watch<PengajuanPakarViewModel>().status;

  void getData() {
    context.read<PengajuanPakarViewModel>().getPengajuan();
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  void logout() {
    context.read<UserViewModel>().logout();
  }

  @override
  Widget build(BuildContext context) {
    if (_status == ServerStatus.loading) {
      return const Scaffold(
        body: Center(
          child: SizedBox(
            height: 30,
            width: 30,
            child: CircularProgressIndicator(),
          ),
        ),
      );
    }

    if (_status == ServerStatus.error) {
      return Scaffold(
        body: Center(
          child: InfoBuilder(
            onPressed: getData,
            iconData: Icons.error_outline,
          ),
        ),
      );
    }

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: buildAppBar(),
      body: const SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
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
            PengajuanListView(),
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
