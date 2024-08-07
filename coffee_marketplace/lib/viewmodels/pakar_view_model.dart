import 'dart:convert';
import 'dart:developer';

import 'package:coffee_marketplace/models/pakar_model.dart';
import 'package:coffee_marketplace/utils/app_constants.dart';
import 'package:coffee_marketplace/utils/server_status.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PakarViewModel extends ChangeNotifier {
  final _endpoint = "${AppConstants.baseUrl}/api/pakar";

  List<PakarModel> _listPakar = [];
  List<PakarModel> get listPakar => _listPakar;

  ServerStatus _status = ServerStatus.normal;
  ServerStatus get status => _status;

  Future getPakar() async {
    _status = ServerStatus.loading;
    notifyListeners();

    try {
      final response = await http.get(Uri.parse(_endpoint));
      log("Get pakar:\n${response.body}");
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body)["data"] as List;
        _listPakar = data.map((e) => PakarModel.fromJson(e)).toList();

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
