import 'package:coffee_marketplace/models/variasi_model.dart';
import 'package:coffee_marketplace/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class VariasiItemView extends StatefulWidget {
  final Function(int index, VariasiModel variasi) onChanged;
  final int index;

  const VariasiItemView({
    super.key,
    required this.onChanged,
    required this.index,
  });

  @override
  State<VariasiItemView> createState() => _VariasiItemViewState();
}

class _VariasiItemViewState extends State<VariasiItemView> {
  final _namaController = TextEditingController();
  final _stokController = TextEditingController();

  void onChanged(_) {
    final variasi = VariasiModel(
      nama: _namaController.text.trim(),
      stok: int.tryParse(_stokController.text) ?? 0,
    );
    widget.onChanged(widget.index, variasi);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _namaController,
              // TODO: validator
              style: const TextStyle(fontSize: 14),
              keyboardType: TextInputType.name,
              onChanged: onChanged,
              decoration: buildDecoration("Nama"),
            ),
          ),
          const SizedBox(width: 10),
          SizedBox(
            width: 100,
            child: TextField(
              controller: _stokController,
              style: const TextStyle(fontSize: 14),
              keyboardType: TextInputType.number,
              onChanged: onChanged,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: buildDecoration("Stok"),
            ),
          ),
        ],
      ),
    );
  }

  InputDecoration buildDecoration(String hint) {
    return InputDecoration(
      filled: true,
      isDense: true,
      hintText: hint,
      fillColor: AppConstants.secondary.withOpacity(.5),
      contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      enabledBorder: buildBorder(),
      focusedBorder: buildBorder(),
      errorBorder: buildBorder(),
      focusedErrorBorder: buildBorder(),
    );
  }

  OutlineInputBorder buildBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: AppConstants.secondaryAlt),
    );
  }
}
