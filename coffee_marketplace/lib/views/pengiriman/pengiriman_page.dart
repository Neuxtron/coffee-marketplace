import 'package:coffee_marketplace/models/kurir_model.dart';
import 'package:coffee_marketplace/utils/app_constants.dart';
import 'package:coffee_marketplace/views/pengiriman/kurir_item.dart';
import 'package:flutter/material.dart';

class PengirimanPage extends StatelessWidget {
  const PengirimanPage({super.key});

  @override
  Widget build(BuildContext context) {
    final listKurir =
        ModalRoute.of(context)!.settings.arguments as List<KurirModel>;

    return Scaffold(
      appBar: buildAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 30, left: 20, top: 10),
            child: Text("Pilih jasa pengiriman:"),
          ),
          Expanded(
            child: ListView.separated(
              itemCount: listKurir.length,
              itemBuilder: (context, index) {
                final kurir = listKurir[index];
                return KurirItem(kurir: kurir);
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

  AppBar buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: AppConstants.background,
      title: const Text(
        "Checkout",
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
}
