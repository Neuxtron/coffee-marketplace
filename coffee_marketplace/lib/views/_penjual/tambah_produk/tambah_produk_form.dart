import 'package:coffee_marketplace/views/_penjual/widgets/input_item.dart';
import 'package:flutter/material.dart';

class TambahProdukForm extends StatefulWidget {
  final Key formKey;
  final TextEditingController namaController;
  final TextEditingController deskripsiController;
  final TextEditingController hargaController;
  final TextEditingController beratController;

  const TambahProdukForm({
    super.key,
    required this.formKey,
    required this.namaController,
    required this.deskripsiController,
    required this.hargaController,
    required this.beratController,
  });

  @override
  State<TambahProdukForm> createState() => _TambahProdukFormState();
}

class _TambahProdukFormState extends State<TambahProdukForm> {
  @override
  void dispose() {
    super.dispose();
    widget.namaController.dispose();
    widget.deskripsiController.dispose();
    widget.hargaController.dispose();
    widget.beratController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InputItem(
            controller: widget.namaController,
            label: "Nama produk:",
            keyboardType: TextInputType.name,
          ),
          InputItem(
            controller: widget.deskripsiController,
            label: "Deskripsi:",
            keyboardType: TextInputType.multiline,
            multiline: true,
          ),
          InputItem(
            controller: widget.hargaController,
            label: "Harga:",
            keyboardType: TextInputType.number,
            prefix: "Rp ",
            isShort: true,
          ),
          InputItem(
            controller: widget.beratController,
            label: "Berat:",
            keyboardType: TextInputType.number,
            suffix: "g",
            isShort: true,
          ),
        ],
      ),
    );
  }
}
