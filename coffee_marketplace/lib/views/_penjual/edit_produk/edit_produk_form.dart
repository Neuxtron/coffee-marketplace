import 'package:coffee_marketplace/models/produk_model.dart';
import 'package:coffee_marketplace/views/widgets/input_item.dart';
import 'package:flutter/material.dart';

class EditProdukForm extends StatefulWidget {
  final Key formKey;
  final ProdukModel produk;
  final TextEditingController namaController;
  final TextEditingController deskripsiController;
  final TextEditingController hargaController;
  final TextEditingController beratController;
  final TextEditingController merkController;

  const EditProdukForm({
    super.key,
    required this.formKey,
    required this.produk,
    required this.namaController,
    required this.deskripsiController,
    required this.hargaController,
    required this.beratController,
    required this.merkController,
  });

  @override
  State<EditProdukForm> createState() => _EditProdukFormState();
}

class _EditProdukFormState extends State<EditProdukForm> {
  @override
  void dispose() {
    super.dispose();
    widget.namaController.dispose();
    widget.deskripsiController.dispose();
    widget.hargaController.dispose();
    widget.beratController.dispose();
    widget.merkController.dispose();
  }

  @override
  void initState() {
    super.initState();
    widget.namaController.text = widget.produk.nama;
    widget.deskripsiController.text = widget.produk.deskripsi;
    widget.hargaController.text = widget.produk.harga.toString();
    widget.beratController.text = widget.produk.beratProduk.toString();
    widget.merkController.text = widget.produk.merk ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InputItem(
            controller: widget.merkController,
            label: "Merk (Opsional):",
            keyboardType: TextInputType.name,
            optional: true,
          ),
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
