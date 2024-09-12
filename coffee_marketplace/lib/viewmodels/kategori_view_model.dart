import 'dart:convert';
import 'dart:developer';

import 'package:coffee_marketplace/models/kategori_model.dart';
import 'package:coffee_marketplace/utils/app_constants.dart';
import 'package:coffee_marketplace/utils/server_status.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class KategoriViewModel extends ChangeNotifier {
  final _endpoint = "${AppConstants.baseUrl}/api/kategori";

  List<KategoriModel> _listKategori = [];
  List<KategoriModel> get listKategori => _listKategori;

  ServerStatus _status = ServerStatus.normal;
  ServerStatus get status => _status;

  Future getKategori() async {
    _status = ServerStatus.loading;
    notifyListeners();

    try {
      final response = await http.get(Uri.parse(_endpoint));
      log("Get kategori (${response.statusCode}):\n${response.body}");
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body)["data"] as List;
        _listKategori = data.map((e) => KategoriModel.fromJson(e)).toList();

        _status = ServerStatus.normal;
        notifyListeners();
        return;
      }
      _status = ServerStatus.error;
      notifyListeners();
    } catch (e) {
      log(e.toString());
      _status = ServerStatus.error;
      notifyListeners();
    }
  }
}
