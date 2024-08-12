import 'package:coffee_marketplace/utils/app_constants.dart';
import 'package:coffee_marketplace/views/widgets/input_item.dart';
import 'package:flutter/material.dart';

class MengajukanPakarPage extends StatefulWidget {
  const MengajukanPakarPage({super.key});

  @override
  State<MengajukanPakarPage> createState() => _MengajukanPakarPageState();
}

class _MengajukanPakarPageState extends State<MengajukanPakarPage> {
  final _pesanController = TextEditingController();

  void submitAjuan() {}

  @override
  void dispose() {
    super.dispose();
    _pesanController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            InputItem(
              controller: _pesanController,
              label: "Silahkan masukkan pesan untuk diajukan:",
              keyboardType: TextInputType.multiline,
              multiline: true,
            ),
            MaterialButton(
              onPressed: submitAjuan,
              color: AppConstants.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(999),
              ),
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: const Text(
                "Ajukan",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontFamily: "Abhaya Libre",
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: AppConstants.background,
      title: const Text(
        "Mengajukan Sebagai Pakar",
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
