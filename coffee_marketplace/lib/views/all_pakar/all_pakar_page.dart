import 'package:coffee_marketplace/models/pakar_model.dart';
import 'package:coffee_marketplace/utils/app_constants.dart';
import 'package:coffee_marketplace/utils/server_status.dart';
import 'package:coffee_marketplace/viewmodels/pakar_view_model.dart';
import 'package:coffee_marketplace/views/all_pakar/pakar_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AllPakarPage extends StatefulWidget {
  const AllPakarPage({super.key});

  @override
  State<AllPakarPage> createState() => _AllPakarPageState();
}

class _AllPakarPageState extends State<AllPakarPage> {
  List<PakarModel> get _listPakar => context.watch<PakarViewModel>().listPakar;
  ServerStatus get _status => context.watch<PakarViewModel>().status;

  @override
  void initState() {
    super.initState();
    context.read<PakarViewModel>().getPakar();
  }

  @override
  Widget build(BuildContext context) {
    if (_status == ServerStatus.loading) {
      return Scaffold(
        appBar: buildAppBar(),
        body: const Padding(
          padding: EdgeInsets.only(top: 30),
          child: Align(
            alignment: Alignment.topCenter,
            child: SizedBox(
              height: 30,
              width: 30,
              child: CircularProgressIndicator(),
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: buildAppBar(),
      body: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: _listPakar.length,
        itemBuilder: (context, index) {
          final pakar = _listPakar[index];
          return PakarItem(pakar: pakar);
        },
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: AppConstants.background,
      surfaceTintColor: AppConstants.background,
      elevation: 0,
      centerTitle: true,
      title: const Text(
        "Semua Pakar",
        style: TextStyle(
          fontFamily: "Abhaya Libre",
          fontWeight: FontWeight.w800,
          fontSize: 18,
        ),
      ),
    );
  }
}
