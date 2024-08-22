import 'dart:convert';

import 'package:coffee_marketplace/models/alamat_model.dart';

class UserModel {
  final String? id;
  final String nama;
  final String email;
  final String noHp;
  final List<AlamatModel> alamat;
  final String? password;
  final int saldo;
  final String role;
  final bool? terkonfirmasi;

  UserModel({
    this.id,
    required this.nama,
    required this.email,
    required this.noHp,
    required this.alamat,
    this.role = "pelanggan",
    this.saldo = 0,
    this.password,
    this.terkonfirmasi,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    final alamat = json["alamat"] as List;

    return UserModel(
      id: json["id"],
      nama: json["nama"],
      email: json["email"],
      noHp: json["noHp"],
      alamat: alamat.map((e) => AlamatModel.fromJson(e)).toList(),
      saldo: json["saldo"],
      role: json["role"],
      terkonfirmasi: json["terkonfirmasi"],
    );
  }

  String toJson() {
    return jsonEncode({
      "nama": nama,
      "email": email,
      "noHp": noHp,
      "alamat": alamat.map((e) => e.toMap()).toList(),
      "password": password,
    });
  }
}
