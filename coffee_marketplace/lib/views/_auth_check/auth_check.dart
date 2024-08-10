import 'package:coffee_marketplace/utils/server_status.dart';
import 'package:coffee_marketplace/viewmodels/user_view_model.dart';
import 'package:coffee_marketplace/views/_admin/admin_home/admin_home_page.dart';
import 'package:coffee_marketplace/views/layouts/main_layout.dart';
import 'package:coffee_marketplace/views/widgets/info_builder.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthCheck extends StatefulWidget {
  const AuthCheck({super.key});

  @override
  State<AuthCheck> createState() => _AuthCheckState();
}

class _AuthCheckState extends State<AuthCheck> {
  bool _initLoading = true;
  ServerStatus get _status => context.watch<UserViewModel>().status;

  bool get _isAdmin {
    final user = context.watch<UserViewModel>().currentUser;
    if (user == null) return false;
    return user.role == "admin";
  }

  void getData() {
    context.read<UserViewModel>().authCheck().then((_) {
      setState(() => _initLoading = false);
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    if (_initLoading || _status == ServerStatus.loading) {
      return const Scaffold(
        body: Center(
          child: SizedBox(
            height: 30,
            width: 30,
            child: CircularProgressIndicator(),
          ),
        ),
      );
    }

    if (_status == ServerStatus.error) {
      return Scaffold(
        body: Center(
          child: InfoBuilder(
            onPressed: () => context.read<UserViewModel>().getProfile(),
            iconData: Icons.error_outline,
          ),
        ),
      );
    }

    if (_isAdmin) {
      return const AdminHomePage();
    }

    return const MainLayout();
  }
}
