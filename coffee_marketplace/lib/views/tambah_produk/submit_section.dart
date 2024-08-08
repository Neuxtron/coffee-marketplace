import 'package:coffee_marketplace/utils/app_constants.dart';
import 'package:flutter/material.dart';

class SubmitSection extends StatelessWidget {
  final Function() onSubmit;
  final String error;

  const SubmitSection({
    super.key,
    required this.onSubmit,
    required this.error,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: Column(
        children: [
          Text(
            error,
            style: const TextStyle(color: Colors.red),
          ),
          MaterialButton(
            onPressed: onSubmit,
            minWidth: double.infinity,
            color: AppConstants.primary,
            padding: const EdgeInsets.symmetric(vertical: 10),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(999)),
            child: const Text(
              "+ Tambah",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
