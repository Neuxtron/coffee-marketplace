import 'package:coffee_marketplace/utils/app_constants.dart';
import 'package:flutter/material.dart';

class AuthLayout extends StatelessWidget {
  final Key formKey;
  final List<Widget> children;
  final String title;

  const AuthLayout({
    super.key,
    required this.formKey,
    required this.children,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: formKey,
            child: Column(
              children: children,
            ),
          ),
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: Text(
        title,
        style: const TextStyle(
          fontFamily: "Abhaya Libre",
          fontWeight: FontWeight.w800,
          fontSize: 18,
        ),
      ),
      surfaceTintColor: Colors.transparent,
      leading: const SizedBox(),
      centerTitle: true,
      elevation: 0,
      backgroundColor: AppConstants.background,
    );
  }
}
