import 'package:coffee_marketplace/models/kategori_model.dart';
import 'package:coffee_marketplace/utils/app_constants.dart';
import 'package:coffee_marketplace/viewmodels/kategori_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class KategoriSection extends StatefulWidget {
  final Function(String idKategori) onChange;
  final String? defaultKategori;

  const KategoriSection({
    super.key,
    required this.onChange,
    this.defaultKategori,
  });

  @override
  State<KategoriSection> createState() => _KategoriSectionState();
}

class _KategoriSectionState extends State<KategoriSection> {
  String? _idKategori;

  List<KategoriModel> get _listKategori =>
      context.watch<KategoriViewModel>().listKategori;

  void getData() {
    final viewModel = context.read<KategoriViewModel>();
    if (widget.defaultKategori != null) {
      _idKategori = widget.defaultKategori!;
      widget.onChange(_idKategori!);
      return;
    }
    _idKategori = viewModel.listKategori[0].id;
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Kategori:",
          style: TextStyle(fontSize: 12),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
            color: AppConstants.secondary.withOpacity(.5),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppConstants.secondaryAlt),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton(
              value: _idKategori,
              onChanged: (value) {
                setState(() => _idKategori = value);
                widget.onChange(_idKategori!);
              },
              items: _listKategori.map((kategori) {
                return DropdownMenuItem(
                  value: kategori.id,
                  child: Text(
                    kategori.nama,
                    style: const TextStyle(fontSize: 14),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
        const SizedBox(height: 30),
      ],
    );
  }
}
