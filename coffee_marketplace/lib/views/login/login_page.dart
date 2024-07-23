import 'package:coffee_marketplace/utils/app_constants.dart';
import 'package:coffee_marketplace/views/widgets/auth_input.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void login() {
    if (_formKey.currentState?.validate() ?? false) {
      // TODO: Process data.
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Processing Data')),
      );
    }
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
    return Scaffold(
      appBar: buildAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 5),
                child: AuthInput(
                  controller: _emailController,
                  validator: emailValidator,
                  hintText: "Email",
                  iconPath: "assets/icons/ic_email.svg",
                ),
              ),
              AuthInput(
                controller: _passwordController,
                validator: passwordValidator,
                hintText: "Password",
                isPassword: true,
                iconPath: "assets/icons/ic_password.svg",
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 50),
                  child: TextButton(
                    onPressed: () {},
                    child: const Text(
                      "Lupa password?",
                      textAlign: TextAlign.right,
                    ),
                  ),
                ),
              ),
              MaterialButton(
                onPressed: login,
                padding: const EdgeInsets.symmetric(vertical: 10),
                color: AppConstants.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(999),
                ),
                child: const Text(
                  "Login",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Belum punya akun?"),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 3,
                      horizontal: 5,
                    ),
                    child: TextButton(
                      onPressed: () {},
                      child: const Text(
                        "Daftar",
                        style: TextStyle(decoration: TextDecoration.underline),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
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
