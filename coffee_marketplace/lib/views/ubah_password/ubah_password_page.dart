import 'package:coffee_marketplace/utils/app_constants.dart';
import 'package:coffee_marketplace/utils/server_status.dart';
import 'package:coffee_marketplace/viewmodels/user_view_model.dart';
import 'package:coffee_marketplace/views/widgets/auth_input/auth_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class UbahPasswordPage extends StatefulWidget {
  const UbahPasswordPage({super.key});

  @override
  State<UbahPasswordPage> createState() => _UbahPasswordPageState();
}

class _UbahPasswordPageState extends State<UbahPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _passwordLamaController = TextEditingController();
  final _passwordController = TextEditingController();
  final _kPasswordController = TextEditingController();

  String _error = "";

  bool get _isLoading =>
      context.watch<UserViewModel>().status == ServerStatus.loading;

  void _ubahPassword() {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    final passwordLama = _passwordLamaController.text;
    final password = _passwordController.text;
    context.read<UserViewModel>().ubahPassword(passwordLama, password).then(
      (error) {
        if (error == null) {
          Navigator.pop(context);
          Fluttertoast.showToast(
            msg: "Password Anda berhasil diubah",
            backgroundColor: Colors.black54,
          );
        } else {
          setState(() => _error = error);
        }
      },
    );
  }

  String? _passwordLamaValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password lama tidak boleh kosong';
    }
    if (value.length < 8) {
      return 'Password minimal 8 karakter';
    }
    return null;
  }

  String? _passwordValidator(String? value) {
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

  AppBar _buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: AppConstants.background,
      title: const Text(
        "Ubah Password",
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
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _FormSection(
                  passwordLamaController: _passwordLamaController,
                  passwordController: _passwordController,
                  kPasswordController: _kPasswordController,
                  passwordLamaValidator: _passwordLamaValidator,
                  passwordValidator: _passwordValidator,
                ),
                const SizedBox(height: 30),
                Text(
                  _error,
                  style: const TextStyle(color: Colors.red),
                ),
                _SubmitButton(
                  isLoading: _isLoading,
                  ubahPassword: _ubahPassword,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _FormSection extends StatelessWidget {
  final TextEditingController passwordLamaController;
  final TextEditingController passwordController;
  final TextEditingController kPasswordController;
  final String? Function(String? valuae) passwordLamaValidator;
  final String? Function(String? valuae) passwordValidator;

  const _FormSection({
    required this.passwordLamaController,
    required this.passwordController,
    required this.kPasswordController,
    required this.passwordLamaValidator,
    required this.passwordValidator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AuthInput(
          controller: passwordLamaController,
          validator: passwordLamaValidator,
          hintText: "Password Lama",
          isPassword: true,
          icon: SvgPicture.asset("assets/icons/ic_password.svg"),
        ),
        AuthInput(
          controller: passwordController,
          validator: passwordValidator,
          hintText: "Password Baru",
          isPassword: true,
          icon: SvgPicture.asset("assets/icons/ic_password.svg"),
        ),
        AuthInput(
          controller: kPasswordController,
          validator: passwordValidator,
          hintText: "Ulangi Password Baru",
          isPassword: true,
          icon: SvgPicture.asset("assets/icons/ic_password.svg"),
        ),
      ],
    );
  }
}

class _SubmitButton extends StatelessWidget {
  final bool isLoading;
  final Function() ubahPassword;

  const _SubmitButton({
    required this.isLoading,
    required this.ubahPassword,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: isLoading ? null : ubahPassword,
      color: AppConstants.primary,
      padding: const EdgeInsets.symmetric(vertical: 7),
      disabledColor: AppConstants.primary.withOpacity(.6),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(999),
      ),
      minWidth: double.infinity,
      child: const Text(
        "Submit",
        style: TextStyle(
          fontFamily: "Abhaya Libre",
          fontSize: 18,
          fontWeight: FontWeight.w800,
          color: Colors.white,
        ),
      ),
    );
  }
}
