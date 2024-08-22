import 'package:coffee_marketplace/models/alamat_model.dart';
import 'package:coffee_marketplace/utils/app_constants.dart';
import 'package:coffee_marketplace/utils/server_status.dart';
import 'package:coffee_marketplace/viewmodels/alamat_view_model.dart';
import 'package:coffee_marketplace/viewmodels/daerah_view_model.dart';
import 'package:coffee_marketplace/views/widgets/daerah_dropdown.dart';
import 'package:coffee_marketplace/views/widgets/info_builder.dart';
import 'package:coffee_marketplace/views/widgets/input_item.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class EditAlamatPage extends StatefulWidget {
  const EditAlamatPage({super.key});

  @override
  State<EditAlamatPage> createState() => _EditAlamatPageState();
}

class _EditAlamatPageState extends State<EditAlamatPage> {
  final _formKey = GlobalKey<FormState>();
  final _alamatController = TextEditingController();

  String? _idProvinsi;
  String? _idKecamatan;

  late DaerahViewModel _viewModelWatch;
  late DaerahViewModel _viewModel;

  bool get _isLoading {
    if (_viewModelWatch.provinsiStatus == ServerStatus.loading) return true;
    if (_viewModelWatch.kecamatanStatus == ServerStatus.loading) return true;
    return false;
  }

  bool get _isError {
    if (_viewModel.provinsiStatus == ServerStatus.error) return true;
    if (_viewModel.kecamatanStatus == ServerStatus.error) return true;
    return false;
  }

  void _updateAlamat() {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    final id = context.read<AlamatViewModel>().selectedAlamat!.id;
    final alamat = AlamatModel(
      id: id,
      idKecamatan: _idKecamatan!,
      idProvinsi: _idProvinsi!,
      alamat: _alamatController.text.trim(),
    );
    context
        .read<AlamatViewModel>()
        .updateAlamat(alamat)
        .then(_postUpdateAlamat);
  }

  void _postUpdateAlamat(bool success) {
    if (success) {
      Fluttertoast.showToast(
        msg: "Berhasil mengubah alamat",
        backgroundColor: Colors.black54,
      );
      Navigator.pop(context);
      return;
    }
    Fluttertoast.showToast(
      msg: "Terjadi kesalahan",
      backgroundColor: Colors.black54,
    );
  }

  void _hapusAlamat() {
    final viewModel = context.read<AlamatViewModel>();

    final id = viewModel.selectedAlamat!.id!;
    viewModel.hapusAlamat(id).then(_postHapusAlamat);
  }

  void _postHapusAlamat(bool success) {
    if (success) {
      Fluttertoast.showToast(
        msg: "Berhasil menghapus alamat",
        backgroundColor: Colors.black54,
      );
      Navigator.pop(context);
      return;
    }
    Fluttertoast.showToast(
      msg: "Terjadi kesalahan",
      backgroundColor: Colors.black54,
    );
  }

  void _setProvinsi(String idProvinsi) async {
    setState(() => _idProvinsi = idProvinsi);
    await _viewModel.getKecamatan(idProvinsi);
    if (_viewModel.listKecamatan.isEmpty) return;
    setState(() => _idKecamatan = _viewModel.listKecamatan[0].id);
  }

  void _getData() async {
    final viewModel = context.read<DaerahViewModel>();
    final alamat = context.read<AlamatViewModel>().selectedAlamat;

    _alamatController.text = alamat!.alamat;
    await viewModel.getProvinsi();
    if (viewModel.listProvinsi.isEmpty) return;
    setState(() => _idProvinsi = alamat.idProvinsi);

    await viewModel.getKecamatan(_idProvinsi!);
    if (viewModel.listKecamatan.isEmpty) return;
    setState(() => _idKecamatan = alamat.idKecamatan);
  }

  @override
  void initState() {
    super.initState();
    _getData();
  }

