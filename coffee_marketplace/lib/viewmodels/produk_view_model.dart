import 'dart:convert';
import 'dart:developer';

import 'package:coffee_marketplace/models/produk_model.dart';
import 'package:coffee_marketplace/utils/app_constants.dart';
import 'package:coffee_marketplace/utils/server_status.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProdukViewModel extends ChangeNotifier {
  final _endpoint = "${AppConstants.baseUrl}/api/produk";

  List<ProdukModel> _listProduk = [];
  ServerStatus _status = ServerStatus.normal;

  List<ProdukModel> get listProduk => _listProduk;
  ServerStatus get status => _status;

  Future getProduk() async {
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
}
