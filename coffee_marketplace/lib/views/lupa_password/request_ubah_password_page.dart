import 'package:coffee_marketplace/utils/app_constants.dart';
import 'package:coffee_marketplace/utils/server_status.dart';
import 'package:coffee_marketplace/viewmodels/user_view_model.dart';
import 'package:coffee_marketplace/views/widgets/input_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RequestUbahPasswordPage extends StatefulWidget {
  const RequestUbahPasswordPage({super.key});

  @override
  State<RequestUbahPasswordPage> createState() =>
      _RequestUbahPasswordPageState();
}

class _RequestUbahPasswordPageState extends State<RequestUbahPasswordPage> {
  final _emailController = TextEditingController();

  String _error = "";

  bool get _isLoading =>
      context.watch<UserViewModel>().status == ServerStatus.loading;

  void requestUbahPassword() {
    final email = _emailController.text.trim();
    context.read<UserViewModel>().requestUbahPassword(email).then(
      (error) {
        if (error.isEmpty) {
          Navigator.pushReplacementNamed(context, "/check_otp");
        } else {
          setState(() => _error = error);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InputItem(
                label: "Masukkan email Anda:",
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
              ),
              Center(
                child: Text(
                  _error,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
              MaterialButton(
                onPressed: _isLoading ? null : requestUbahPassword,
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
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: AppConstants.background,
      title: const Text(
        "Reset Password",
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