  @override
  void dispose() {
    super.dispose();
    _alamatController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _viewModelWatch = context.watch<DaerahViewModel>();
    _viewModel = context.read<DaerahViewModel>();

    return _PageWrapper(
      children: [
        Form(
          key: _formKey,
          child: InputItem(
            controller: _alamatController,
            label: "Alamat",
            keyboardType: TextInputType.multiline,
            multiline: true,
          ),
        ),
        _DaerahDropDowns(
          onChangeProvinsi: (value) => _setProvinsi(value!),
          onChangeKecamatan: (value) => setState(() => _idKecamatan = value),
          idKecamatan: _idKecamatan,
          idProvinsi: _idProvinsi,
          viewModelWatch: _viewModelWatch,
          isError: _isError,
          errorBuilder: () {
            return InfoBuilder(
              onPressed: _getData,
              margin: const EdgeInsets.only(bottom: 50, top: 30),
              iconData: Icons.error_outline,
              text:
                  "Gagal mengambil data provinsi & kecamatan,\nsilahkan coba lagi",
            );
          },
        ),
        _EditActions(
          enabled: !_isLoading && !_isError,
          submitEdit: _updateAlamat,
          submitHapus: _hapusAlamat,
        ),
      ],
    );
  }
}

class _PageWrapper extends StatelessWidget {
  final List<Widget> children;
  const _PageWrapper({required this.children});

  AppBar _buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: AppConstants.background,
      title: const Text(
        "Edit Alamat",
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: children,
          ),
        ),
      ),
    );
  }
}

class _DaerahDropDowns extends StatelessWidget {
  final Function(String? value) onChangeProvinsi;
  final Function(String? value) onChangeKecamatan;
  final Widget Function() errorBuilder;
  final String? idProvinsi;
  final String? idKecamatan;
  final DaerahViewModel viewModelWatch;
  final bool isError;

  const _DaerahDropDowns({
    required this.onChangeProvinsi,
    required this.onChangeKecamatan,
    required this.viewModelWatch,
    required this.idProvinsi,
    required this.idKecamatan,
    required this.isError,
    required this.errorBuilder,
  });

  @override
  Widget build(BuildContext context) {
    if (isError) {
      return errorBuilder();
    }

    return Column(
      children: [
        DaerahDropdown(
          onChange: onChangeProvinsi,
          value: idProvinsi,
          listDaerah: viewModelWatch.listProvinsi,
          title: "Provinsi",
          isLoading: viewModelWatch.provinsiStatus == ServerStatus.loading,
        ),
        DaerahDropdown(
          onChange: onChangeKecamatan,
          value: idKecamatan,
          listDaerah: viewModelWatch.listKecamatan,
          title: "Kecamatan",
          show: viewModelWatch.provinsiStatus == ServerStatus.normal,
          isLoading: viewModelWatch.kecamatanStatus == ServerStatus.loading,
        ),
      ],
    );
  }
}

class _EditActions extends StatelessWidget {
  final Function() submitEdit;
  final Function() submitHapus;
  final bool enabled;

  const _EditActions({
    required this.submitEdit,
    required this.enabled,
    required this.submitHapus,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildUpdateButton(),
        _buildHapusButton(enabled),
      ],
    );
  }

  Widget _buildHapusButton(bool enabled) {
    if (!enabled) return const SizedBox();
    return Column(
      children: [
        const Divider(
          color: Colors.black12,
          height: 30,
        ),
        TextButton(
          onPressed: submitHapus,
          style: ButtonStyle(
            overlayColor: WidgetStatePropertyAll(Colors.red.withOpacity(.1)),
          ),
          child: const Text(
            "Hapus Alamat",
            style: TextStyle(color: Colors.red),
          ),
        ),
      ],
    );
  }

  MaterialButton _buildUpdateButton() {
    return MaterialButton(
      onPressed: enabled ? submitEdit : null,
      padding: const EdgeInsets.symmetric(vertical: 8),
      color: AppConstants.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(999),
      ),
      disabledColor: AppConstants.primary.withOpacity(.6),
      child: const Text(
        "Update",
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w800,
          fontFamily: "Abhaya Libre",
          fontSize: 18,
        ),
      ),
    );
  }
}
