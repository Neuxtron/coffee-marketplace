import 'dart:convert';

class UserModel {
  final String? id;
  final String nama;
  final String email;
  final String noHp;
  final String alamat;
  final String idKecamatan;
  final String? password;

  UserModel({
    this.id,
    required this.nama,
    required this.email,
    required this.noHp,
    required this.alamat,
    required this.idKecamatan,
    this.password,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json["id"],
      nama: json["nama"],
      email: json["email"],
      noHp: json["noHp"],
      alamat: json["alamat"],
      idKecamatan: json["idKecamatan"],
      // TODO: saldo
    );
  }

  String toJson() {
    return jsonEncode({
      "nama": nama,
      "email": email,
      "noHp": noHp,
      "alamat": alamat,
      "idKecamatan": idKecamatan,
      "password": password,
    });
  }
}
