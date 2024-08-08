import 'package:coffee_marketplace/views/_penjual/widgets/input_item.dart';
import 'package:flutter/material.dart';

class TambahProdukForm extends StatefulWidget {
  final Key formKey;
  const TambahProdukForm({super.key, required this.formKey});

  @override
  State<TambahProdukForm> createState() => _TambahProdukFormState();
}

class _TambahProdukFormState extends State<TambahProdukForm> {
  final _namaController = TextEditingController();
  final _deskripsiController = TextEditingController();
  final _hargaController = TextEditingController();
  final _beratController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _namaController.dispose();
    _deskripsiController.dispose();
    _hargaController.dispose();
    _beratController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InputItem(
            controller: _namaController,
            label: "Nama produk:",
            keyboardType: TextInputType.name,
          ),
          InputItem(
            controller: _deskripsiController,
            label: "Deskripsi:",
            keyboardType: TextInputType.multiline,
            multiline: true,
          ),
          InputItem(
            controller: _hargaController,
            label: "Harga:",
            keyboardType: TextInputType.number,
            prefix: "Rp ",
            isShort: true,
          ),
          InputItem(
            controller: _beratController,
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
