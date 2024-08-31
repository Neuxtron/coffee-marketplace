import 'dart:convert';
import 'dart:developer';

import 'package:coffee_marketplace/models/daerah_model.dart';
import 'package:coffee_marketplace/models/kurir_model.dart';
import 'package:coffee_marketplace/models/ongkir_model.dart';
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
  // OPTIMIZE: kurir from toko
  List<KurirModel> _listKurir = [];
  List<KurirModel> get listKurir => _listKurir;

  ServerStatus _provinsiStatus = ServerStatus.normal;
  ServerStatus get provinsiStatus => _provinsiStatus;
  ServerStatus _kecamatanStatus = ServerStatus.normal;
  ServerStatus get kecamatanStatus => _kecamatanStatus;
  ServerStatus _ongkirStatus = ServerStatus.normal;
  ServerStatus get ongkirStatus => _ongkirStatus;

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

  Future<bool> getAllOngkir(int berat, String kecamatanPembeli,
      String kecamatanPenjual, List<KurirModel> kurirFromToko) async {
    _ongkirStatus = ServerStatus.loading;
    notifyListeners();
    _listKurir = kurirFromToko;
    final responses = await Future.wait(
      _listKurir.map((kurir) {
        return getOngkir(berat, kurir, kecamatanPembeli, kecamatanPenjual);
      }),
    );
    _ongkirStatus = ServerStatus.normal;
    notifyListeners();
    return !responses.contains(false);
  }

  Future<bool> getOngkir(int berat, KurirModel kurir, String kecamatanPembeli,
      String kecamatanPenjual) async {
    try {
      final response = await http.post(
        Uri.parse("$_endpoint/cost"),
        headers: {
          "key": AppConstants.rajaOngkirKey,
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "origin": kecamatanPenjual,
          "destination": kecamatanPembeli,
          "weight": berat,
          "courier": kurir.id,
        }),
      );
      log("Get ongkir:\n${response.body}");
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body)["rajaongkir"]["results"][0]
            ["costs"] as List;
        List<OngkirModel> listOngkir =
            data.map((e) => OngkirModel.fromJson(e)).toList();

        final index = _listKurir.indexOf(kurir);
        _listKurir[index].listOngkir = listOngkir;
        notifyListeners();
        return true;
      }
    } catch (e) {
      log(e.toString());
    }

    return false;
  }
}
