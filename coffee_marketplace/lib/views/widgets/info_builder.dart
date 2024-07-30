import 'package:coffee_marketplace/utils/app_constants.dart';
import 'package:flutter/material.dart';

class InfoBuilder extends StatelessWidget {
  final Function() onPressed;
  final EdgeInsets margin;
  final String text;
  final IconData iconData;
  final String buttonText;

  const InfoBuilder({
    super.key,
    required this.onPressed,
    this.margin = const EdgeInsets.only(top: 30),
    this.text = "Terjadi kesalahan, silahkan coba lagi",
    required this.iconData,
    this.buttonText = "Coba lagi",
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            iconData,
            color: AppConstants.primary,
            size: 30,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 20),
            child: Text(text, textAlign: TextAlign.center),
          ),
          MaterialButton(
            onPressed: onPressed,
            color: AppConstants.primary,
            child: Text(
              buttonText,
              style: const TextStyle(
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
