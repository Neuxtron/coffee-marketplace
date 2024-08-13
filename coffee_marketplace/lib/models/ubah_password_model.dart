import 'dart:convert';

class UbahPasswordModel {
  final String email;
  int? kodeOTP;
  String? password;

  UbahPasswordModel({
    required this.email,
    this.kodeOTP,
    this.password,
  });

  String toJson() {
    return jsonEncode({
      "email": email,
      "kodeOTP": kodeOTP,
      "password": password,
    });
  }
}
