import 'dart:convert';
import 'dart:developer';

import 'package:coffee_marketplace/models/daerah_model.dart';
import 'package:coffee_marketplace/utils/app_constants.dart';
import 'package:coffee_marketplace/utils/server_status.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DaerahViewModel extends ChangeNotifier {
  final _endpoint = "https://api.rajaongkir.com/starter";

  List<DaerahModel> _listProvinsi = [];
  List<DaerahModel> get listProvinsi => _listProvinsi;
  List<DaerahModel> _listKecamatan = [];
  List<DaerahModel> get listKecamatan => _listKecamatan;

  ServerStatus _provinsiStatus = ServerStatus.normal;
  ServerStatus get provinsiStatus => _provinsiStatus;
  ServerStatus _kecamatanStatus = ServerStatus.normal;
  ServerStatus get kecamatanStatus => _kecamatanStatus;

  int _ongkir = 0;
  int get ongkir => _ongkir;

  Future getProvinsi() async {
    _provinsiStatus = ServerStatus.loading;
    notifyListeners();
    try {
      final response = await http.get(
        Uri.parse("$_endpoint/province"),
        headers: {"key": AppConstants.rajaOngkirKey},
      );
      log("Get provinsi:\n${response.body}");
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body)["rajaongkir"]["results"] as List;
        final listProvinsi =
            data.map((e) => DaerahModel.fromProvinsiJson(e)).toList();
        _listProvinsi = listProvinsi;
        _provinsiStatus = ServerStatus.normal;
        notifyListeners();
      }
    } catch (e) {
      log(e.toString());
      _provinsiStatus = ServerStatus.error;
      notifyListeners();
    }
  }

  Future getKecamatan(String idProvinsi) async {
    _kecamatanStatus = ServerStatus.loading;
    notifyListeners();
    try {
      final response = await http.get(
        Uri.parse("$_endpoint/city?province=$idProvinsi"),
        headers: {"key": AppConstants.rajaOngkirKey},
      );
      log("Get kecamatan:\n${response.body}");
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body)["rajaongkir"]["results"] as List;
        final listKecamatan =
            data.map((e) => DaerahModel.fromKecamatanJson(e)).toList();
        _listKecamatan = listKecamatan;
      }
      _kecamatanStatus = ServerStatus.normal;
      notifyListeners();
    } catch (e) {
      log(e.toString());
      _kecamatanStatus = ServerStatus.error;
      notifyListeners();
    }
  }

  // TODO: get ongkir
  Future getOngkir(int berat, String kurir, String kecamatanPembeli,
      String kecamatanPenjual) async {
    //   final token = AppHelpers.token!;
    //   try {
    //     final response = await http.get(
    //       Uri.parse("$_endpoint/ongkir/jne"),
    //       headers: {
    //         "Authorization": "Bearer $token",
    //       },
    //     );
    //     log("Get ongkir:\n${response.body}");
    //     if (response.statusCode == 200) {
    //       final data = jsonDecode(response.body)["data"];
    //       _ongkir = data["ongkir"];
    //       notifyListeners();
    //     }
    //   } catch (e) {
    //     log(e.toString());
    //   }
  }
}
