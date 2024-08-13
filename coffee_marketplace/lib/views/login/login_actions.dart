import 'package:coffee_marketplace/utils/app_constants.dart';
import 'package:flutter/material.dart';

class LoginActions extends StatelessWidget {
  final Function() onLogin;
  final Function() onForgotPassword;
  final bool enabled;

  const LoginActions({
    super.key,
    required this.onLogin,
    required this.enabled,
    required this.onForgotPassword,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 50),
            child: TextButton(
              onPressed: () {
                Navigator.pushNamed(context, "/request_ubah_password");
              },
              child: const Text(
                "Lupa password?",
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontFamily: "Abhaya Libre",
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ),
        MaterialButton(
          onPressed: enabled ? onLogin : null,
          padding: const EdgeInsets.symmetric(vertical: 8),
          color: AppConstants.primary,
          disabledColor: AppConstants.primary.withOpacity(.6),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(999),
          ),
          child: const Text(
            "Login",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w800,
              fontFamily: "Abhaya Libre",
              fontSize: 18,
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Belum punya akun?",
              style: TextStyle(
                fontFamily: "Abhaya Libre",
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 3,
                horizontal: 5,
              ),
              child: TextButton(
                onPressed: () => Navigator.pushNamed(context, "/daftar"),
                child: const Text(
                  "Daftar",
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    fontFamily: "Abhaya Libre",
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
