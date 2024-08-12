import 'dart:convert';
import 'dart:developer';

import 'package:coffee_marketplace/models/pengajuan_pakar_model.dart';
import 'package:coffee_marketplace/utils/app_constants.dart';
import 'package:coffee_marketplace/utils/app_helpers.dart';
import 'package:coffee_marketplace/utils/server_status.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PengajuanPakarViewModel extends ChangeNotifier {
  final _endpoint = "${AppConstants.baseUrl}/api/pengajuan_pakar";

  List<PengajuanPakarModel> _listPengajuan = [];
  List<PengajuanPakarModel> get listPengajuan => _listPengajuan;

  ServerStatus _status = ServerStatus.normal;
  ServerStatus get status => _status;

  Future getPengajuan() async {
    _status = ServerStatus.loading;
    notifyListeners();
    final token = AppHelpers.token!;

    try {
      final response = await http.get(
        Uri.parse(_endpoint),
        headers: {
          "Authorization": "Bearer $token",
        },
      );
      log("Get pengajuan pakar:\n${response.body}");
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body)["data"] as List;
        _listPengajuan =
            data.map((e) => PengajuanPakarModel.fromJson(e)).toList();
        _status = ServerStatus.normal;
        notifyListeners();
      } else {
        _status = ServerStatus.error;
        notifyListeners();
      }
    } catch (e) {
      log(e.toString());
      _status = ServerStatus.error;
      notifyListeners();
    }
  }

  Future<bool> createPengajuan(String pesan) async {
    _status = ServerStatus.loading;
    notifyListeners();
    final token = AppHelpers.token!;

    try {
      final response = await http.post(
        Uri.parse(_endpoint),
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json"
        },
        body: jsonEncode({
          "pengajuan": {"pesan": pesan}
        }),
      );
      log("Create pengajuan pakar:\n${response.body}");
      if (response.statusCode == 201) {
        _status = ServerStatus.normal;
        notifyListeners();
        return true;
      }
    } catch (e) {
      log(e.toString());
    }
    _status = ServerStatus.normal;
    notifyListeners();
    return false;
  }
}
