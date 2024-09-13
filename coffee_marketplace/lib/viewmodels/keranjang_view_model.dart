import 'dart:convert';
import 'dart:developer';

import 'package:coffee_marketplace/models/keranjang_model.dart';
import 'package:coffee_marketplace/utils/app_constants.dart';
import 'package:coffee_marketplace/utils/app_helpers.dart';
import 'package:coffee_marketplace/utils/server_status.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class KeranjangViewModel extends ChangeNotifier {
  final _endpoint = "${AppConstants.baseUrl}/api/keranjang";

  List<KeranjangModel> _listKeranjang = [];
  List<KeranjangModel> get listKeranjang => _listKeranjang;
  List<KeranjangModel> get listCheckout {
    return _listKeranjang.where((keranjang) {
      return keranjang.isChecked;
    }).toList();
  }

  ServerStatus _status = ServerStatus.normal;
  ServerStatus get status => _status;

  void onLogout() {
    _listKeranjang = [];
  }

  void setAmount(String id, int amount) {
    final index = _listKeranjang.indexWhere((keranjang) {
      return keranjang.id == id;
    });

    _listKeranjang[index].amount = amount;
    notifyListeners();
  }

  void setChecked(String id, bool isChecked) {
    final index = _listKeranjang.indexWhere((keranjang) {
      return keranjang.id == id;
    });

    _listKeranjang[index].isChecked = isChecked;
    notifyListeners();
  }

  Future getKeranjang({bool notify = true}) async {
    _status = ServerStatus.loading;
    if (notify) notifyListeners();
    final token = AppHelpers.token!;

    try {
      final response = await http.get(
        Uri.parse(_endpoint),
        headers: {
          "Authorization": "Bearer $token",
        },
      );
      log("Get keranjang:\n${response.body}");
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body)["data"] as List;
        _listKeranjang = data.map((e) => KeranjangModel.fromJson(e)).toList();
        _status = ServerStatus.normal;
        notifyListeners();
      } else {
        _status = ServerStatus.error;
        if (notify) notifyListeners();
      }
    } catch (e) {
      log(e.toString());
      _status = ServerStatus.error;
      if (notify) notifyListeners();
    }
  }

  Future<bool> updateKeranjang({KeranjangModel? keranjang}) async {
    List mapKeranjang = _listKeranjang.map((e) => e.toMap()).toList();
    if (keranjang != null) mapKeranjang = [keranjang.toMap()];
    final token = AppHelpers.token!;

    try {
      final response = await http.put(
        Uri.parse(_endpoint),
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
        body: jsonEncode(mapKeranjang),
      );
      log("Update keranjang:\n${response.body}");
      if (response.statusCode != 200) {
        final message = jsonDecode(response.body)["message"];
        log(message);
        return false;
      }
      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  Future hapusKeranang(String id) async {
    final token = AppHelpers.token!;

    try {
      final response = await http.delete(
        Uri.parse("$_endpoint/$id"),
        headers: {"Authorization": "Bearer $token"},
      );
      log("Hapus keranjang:\n${response.body}");
      if (response.statusCode == 200) {
        _listKeranjang.removeWhere((keranjang) {
          return keranjang.id == id;
        });
        notifyListeners();
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
