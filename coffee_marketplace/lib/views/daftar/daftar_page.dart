import 'package:coffee_marketplace/models/alamat_model.dart';
import 'package:coffee_marketplace/models/user_model.dart';
import 'package:coffee_marketplace/utils/app_constants.dart';
import 'package:coffee_marketplace/utils/server_status.dart';
import 'package:coffee_marketplace/viewmodels/daerah_view_model.dart';
import 'package:coffee_marketplace/viewmodels/user_view_model.dart';
import 'package:coffee_marketplace/views/widgets/daerah_dropdown.dart';
import 'package:coffee_marketplace/views/daftar/daftar_actions.dart';
import 'package:coffee_marketplace/views/layouts/auth_layout.dart';
import 'package:coffee_marketplace/views/widgets/auth_input/auth_input.dart';
import 'package:coffee_marketplace/views/widgets/info_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class DaftarPage extends StatefulWidget {
  const DaftarPage({super.key});

  @override
  State<DaftarPage> createState() => _DaftarPageState();
}

class _DaftarPageState extends State<DaftarPage> {
  final _formKey = GlobalKey<FormState>();
  final _namaController = TextEditingController();
  final _emailController = TextEditingController();
  final _noHpController = TextEditingController();
  final _passwordController = TextEditingController();
  final _kPasswordController = TextEditingController();
  final _alamatController = TextEditingController();
  final _scrollController = ScrollController();

  String? _idProvinsi;
  String? _idKecamatan;
  String get _error => context.watch<UserViewModel>().error;
  DaerahViewModel get _viewModel => context.read<DaerahViewModel>();
  DaerahViewModel get _viewModelWatch => context.watch<DaerahViewModel>();

  bool get _isLoading {
    if (_viewModelWatch.provinsiStatus == ServerStatus.loading) return true;
    if (_viewModelWatch.kecamatanStatus == ServerStatus.loading) return true;
    if (context.watch<UserViewModel>().status == ServerStatus.loading) {
      return true;
    }
    return false;
  }

  bool get _isError {
    if (_viewModel.provinsiStatus == ServerStatus.error) return true;
    if (_viewModel.kecamatanStatus == ServerStatus.error) return true;
    return false;
  }

  void daftar() {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    final alamat = AlamatModel(
      idKecamatan: _idKecamatan!,
      idProvinsi: _idProvinsi!,
      alamat: _alamatController.text.trim(),
    );
    final user = UserModel(
      nama: _namaController.text.trim(),
      email: _emailController.text.trim(),
      noHp: _noHpController.text,
      alamat: [alamat],
      password: _passwordController.text,
    );
    context.read<UserViewModel>().register(user).then((_) {
      if (context.read<UserViewModel>().status == ServerStatus.normal) {
        Navigator.pop(context);
        Navigator.pop(context);
        return;
      }
      _scrollController.jumpTo(0);
    });
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

  void setProvinsi(String idProvinsi) async {
    setState(() => _idProvinsi = idProvinsi);
    await _viewModel.getKecamatan(idProvinsi);
    if (_viewModel.listKecamatan.isEmpty) return;
    setState(() => _idKecamatan = _viewModel.listKecamatan[0].id);
  }

  void getData() async {
    await _viewModel.getProvinsi();
    if (_viewModel.listProvinsi.isEmpty) return;
    setState(() => _idProvinsi = _viewModel.listProvinsi[0].id);

    await _viewModel.getKecamatan(_idProvinsi!);
    if (_viewModel.listKecamatan.isEmpty) return;
    setState(() => _idKecamatan = _viewModel.listKecamatan[0].id);
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  void dispose() {
    super.dispose();
    _namaController.dispose();
    _emailController.dispose();
    _noHpController.dispose();
    _passwordController.dispose();
    _kPasswordController.dispose();
    _alamatController.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AuthLayout(
      formKey: _formKey,
      scrollController: _scrollController,
      title: "Daftar",
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: SvgPicture.asset(
            "assets/icons/ic_kopi.svg",
            height: 70,
          ),
        ),
        Text(
          _error,
          style: const TextStyle(color: Colors.red),
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
          controller: _noHpController,
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
        !_isError
            ? Column(
                children: [
                  DaerahDropdown(
                    onChange: (value) => setProvinsi(value!),
                    value: _idProvinsi,
                    listDaerah: _viewModelWatch.listProvinsi,
                    title: "Provinsi",
                    isLoading:
                        _viewModelWatch.provinsiStatus == ServerStatus.loading,
                  ),
                  DaerahDropdown(
                    onChange: (value) => setState(() => _idKecamatan = value),
                    value: _idKecamatan,
                    listDaerah: _viewModelWatch.listKecamatan,
                    title: "Kecamatan",
                    show: _viewModelWatch.provinsiStatus == ServerStatus.normal,
                    isLoading:
                        _viewModelWatch.kecamatanStatus == ServerStatus.loading,
                  ),
                ],
              )
            : InfoBuilder(
                onPressed: getData,
                margin: const EdgeInsets.only(bottom: 50, top: 30),
                iconData: Icons.error_outline,
                text:
                    "Gagal mengambil data provinsi & kecamatan,\nsilahkan coba lagi",
              ),
        DaftarActions(
          onDaftar: daftar,
          enabled: !_isLoading && !_isError,
        ),
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
