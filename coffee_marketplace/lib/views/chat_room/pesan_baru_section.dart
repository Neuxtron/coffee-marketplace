import 'package:coffee_marketplace/models/pesan_model.dart';
import 'package:coffee_marketplace/utils/app_constants.dart';
import 'package:coffee_marketplace/viewmodels/pesan_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PesanBaruSection extends StatefulWidget {
  final String penerima;
  final String myId;

  const PesanBaruSection({
    super.key,
    required this.penerima,
    required this.myId,
  });

  @override
  State<PesanBaruSection> createState() => _PesanBaruSectionState();
}

class _PesanBaruSectionState extends State<PesanBaruSection> {
  final _pesanController = TextEditingController();

  void kirimPesan() {
    final isi = _pesanController.text.trim();
    if (isi.isEmpty) return;

    final pesan = PesanModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      penerima: widget.penerima,
      pengirim: widget.myId,
      isi: isi,
      status: PesanStatus.pending,
    );
    context.read<PesanViewModel>().kirimPesan(pesan);
    _pesanController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 150),
            child: TextField(
              controller: _pesanController,
              maxLines: null,
              keyboardType: TextInputType.multiline,
              textCapitalization: TextCapitalization.sentences,
              decoration: buildInputDecoration(),
            ),
          ),
        ),
        const SizedBox(width: 5),
        SizedBox(
          width: 50,
          child: AspectRatio(
            aspectRatio: 1,
            child: MaterialButton(
              onPressed: kirimPesan,
              minWidth: 0,
              padding: EdgeInsets.zero,
              color: AppConstants.primary,
              elevation: 0,
              highlightElevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(999),
              ),
              child: const Icon(
                Icons.send,
                color: Colors.white60,
              ),
            ),
          ),
        ),
      ],
    );
  }

  InputDecoration buildInputDecoration() {
    return InputDecoration(
      hintText: "Ketik pesan...",
      filled: true,
      fillColor: Colors.white,
      hintStyle: const TextStyle(fontSize: 16, color: Colors.grey),
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      enabledBorder: buildInputBorder(),
      focusedBorder: buildInputBorder(),
    );
  }

  OutlineInputBorder buildInputBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide.none,
    );
  }
}
