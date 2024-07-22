import 'package:coffee_marketplace/utils/app_constants.dart';
import 'package:flutter/material.dart';

class ServerErrorBuilder extends StatelessWidget {
  final Function() onRetry;
  const ServerErrorBuilder({super.key, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 30, bottom: 10),
            child: Icon(
              Icons.error_outline,
              color: AppConstants.primary,
              size: 30,
            ),
          ),
          const Text("Terjadi kesalahan, silahkan coba lagi"),
          MaterialButton(
            onPressed: onRetry,
            color: AppConstants.primary,
            child: const Text(
              "Coba lagi",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
