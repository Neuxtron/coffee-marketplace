import 'package:coffee_marketplace/utils/app_helpers.dart';
import 'package:flutter/material.dart';

class ProfilPage extends StatelessWidget {
  const ProfilPage({super.key});

  static late BuildContext _context;

  void login() {
    Navigator.pushNamed(_context, "/login");
  }

  void logout() {}

  @override
  Widget build(BuildContext context) {
    _context = context;
    final loggedIn = AppHelpers.token != null;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Logged in as: "),
          ElevatedButton(
            onPressed: loggedIn ? logout : login,
            child: Text(loggedIn ? "logout" : "login"),
          ),
        ],
      ),
    );
  }
}
