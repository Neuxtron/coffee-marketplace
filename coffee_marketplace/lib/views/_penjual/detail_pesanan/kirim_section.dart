import 'package:coffee_marketplace/utils/app_constants.dart';
import 'package:coffee_marketplace/viewmodels/order_view_model.dart';
import 'package:coffee_marketplace/views/widgets/input_item.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class KirimSection extends StatefulWidget {
  final String id;
  const KirimSection({super.key, required this.id});

  @override
  State<KirimSection> createState() => _KirimSectionState();
}

class _KirimSectionState extends State<KirimSection> {
  final _formKey = GlobalKey<FormState>();
  final _resiController = TextEditingController();

  bool _isLoading = false;

  void kirimPesanan() {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    setState(() => _isLoading = true);

    context
        .read<OrderViewModel>()
        .nextStatus(widget.id, resiPengiriman: _resiController.text.trim())
        .then(postNextStatus);
  }

  void postNextStatus(bool success) {
    setState(() => _isLoading = false);
    if (success) {
      Fluttertoast.showToast(
        msg: "Berhasil mengupdate status",
        backgroundColor: Colors.black54,
      );
      Navigator.pop(context);
      return;
    }
    Fluttertoast.showToast(
      msg: "Terjadi kesalahan",
      backgroundColor: Colors.black54,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _resiController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 50),
            InputItem(
              controller: _resiController,
              label: "Nomor resi pengiriman:",
              keyboardType: TextInputType.text,
            ),
            MaterialButton(
              onPressed: _isLoading ? null : kirimPesanan,
              color: AppConstants.primary,
              disabledColor: AppConstants.primary.withOpacity(.6),
              padding: const EdgeInsets.symmetric(vertical: 7),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(999),
              ),
              child: const Text(
                "Kirim Pesanan",
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: "Abhaya Libre",
                  fontWeight: FontWeight.w800,
                  fontSize: 18,
                ),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
