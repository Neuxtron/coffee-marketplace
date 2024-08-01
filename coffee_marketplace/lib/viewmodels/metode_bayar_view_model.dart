import 'dart:convert';
import 'dart:developer';

import 'package:coffee_marketplace/models/metode_bayar_model.dart';
import 'package:coffee_marketplace/utils/app_constants.dart';
import 'package:coffee_marketplace/utils/server_status.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MetodeBayarViewModel extends ChangeNotifier {
  final _endpoint = "${AppConstants.baseUrl}/api/metode_bayar";

  List<MetodeBayarModel> _listMetode = [];
  List<MetodeBayarModel> get listMetode => _listMetode;

  ServerStatus _status = ServerStatus.normal;
  ServerStatus get status => _status;

  Future<bool> getMetodeBayar() async {
    _status = ServerStatus.loading;
    notifyListeners();

    try {
      final response = await http.get(Uri.parse(_endpoint));
      log("Get metode pembayaran:\n${response.body}");
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body)["data"] as List;
        _listMetode = data.map((e) => MetodeBayarModel.fromJson(e)).toList();

        _status = ServerStatus.normal;
        notifyListeners();
        return true;
      }
    } catch (e) {
      log(e.toString());
      _status = ServerStatus.error;
      notifyListeners();
    }

    return false;
  }
}
