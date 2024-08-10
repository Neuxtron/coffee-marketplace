import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:coffee_marketplace/models/produk_model.dart';
import 'package:coffee_marketplace/models/produk_request_model.dart';
import 'package:coffee_marketplace/utils/app_constants.dart';
import 'package:coffee_marketplace/utils/app_helpers.dart';
import 'package:coffee_marketplace/utils/server_status.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProdukViewModel extends ChangeNotifier {
  final _endpoint = "${AppConstants.baseUrl}/api/produk";

  List<ProdukModel> _listProduk = [];
  ServerStatus _status = ServerStatus.normal;

  List<ProdukModel> get listProduk => _listProduk;
  ServerStatus get status => _status;

  List<ProdukModel> produkByPenjual(String idPenjual) {
    return _listProduk.where((produk) {
      return produk.penjual.id == idPenjual;
    }).toList();
  }

  Future getProduk() async {
    if (_status == ServerStatus.loading) return;
    _status = ServerStatus.loading;
    notifyListeners();

    try {
      final response = await http.get(Uri.parse(_endpoint));
      log("Get produk:\n${response.body}");
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body)["data"] as List;
        _listProduk = data.map((e) => ProdukModel.fromJson(e)).toList();

        _status = ServerStatus.normal;
        notifyListeners();
      }
    } catch (e) {
      log(e.toString());
      _status = ServerStatus.error;
      notifyListeners();
    }
  }

  Future createProduk(ProdukRequestModel produkRequest) async {
    if (_status == ServerStatus.loading) return;
    final token = AppHelpers.token;
    _status = ServerStatus.loading;
    notifyListeners();

    try {
      final response = await http.post(
        Uri.parse(_endpoint),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode({"produk": produkRequest.toMap()}),
      );
      log("Create produk:\n${response.body}");

      if (response.statusCode == 201) {
        final data = jsonDecode(response.body)["data"];
        final upload =
            await uploadGambarProduk(data["id"], produkRequest.gambar!);

        if (upload) {
          _status = ServerStatus.normal;
          notifyListeners();
          getProduk();
          return;
        }
      }
    } catch (e) {
      log(e.toString());
    }
    _status = ServerStatus.error;
    notifyListeners();
  }

  Future<bool> uploadGambarProduk(String idProduk, File gambar) async {
    try {
      final endpoint = "${AppConstants.baseUrl}/api/gambar_produk";
      final token = AppHelpers.token;
      final headers = {"Authorization": "Bearer $token"};
      final fields = {"idProduk": idProduk};

      final request = http.MultipartRequest('POST', Uri.parse(endpoint));
      request.files.add(await http.MultipartFile.fromPath('file', gambar.path));
      request.headers.addAll(headers);
      request.fields.addAll(fields);

      final stream = await request.send();
      final response = await http.Response.fromStream(stream);

      log("Upload gambar produk:\n${response.body}");
      if (response.statusCode == 201) return true;
    } catch (e) {
      log(e.toString());
    }
    return false;
  }

  Future updateProduk(ProdukRequestModel produkRequest) async {
    if (_status == ServerStatus.loading) return;
    final token = AppHelpers.token;
    _status = ServerStatus.loading;
    notifyListeners();

    try {
      final response = await http.put(
        Uri.parse(_endpoint),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode({"produk": produkRequest.toMap()}),
      );
      log("Update produk:\n${response.body}");

      if (response.statusCode == 200) {
        final upload =
            await updateGambarProduk(produkRequest.id!, produkRequest.gambar);

        if (upload) {
          _status = ServerStatus.normal;
          notifyListeners();
          getProduk();
          return;
        }
      }
    } catch (e) {
      log(e.toString());
    }
    _status = ServerStatus.error;
    notifyListeners();
  }

  Future<bool> updateGambarProduk(String idProduk, File? gambar) async {
    if (gambar == null) return true;

    try {
      final endpoint = "${AppConstants.baseUrl}/api/gambar_produk";
      final token = AppHelpers.token;
      final headers = {"Authorization": "Bearer $token"};
      final fields = {"idProduk": idProduk};

      final request = http.MultipartRequest('PUT', Uri.parse(endpoint));
      request.files.add(await http.MultipartFile.fromPath('file', gambar.path));
      request.headers.addAll(headers);
      request.fields.addAll(fields);

      final stream = await request.send();
      final response = await http.Response.fromStream(stream);

      log("Update gambar produk:\n${response.body}");
      if (response.statusCode == 200) return true;
    } catch (e) {
      log(e.toString());
    }
    return false;
  }

  Future hapusProduk(String id) async {
    if (_status == ServerStatus.loading) return;
    final token = AppHelpers.token;
    _status = ServerStatus.loading;
    notifyListeners();

    try {
      final response = await http.delete(
        Uri.parse("$_endpoint/$id"),
        headers: {"Authorization": "Bearer $token"},
      );
      log("Hapus produk:\n${response.body}");

      if (response.statusCode == 200) {
        _status = ServerStatus.normal;
        notifyListeners();
        getProduk();
        return;
      }
    } catch (e) {
      log(e.toString());
    }
    _status = ServerStatus.error;
    notifyListeners();
  }
}
