import 'package:coffee_marketplace/models/alamat_model.dart';
import 'package:coffee_marketplace/utils/app_constants.dart';
import 'package:coffee_marketplace/viewmodels/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PilihAlamatPage extends StatelessWidget {
  const PilihAlamatPage({super.key});

  AppBar _buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: AppConstants.background,
      title: const Text(
        "Pilih Alamat",
        style: TextStyle(
          fontFamily: "Abhaya Libre",
          fontWeight: FontWeight.w800,
          fontSize: 18,
        ),
      ),
      surfaceTintColor: Colors.transparent,
      titleSpacing: 0,
      centerTitle: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    final listAlamat = context.read<UserViewModel>().currentUser!.alamat;

    return Scaffold(
      appBar: _buildAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 30, left: 20, top: 10),
            child: Text("Pilih alamat pengiriman:"),
          ),
          Expanded(
            child: ListView.separated(
              itemCount: listAlamat.length,
              itemBuilder: (context, index) {
                final alamat = listAlamat[index];
                return _AlamatItem(alamat: alamat);
              },
              separatorBuilder: (context, index) {
                return const Divider(
                  thickness: 1,
                  height: 1,
                  color: Colors.black12,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _AlamatItem extends StatelessWidget {
  final AlamatModel alamat;
  const _AlamatItem({required this.alamat});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pop(context, alamat),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        child: Row(
          children: [
            Expanded(child: Text(alamat.alamat)),
            const Icon(Icons.keyboard_arrow_right_rounded),
          ],
        ),
        // OPTIMIZE: nama provinsi & kecamatan
      ),
    );
  }
}
