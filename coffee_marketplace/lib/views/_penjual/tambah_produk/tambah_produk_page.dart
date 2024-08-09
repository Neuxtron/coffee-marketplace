import 'dart:io';

import 'package:coffee_marketplace/utils/app_constants.dart';
import 'package:coffee_marketplace/viewmodels/kategori_view_model.dart';
import 'package:coffee_marketplace/views/_penjual/widgets/gambar_section.dart';
import 'package:coffee_marketplace/views/_penjual/widgets/kategori_section.dart';
import 'package:coffee_marketplace/views/_penjual/widgets/submit_section.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './tambah_produk_form.dart';

class TambahProdukPage extends StatefulWidget {
  const TambahProdukPage({super.key});

  @override
  State<TambahProdukPage> createState() => _TambahProdukPageState();
}

class _TambahProdukPageState extends State<TambahProdukPage> {
  final _formKey = GlobalKey<FormState>();
  final _namaController = TextEditingController();
  final _deskripsiController = TextEditingController();
  final _hargaController = TextEditingController();
  final _beratController = TextEditingController();

  File? _gambar;
  String? _idKategori;
  String _error = "";

  void uploadProduk() {
    setState(() => _error = "");
    if (_idKategori == null) return;
    if (!(_formKey.currentState?.validate() ?? false)) return;
    if (_gambar == null) {
      setState(() => _error = "Produk harus memiliki gambar");
      return;
    }

    // TODO: upload produk
    print("Mengupload produk...");
  }

  void getData() {
    final viewModel = context.read<KategoriViewModel>();
    viewModel.getKategori().then((_) {
      _idKategori = viewModel.listKategori[0].id;
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TambahProdukForm(
                formKey: _formKey,
                namaController: _namaController,
                deskripsiController: _deskripsiController,
                hargaController: _hargaController,
                beratController: _beratController,
              ),
              KategoriSection(
                onChange: (idKategori) {
                  setState(() => _idKategori = idKategori);
                },
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 5),
                child: Text(
                  "Gambar produk:",
                  style: TextStyle(fontSize: 12),
                ),
              ),
              GambarSection(
                onChange: (gambar) => _gambar = gambar,
              ),
              SubmitSection(
                onSubmit: uploadProduk,
                error: _error,
                text: "+ Tambah",
              ),
            ],
          ),
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: AppConstants.background,
      title: const Text(
        "Tambah Produk",
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
