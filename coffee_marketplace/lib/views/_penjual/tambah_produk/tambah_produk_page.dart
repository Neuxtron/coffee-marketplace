import 'dart:io';

import 'package:coffee_marketplace/models/produk_request_model.dart';
import 'package:coffee_marketplace/models/variasi_model.dart';
import 'package:coffee_marketplace/utils/app_constants.dart';
import 'package:coffee_marketplace/utils/server_status.dart';
import 'package:coffee_marketplace/viewmodels/kategori_view_model.dart';
import 'package:coffee_marketplace/viewmodels/produk_view_model.dart';
import 'package:coffee_marketplace/views/_penjual/widgets/variasi_section.dart';
import 'package:coffee_marketplace/views/_penjual/widgets/gambar_section.dart';
import 'package:coffee_marketplace/views/_penjual/widgets/kategori_section.dart';
import 'package:coffee_marketplace/views/_penjual/widgets/submit_section.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
  final _merkController = TextEditingController();

  final List<VariasiModel> _listVariasi = [
    VariasiModel(id: null, nama: "", stok: 0),
  ];

  File? _gambar;
  String? _idKategori;
  String _error = "";

  bool get _isLoading =>
      context.watch<ProdukViewModel>().status == ServerStatus.loading;

  void uploadProduk() {
    setState(() => _error = "");
    if (_idKategori == null) return;
    if (!(_formKey.currentState?.validate() ?? false)) return;
    if (!validateVariasi()) return;
    if (_gambar == null) {
      setState(() => _error = "Produk harus memiliki gambar");
      return;
    }

    final variasi = VariasiModel.toMap(_listVariasi);
    final merk = _merkController.text.isEmpty ? null : _merkController.text;
    final produkRequest = ProdukRequestModel(
      nama: _namaController.text,
      deskripsi: _deskripsiController.text,
      harga: int.parse(_hargaController.text),
      beratProduk: int.parse(_beratController.text),
      merk: merk,
      idKategori: _idKategori!,
      gambar: _gambar!,
      variasi: variasi,
    );

    context.read<ProdukViewModel>().createProduk(produkRequest).then((_) {
      final status = context.read<ProdukViewModel>().status;
      if (status == ServerStatus.error) {
        Fluttertoast.showToast(
          msg: "Terjadi kesalahan",
          backgroundColor: Colors.black54,
        );
        return;
      }
      Fluttertoast.showToast(
        msg: "Produk berhasil ditambah",
        backgroundColor: Colors.black54,
      );
      Navigator.pop(context);
    });
  }

  void onVariasiChanged(int index, VariasiModel variasi) {
    _listVariasi[index] = variasi;
  }

  void addVariasi() {
    final defaultVariasi = VariasiModel(id: null, nama: "", stok: 0);
    setState(() => _listVariasi.add(defaultVariasi));
  }

  void removeVariasi() {
    setState(() => _listVariasi.removeLast());
  }

  bool validateVariasi() {
    if (_listVariasi.isEmpty) {
      setState(() => _error = "Variasi tidak boleh kosong");
      return false;
    }
    for (var variasi in _listVariasi) {
      if (variasi.nama == "") {
        setState(() => _error = "Nama variasi tidak boleh kosong");
        return false;
      }
    }
    return true;
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
                merkController: _merkController,
              ),
              KategoriSection(
                onChange: (idKategori) {
                  setState(() => _idKategori = idKategori);
                },
              ),
              VariasiSection(
                onChanged: onVariasiChanged,
                addVariasi: addVariasi,
                removeVariasi: _listVariasi.isEmpty ? null : removeVariasi,
                listVariasi: _listVariasi,
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
                isLoading: _isLoading,
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
