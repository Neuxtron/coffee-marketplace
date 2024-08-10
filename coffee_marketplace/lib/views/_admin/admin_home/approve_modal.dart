import 'package:coffee_marketplace/models/pengajuan_pakar_model.dart';
import 'package:flutter/material.dart';

class ApproveModal extends StatelessWidget {
  final PengajuanPakarModel pengajuan;
  const ApproveModal({super.key, required this.pengajuan});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(pengajuan.pakar.nama),
      content: Text(pengajuan.pesan),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          style: ButtonStyle(
            overlayColor: WidgetStatePropertyAll(Colors.grey.shade200),
            foregroundColor: const WidgetStatePropertyAll(Colors.grey),
          ),
          child: const Text("Batal"),
        ),
        TextButton(
          onPressed: () {},
          style: ButtonStyle(
            overlayColor: WidgetStatePropertyAll(Colors.green.shade100),
            foregroundColor: WidgetStatePropertyAll(Colors.green.shade700),
          ),
          child: const Text(
            "Approve",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
