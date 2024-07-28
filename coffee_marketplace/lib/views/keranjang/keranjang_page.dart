import 'package:coffee_marketplace/utils/app_helpers.dart';
import 'package:coffee_marketplace/utils/server_status.dart';
import 'package:coffee_marketplace/viewmodels/keranjang_view_model.dart';
import 'package:coffee_marketplace/views/keranjang/checkout_section.dart';
import 'package:coffee_marketplace/views/keranjang/keranjang_item.dart';
import 'package:coffee_marketplace/views/widgets/info_builder.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class KeranjangPage extends StatefulWidget {
  const KeranjangPage({super.key});

  @override
  State<KeranjangPage> createState() => _KeranjangPageState();
}

class _KeranjangPageState extends State<KeranjangPage> {
  // TODO: update keranjang on leave
  KeranjangViewModel get _viewModel => context.read<KeranjangViewModel>();
  KeranjangViewModel get _viewModelWatch => context.watch<KeranjangViewModel>();

  @override
  void initState() {
    super.initState();
    _viewModel.getKeranjang();
  }

  @override
  Widget build(BuildContext context) {
    final listKeranjang = _viewModelWatch.listKeranjang;
    final loggedIn = AppHelpers.token != null;

    if (!loggedIn) {
      return Align(
        alignment: Alignment.topCenter,
        child: InfoBuilder(
          onPressed: () {
            Navigator.pushNamed(context, "/login").then((_) {
              _viewModel.getKeranjang();
            });
          },
          iconData: Icons.info_outline,
          text: "Silahkan login untuk\nmelihat keranjang",
          buttonText: "Login",
        ),
      );
    }

    if (_viewModelWatch.status == ServerStatus.error) {
      return Align(
        alignment: Alignment.topCenter,
        child: InfoBuilder(
          onPressed: () => _viewModel.getKeranjang(),
          iconData: Icons.error_outline,
        ),
      );
    }

    if (_viewModelWatch.status == ServerStatus.loading) {
      return const Padding(
        padding: EdgeInsets.only(top: 30),
        child: Align(
          alignment: Alignment.topCenter,
          child: SizedBox(
            height: 30,
            width: 30,
            child: CircularProgressIndicator(),
          ),
        ),
      );
    }

    if (_viewModelWatch.listKeranjang.isEmpty) {
      return const Center(
        child: Text(
          "Belanjaan Anda akan tampil disini\nsebelulm checkout",
          textAlign: TextAlign.center,
        ),
      );
    }

    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: listKeranjang.length,
            itemBuilder: (context, index) {
              final keranjang = listKeranjang[index];
              return KeranjangItem(
                keranjang: keranjang,
              );
            },
          ),
        ),
        CheckoutSection(viewModel: _viewModelWatch),
      ],
    );
  }
}
