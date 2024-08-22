import 'dart:convert';
import 'dart:developer';

import 'package:coffee_marketplace/models/alamat_model.dart';
import 'package:coffee_marketplace/utils/app_constants.dart';
import 'package:coffee_marketplace/utils/app_helpers.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AlamatViewModel extends ChangeNotifier {
  final _endpoint = "${AppConstants.baseUrl}/api/alamat";
  AlamatModel? selectedAlamat;

  Future<bool> tambahAlamat(AlamatModel alamat) async {
    final token = AppHelpers.token;

    try {
      final response = await http.post(
        Uri.parse(_endpoint),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode({"alamat": alamat.toMap()}),
      );
      log("Tambah alamat:\n${response.body}");

      if (response.statusCode == 201) return true;
    } catch (e) {
      log(e.toString());
    }
    return false;
  }

  Future<bool> updateAlamat(AlamatModel alamat) async {
    final token = AppHelpers.token;

    try {
      final response = await http.put(
        Uri.parse(_endpoint),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode({"alamat": alamat.toMap()}),
      );
      log("Update alamat:\n${response.body}");

      if (response.statusCode == 200) return true;
    } catch (e) {
      log(e.toString());
    }
    return false;
  }

  Future<bool> hapusAlamat(String id) async {
    final token = AppHelpers.token;

    try {
      final response = await http.delete(
        Uri.parse("$_endpoint/$id"),
        headers: {"Authorization": "Bearer $token"},
      );
      log("Hapus alamat:\n${response.body}");

      if (response.statusCode == 200) return true;
    } catch (e) {
      log(e.toString());
    }
    return false;
  }
}
