import 'package:coffee_marketplace/utils/app_constants.dart';
import 'package:coffee_marketplace/utils/server_status.dart';
import 'package:coffee_marketplace/viewmodels/pesan_view_model.dart';
import 'package:coffee_marketplace/viewmodels/user_view_model.dart';
import 'package:coffee_marketplace/views/layouts/auth_layout.dart';
import 'package:coffee_marketplace/views/login/login_actions.dart';
import 'package:coffee_marketplace/views/widgets/auth_input/auth_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  String get _error => context.watch<UserViewModel>().error;
  bool get _isLoading {
    return context.watch<UserViewModel>().status == ServerStatus.loading;
  }

  void login() {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    context
        .read<UserViewModel>()
        .login(_emailController.text.trim(), _passwordController.text)
        .then((_) {
      if (context.read<UserViewModel>().status != ServerStatus.error) {
        context.read<PesanViewModel>().onInit();
        Navigator.pop(context);
      }
    });
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
      title: "Masuk",
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
          controller: _emailController,
          validator: emailValidator,
          hintText: "Email",
          icon: SvgPicture.asset("assets/icons/ic_email.svg"),
          keyboardType: TextInputType.emailAddress,
        ),
        AuthInput(
          controller: _passwordController,
          validator: passwordValidator,
          hintText: "Password",
          isPassword: true,
          icon: SvgPicture.asset("assets/icons/ic_password.svg"),
          margin: EdgeInsets.zero,
        ),
        LoginActions(
          onLogin: login,
          enabled: !_isLoading,
        ),
      ],
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: const Text(
        "Masuk",
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
