import 'package:coffee_marketplace/utils/app_constants.dart';
import 'package:coffee_marketplace/utils/server_status.dart';
import 'package:coffee_marketplace/viewmodels/user_view_model.dart';
import 'package:coffee_marketplace/views/widgets/auth_input/auth_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class UbahPasswordOTPPage extends StatefulWidget {
  const UbahPasswordOTPPage({super.key});

  @override
  State<UbahPasswordOTPPage> createState() => _UbahPasswordOTPPageState();
}

class _UbahPasswordOTPPageState extends State<UbahPasswordOTPPage> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _kPasswordController = TextEditingController();

  String _error = "";

  bool get _isLoading =>
      context.watch<UserViewModel>().status == ServerStatus.loading;

  void ubahPassword() {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    final password = _passwordController.text;
    context.read<UserViewModel>().ubahPasswordOTP(password).then(
      (error) {
        if (error.isEmpty) {
          Navigator.pop(context);
          Fluttertoast.showToast(
            msg: "Password Anda berhsil diubah",
            backgroundColor: Colors.black54,
          );
        } else {
          setState(() => _error = error);
        }
      },
    );
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                const SizedBox(height: 30),
                Center(
                  child: Text(
                    _error,
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
                MaterialButton(
                  onPressed: _isLoading ? null : ubahPassword,
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
                ),
              ],
            ),
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
        "Verifikasi OTP",
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
