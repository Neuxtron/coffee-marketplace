import 'dart:io';

import 'package:coffee_marketplace/models/produk_model.dart';
import 'package:coffee_marketplace/utils/app_constants.dart';
import 'package:coffee_marketplace/utils/server_status.dart';
import 'package:coffee_marketplace/viewmodels/kategori_view_model.dart';
import 'package:coffee_marketplace/viewmodels/produk_view_model.dart';
import 'package:coffee_marketplace/views/_penjual/edit_produk/hapus_section.dart';
import 'package:coffee_marketplace/views/_penjual/widgets/gambar_section.dart';
import 'package:coffee_marketplace/views/_penjual/widgets/kategori_section.dart';
import 'package:coffee_marketplace/views/_penjual/widgets/submit_section.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './edit_produk_form.dart';

class EditProdukPage extends StatefulWidget {
  const EditProdukPage({super.key});

  @override
  State<EditProdukPage> createState() => _EditProdukPageState();
}

class _EditProdukPageState extends State<EditProdukPage> {
  final _formKey = GlobalKey<FormState>();
  final _namaController = TextEditingController();
  final _deskripsiController = TextEditingController();
  final _hargaController = TextEditingController();
  final _beratController = TextEditingController();
  final _merkController = TextEditingController();

  File? _gambar;
  String? _idKategori;
  String _error = "";

  bool get _isLoading =>
      context.watch<ProdukViewModel>().status == ServerStatus.loading;

  void uploadProduk() {
    setState(() => _error = "");
    if (_idKategori == null) return;
    if (!(_formKey.currentState?.validate() ?? false)) return;
    // if (_gambar == null) {
    //   setState(() => _error = "Produk harus memiliki gambar");
    //   return;
    // }

    // TODO: upload produk
    print("Mengupload produk...");
  }

  void getData() {
    final viewModel = context.read<KategoriViewModel>();
    viewModel.getKategori();
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    final produk = ModalRoute.of(context)!.settings.arguments as ProdukModel;

    return Scaffold(
      appBar: buildAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              EditProdukForm(
                formKey: _formKey,
                produk: produk,
                namaController: _namaController,
                deskripsiController: _deskripsiController,
                hargaController: _hargaController,
                beratController: _beratController,
                merkController: _merkController,
              ),
              KategoriSection(
                onChange: (idKategori) {
                  _idKategori = idKategori;
                },
                defaultKategori: produk.idKategori,
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
                defaultImage: produk.thumbnail,
              ),
              SubmitSection(
                onSubmit: uploadProduk,
                error: _error,
                text: "Update",
                isLoading: _isLoading,
              ),
              HapusSection(idProduk: produk.id),
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
        "Edit Produk",
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
