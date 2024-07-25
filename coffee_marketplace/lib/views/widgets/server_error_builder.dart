import 'package:coffee_marketplace/utils/app_constants.dart';
import 'package:flutter/material.dart';

class ServerErrorBuilder extends StatelessWidget {
  final Function() onRetry;
  final EdgeInsets margin;
  final String text;

  const ServerErrorBuilder({
    super.key,
    required this.onRetry,
    this.margin = const EdgeInsets.only(top: 30),
    this.text = "Terjadi kesalahan, silahkan coba lagi",
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin,
      child: Column(
        children: [
          const Icon(
            Icons.error_outline,
            color: AppConstants.primary,
            size: 30,
          ),
          const SizedBox(height: 10),
          Text(text, textAlign: TextAlign.center),
          MaterialButton(
            onPressed: onRetry,
            color: AppConstants.primary,
            child: const Text(
              "Coba lagi",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
