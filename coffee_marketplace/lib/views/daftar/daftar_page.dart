import 'package:coffee_marketplace/utils/app_constants.dart';
import 'package:coffee_marketplace/views/daftar/daerah_dropdown.dart';
import 'package:coffee_marketplace/views/daftar/daftar_actions.dart';
import 'package:coffee_marketplace/views/layouts/auth_layout.dart';
import 'package:coffee_marketplace/views/widgets/auth_input/auth_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:coffee_marketplace/models/daerah_model.dart';

class DaftarPage extends StatefulWidget {
  const DaftarPage({super.key});

  @override
  State<DaftarPage> createState() => _DaftarPageState();
}

class _DaftarPageState extends State<DaftarPage> {
  final _formKey = GlobalKey<FormState>();
  final _namaController = TextEditingController();
  final _emailController = TextEditingController();
  final _hpController = TextEditingController();
  final _passwordController = TextEditingController();
  final _kPasswordController = TextEditingController();
  final _alamatController = TextEditingController();

  List<DaerahModel> _listProvinsi = dummyProvinsi;
  List<DaerahModel> _listKecamatan = dummyKecamatan;
  String? _idProvinsi;
  String? _idKecamatan;

  void daftar() {
    if (_formKey.currentState?.validate() ?? false) {
      // TODO: Process data.
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Processing Data')),
      );
    }
  }

  String? namaValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Nama tidak boleh kosong';
    }
    return null;
  }

  String? hpValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'No. HP tidak boleh kosong';
    }
    return null;
  }

  String? alamatValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Alamat tidak boleh kosong';
    }
    return null;
  }

  String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email tidak boleh kosong';
    }
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
      return 'Email tidak valid';
    }
    return null;
  }

  String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password tidak boleh kosong';
    }
    if (value.length < 8) {
      return 'Password minimal 8 karakter';
    }
    if (_passwordController.text != _kPasswordController.text) {
      return "Kedua password tidak sama";
    }
    return null;
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AuthLayout(
      formKey: _formKey,
      title: "Daftar",
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: SvgPicture.asset(
            "assets/icons/ic_kopi.svg",
            height: 70,
          ),
        ),
        AuthInput(
          controller: _namaController,
          validator: namaValidator,
          hintText: "Nama",
          icon: SvgPicture.asset("assets/icons/ic_person.svg"),
          keyboardType: TextInputType.name,
        ),
        AuthInput(
          controller: _emailController,
          validator: emailValidator,
          hintText: "Email",
          icon: SvgPicture.asset("assets/icons/ic_email.svg"),
          keyboardType: TextInputType.emailAddress,
        ),
        AuthInput(
          controller: _hpController,
          validator: hpValidator,
          hintText: "No. HP",
          icon: Icon(
            Icons.phone_outlined,
            color: Colors.grey.shade400,
          ),
          keyboardType: TextInputType.phone,
        ),
        AuthInput(
          controller: _passwordController,
          validator: passwordValidator,
          hintText: "Password",
          isPassword: true,
          icon: SvgPicture.asset("assets/icons/ic_password.svg"),
        ),
        AuthInput(
          controller: _kPasswordController,
          validator: passwordValidator,
          hintText: "Ulangi Password",
          isPassword: true,
          icon: SvgPicture.asset("assets/icons/ic_password.svg"),
        ),
        AuthInput(
          controller: _alamatController,
          validator: alamatValidator,
          hintText: "Alamat",
          margin: const EdgeInsets.only(bottom: 20),
          multiline: true,
        ),
        DaerahDropdown(
          onChange: (value) => setState(() => _idProvinsi = value),
          value: _idProvinsi,
          listDaerah: _listProvinsi,
          title: "Provinsi",
        ),
        DaerahDropdown(
          onChange: (value) => setState(() => _idKecamatan = value),
          value: _idKecamatan,
          listDaerah: _listKecamatan,
          title: "Kecamatan",
        ),
        DaftarActions(onDaftar: daftar),
      ],
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: const Text(
        "Daftar",
        style: TextStyle(
          fontFamily: "Abhaya Libre",
          fontWeight: FontWeight.w800,
          fontSize: 18,
        ),
      ),
      leading: const SizedBox(),
      centerTitle: true,
      elevation: 0,
      backgroundColor: AppConstants.background,
    );
  }
}
