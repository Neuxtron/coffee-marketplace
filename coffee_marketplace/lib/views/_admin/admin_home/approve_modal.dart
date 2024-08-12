import 'package:coffee_marketplace/models/pengajuan_pakar_model.dart';
import 'package:coffee_marketplace/viewmodels/pengajuan_pakar_view_model.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class ApproveModal extends StatefulWidget {
  final PengajuanPakarModel pengajuan;
  const ApproveModal({super.key, required this.pengajuan});

  @override
  State<ApproveModal> createState() => _ApproveModalState();
}

class _ApproveModalState extends State<ApproveModal> {
  bool _isLoading = false;

  void approvePengajuan() {
    setState(() => _isLoading = true);
    context
        .read<PengajuanPakarViewModel>()
        .approvePengajuan(widget.pengajuan.id)
        .then(postApprove);
  }

  void postApprove(bool success) {
    setState(() => _isLoading = false);
    Navigator.pop(context);
    if (success) {
      Fluttertoast.showToast(
        msg: "Pengajuan berhasil diterima",
        backgroundColor: Colors.black54,
      );
      return;
    }
    Fluttertoast.showToast(
      msg: "Terjadi kesalahan",
      backgroundColor: Colors.black54,
    );
  }

  Color foregroundApprove(Set<WidgetState> states) {
    if (states.contains(WidgetState.disabled)) {
      return Colors.green.shade300;
    }
    return Colors.green.shade700;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.pengajuan.pakar.nama),
      content: Text(widget.pengajuan.pesan),
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
          onPressed: _isLoading ? null : approvePengajuan,
          style: ButtonStyle(
            overlayColor: WidgetStatePropertyAll(Colors.green.shade100),
            foregroundColor: WidgetStateProperty.resolveWith(foregroundApprove),
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
