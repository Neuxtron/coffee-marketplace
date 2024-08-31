import 'package:coffee_marketplace/models/metode_bayar_model.dart';
import 'package:coffee_marketplace/utils/app_constants.dart';
import 'package:coffee_marketplace/views/pembayaran/metode_bayar_item.dart';
import 'package:flutter/material.dart';

class PembayaranPage extends StatelessWidget {
  const PembayaranPage({super.key});

  @override
  Widget build(BuildContext context) {
    final listMetode =
        ModalRoute.of(context)!.settings.arguments as List<MetodeBayarModel>;

    return Scaffold(
      appBar: buildAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 30, left: 20, top: 10),
            child: Text("Pilih metode pembayaran:"),
          ),
          Expanded(
            child: ListView.separated(
              itemCount: listMetode.length,
              itemBuilder: (context, index) {
                final metodeBayar = listMetode[index];
                return MetodeBayarItem(metodeBayar: metodeBayar);
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
