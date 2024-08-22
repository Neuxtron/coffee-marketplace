import 'package:coffee_marketplace/utils/app_constants.dart';
import 'package:coffee_marketplace/viewmodels/alamat_view_model.dart';
import 'package:coffee_marketplace/viewmodels/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:coffee_marketplace/models/alamat_model.dart';
import 'package:provider/provider.dart';

class PengaturanAkunPage extends StatelessWidget {
  const PengaturanAkunPage({super.key});

  AppBar _buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: AppConstants.background,
      title: const Text(
        "Pengaturan Akun",
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: const Column(
        children: [
          _PengaturanAlamat(),
        ],
      ),
    );
  }
}

class _PengaturanAlamat extends StatefulWidget {
  const _PengaturanAlamat();

  @override
  State<_PengaturanAlamat> createState() => _PengaturanAlamatState();
}

class _PengaturanAlamatState extends State<_PengaturanAlamat> {
  bool _isExpanded = false;

  List<AlamatModel> get _listAlamat =>
      context.watch<UserViewModel>().currentUser!.alamat;

  Divider get _divider {
    return const Divider(
      color: Colors.black12,
      indent: 30,
      endIndent: 30,
      height: 1,
    );
  }

  void _tambahAlamat() {
    Navigator.pushNamed(context, "/tambah_alamat").then((_) {
      context.read<UserViewModel>().getProfile();
    });
  }

  void _editAlamat(AlamatModel alamat) {
    context.read<AlamatViewModel>().selectedAlamat = alamat;
    Navigator.pushNamed(context, "/edit_alamat").then(_postEditAlamat);
  }

  void _postEditAlamat(_) {
    context.read<UserViewModel>().getProfile();
    context.read<AlamatViewModel>().selectedAlamat = null;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildTitle(),
        _buildListView(),
        _buildTambahAlamat(),
        const Divider(
          color: Colors.black26,
          indent: 10,
          endIndent: 10,
        ),
      ],
    );
  }

  Widget _buildTambahAlamat() {
    if (!_isExpanded) return const SizedBox();
    return Padding(
      padding: const EdgeInsets.only(top: 5, bottom: 20),
      child: TextButton(
        onPressed: _tambahAlamat,
        child: const Text(
          "+ Tambah alamat",
          style: TextStyle(fontSize: 12),
        ),
      ),
    );
  }

  InkWell _buildTitle() {
    return InkWell(
      onTap: () => setState(() => _isExpanded = !_isExpanded),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        child: Row(
          children: [
            const Icon(Icons.location_on),
            const SizedBox(width: 10),
            const Text(
              "Alamat Saya",
              style: TextStyle(
                fontFamily: "Abhaya Libre",
                fontWeight: FontWeight.w800,
                fontSize: 18,
              ),
            ),
            const Expanded(child: SizedBox()),
            Icon(
              _isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListView() {
    if (!_isExpanded) return const SizedBox();
    return Column(
      children: [
        _divider,
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _listAlamat.length,
          itemBuilder: (context, index) {
            final alamat = _listAlamat[index];
            return _buildAlamatItem(alamat);
          },
        ),
        _divider,
      ],
    );
  }

  Widget _buildAlamatItem(AlamatModel alamat) {
    return InkWell(
      onTap: () => _editAlamat(alamat),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(alamat.alamat),
            const Icon(
              Icons.keyboard_arrow_right,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
