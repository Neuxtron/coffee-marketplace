import 'dart:convert';
import 'dart:developer';

import 'package:coffee_marketplace/models/keranjang_model.dart';
import 'package:coffee_marketplace/models/produk_model.dart';
import 'package:coffee_marketplace/models/variasi_model.dart';
import 'package:coffee_marketplace/utils/app_constants.dart';
import 'package:coffee_marketplace/utils/app_helpers.dart';
import 'package:coffee_marketplace/utils/server_status.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class KeranjangViewModel extends ChangeNotifier {
  final _endpoint = "${AppConstants.baseUrl}/keranjang";

  // TODO: remove comment
  // ignore: prefer_final_fields
  List<KeranjangModel> _listKeranjang = [
    KeranjangModel(
      id: "1",
      produk: dummyProduk,
      variasi: VariasiModel(id: "1", nama: "Biji Kopi", stok: 999),
    ),
    KeranjangModel(
      id: "2",
      produk: dummyProduk,
      variasi: VariasiModel(id: "1", nama: "Biji Kopi", stok: 999),
    ),
    KeranjangModel(
      id: "3",
      produk: dummyProduk,
      variasi: VariasiModel(id: "1", nama: "Biji Kopi", stok: 999),
    ),
    KeranjangModel(
      id: "4",
      produk: dummyProduk,
      variasi: VariasiModel(id: "1", nama: "Biji Kopi", stok: 999),
    ),
  ];

  // List<KeranjangModel> _listKeranjang = [];

  List<KeranjangModel> get listKeranjang => _listKeranjang;

  ServerStatus _status = ServerStatus.normal;
  ServerStatus get status => _status;

  void setAmount(String id, int amount) {
    final index = _listKeranjang.indexWhere((keranjang) {
      return keranjang.id == id;
    });

    // TODO: amount from api response
    _listKeranjang[index].amount = amount;
    notifyListeners();
  }

  Future getKeranjang() async {
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
        notifyListeners();
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future updateKeranjang({KeranjangModel? keranjang}) async {
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
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
