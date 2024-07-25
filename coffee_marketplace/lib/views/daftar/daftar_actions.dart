import 'package:coffee_marketplace/utils/app_constants.dart';
import 'package:flutter/material.dart';

class DaftarActions extends StatelessWidget {
  final Function() onDaftar;
  final bool isLoading;

  const DaftarActions({
    super.key,
    required this.onDaftar,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        MaterialButton(
          onPressed: isLoading ? null : onDaftar,
          padding: const EdgeInsets.symmetric(vertical: 8),
          color: AppConstants.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(999),
          ),
          disabledColor: AppConstants.primary.withOpacity(.6),
          child: const Text(
            "Daftar",
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
              "Sudah punya akun?",
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
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  "Login",
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
