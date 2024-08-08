import 'package:flutter/material.dart';

class PengaturanTokoPage extends StatelessWidget {
  const PengaturanTokoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(context, "/", (route) => false);
          },
          child: Text("Kembali ke marketplace"),
        ),
      ),
    );
  }
}
