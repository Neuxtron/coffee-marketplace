import 'package:flutter/material.dart';

class LogoutSection extends StatelessWidget {
  final Function() logout;
  const LogoutSection({super.key, required this.logout});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 40),
        Divider(
          color: Colors.grey.shade400,
          thickness: 1,
          indent: 30,
          endIndent: 30,
        ),
        TextButton(
          onPressed: logout,
          style: ButtonStyle(
            padding: const WidgetStatePropertyAll(
              EdgeInsets.symmetric(horizontal: 50),
            ),
            overlayColor: WidgetStatePropertyAll(Colors.red.withOpacity(.1)),
          ),
          child: const Text(
            "Logout",
            style: TextStyle(color: Colors.red),
          ),
        ),
      ],
    );
  }
}
