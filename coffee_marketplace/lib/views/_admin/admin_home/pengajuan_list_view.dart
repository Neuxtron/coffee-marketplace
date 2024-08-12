import 'package:coffee_marketplace/viewmodels/pengajuan_pakar_view_model.dart';
import 'package:coffee_marketplace/views/_admin/admin_home/pengajuan_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PengajuanListView extends StatelessWidget {
  const PengajuanListView({super.key});

  static late BuildContext context;

  List get _listPengajuan =>
      context.watch<PengajuanPakarViewModel>().listPengajuan;

  @override
  Widget build(BuildContext context) {
    PengajuanListView.context = context;

    if (_listPengajuan.isEmpty) {
      return const Center(
        child: Text("\nTidak ada pengajuan"),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
      itemCount: 20,
      itemBuilder: (context, index) {
        final pengajuan = _listPengajuan[0];
        return PengajuanItem(pengajuan: pengajuan);
      },
    );
  }
}
