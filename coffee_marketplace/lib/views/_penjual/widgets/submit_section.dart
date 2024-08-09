import 'package:coffee_marketplace/utils/app_constants.dart';
import 'package:flutter/material.dart';

class SubmitSection extends StatelessWidget {
  final Function() onSubmit;
  final String error;
  final String text;

  const SubmitSection({
    super.key,
    required this.onSubmit,
    required this.error,
    required this.text,
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
            padding: const EdgeInsets.symmetric(vertical: 8),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(999)),
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w800,
                fontFamily: "Abhaya Libre",
              ),
            ),
          ),
        ],
      ),
    );
  }
}
