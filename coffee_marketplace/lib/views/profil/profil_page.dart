import 'package:coffee_marketplace/utils/app_helpers.dart';
import 'package:coffee_marketplace/viewmodels/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilPage extends StatefulWidget {
  const ProfilPage({super.key});

  @override
  State<ProfilPage> createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  bool get _loggedIn => AppHelpers.token != null;
  String get _email => context.watch<UserViewModel>().currentUser?.email ?? "";

  void login() {
    Navigator.pushNamed(context, "/login");
  }

  void logout() {
    context.read<UserViewModel>().logout().then((_) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Logged in as: $_email"),
          ElevatedButton(
            onPressed: _loggedIn ? logout : login,
            child: Text(_loggedIn ? "logout" : "login"),
          ),
        ],
      ),
    );
  }
}
