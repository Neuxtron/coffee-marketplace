import 'dart:convert';
import 'dart:developer';

import 'package:coffee_marketplace/models/order_model.dart';
import 'package:coffee_marketplace/models/pembayaran_model.dart';
import 'package:coffee_marketplace/models/riwayat_pengiriman_model.dart';
import 'package:coffee_marketplace/utils/app_constants.dart';
import 'package:coffee_marketplace/utils/app_helpers.dart';
import 'package:coffee_marketplace/utils/server_status.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class OrderViewModel extends ChangeNotifier {
  final _endpoint = "${AppConstants.baseUrl}/api/order";

  ServerStatus _status = ServerStatus.normal;
  List<OrderModel> _listRiwayat = [];
  List<OrderModel> _listPesananPenjual = [];

  ServerStatus get status => _status;
  List<OrderModel> get listRiwayat => _listRiwayat;
  List<OrderModel> get listPesananPenjual => _listPesananPenjual;

  List<OrderModel> get listPending {
    return _listRiwayat.where((riwayat) {
      return riwayat.status == "pending";
    }).toList();
  }

  List<OrderModel> get listDikemas {
    return _listRiwayat.where((riwayat) {
      return riwayat.status == "settlement";
    }).toList();
  }

  List<OrderModel> get listDikirim {
    return _listRiwayat.where((riwayat) {
      final listStatus = ["dikirim", "diterima"];
      return listStatus.contains(riwayat.status);
    }).toList();
  }

  List<OrderModel> get listSelesai {
    return _listRiwayat.where((riwayat) {
      final listStatus = ["selesai", "deny", "cancel", "expire"];
      return listStatus.contains(riwayat.status);
    }).toList();
  }

  void onLogout() {
    _listPesananPenjual = [];
  }

  Future<OrderModel?> createOrder(PembayaranModel pembayaran) async {
    _status = ServerStatus.loading;
    notifyListeners();

    final mapKeranjang =
        pembayaran.listKeranjang.map((e) => e.toMap()).toList();
    final token = AppHelpers.token;

    try {
      final response = await http.post(
        Uri.parse(_endpoint),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode({
          "order": pembayaran.order,
          "keranjang": mapKeranjang,
        }),
      );
      log("Create order:\n${response.body}");
      final data = jsonDecode(response.body)["data"];

      _status = ServerStatus.normal;
      notifyListeners();
      return OrderModel.fromJson(data);
    } catch (e) {
      log(e.toString());
      _status = ServerStatus.normal;
      notifyListeners();
      return null;
    }
  }

  Future getRiwayat() async {
    final token = AppHelpers.token;
    _status = ServerStatus.loading;
    notifyListeners();

    try {
      final response = await http.get(
        Uri.parse(_endpoint),
        headers: {"Authorization": "Bearer $token"},
      );
      log("Get riwayat:\n${response.body}");
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body)["data"] as List;
        _listRiwayat = data.map((e) => OrderModel.fromJson(e)).toList();
        _status = ServerStatus.normal;
        notifyListeners();
        return;
      }
    } catch (e) {
      log(e.toString());
    }
    _status = ServerStatus.error;
    notifyListeners();
  }

  Future getPesananPenjual() async {
    final token = AppHelpers.token;
    _status = ServerStatus.loading;
    notifyListeners();

    try {
      final response = await http.get(
        Uri.parse("$_endpoint/pesanan_penjual"),
        headers: {"Authorization": "Bearer $token"},
      );
      log("Get pesanan penjual:\n${response.body}");
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body)["data"] as List;
        _listPesananPenjual = data.map((e) => OrderModel.fromJson(e)).toList();
        _status = ServerStatus.normal;
        notifyListeners();
        return;
      }
    } catch (e) {
      log(e.toString());
    }
    _status = ServerStatus.error;
    notifyListeners();
  }

  Future<bool> nextStatus(
    String id, {
    String? status,
    String? resiPengiriman,
  }) async {
    final token = AppHelpers.token;

    try {
      final response = await http.put(
        Uri.parse("$_endpoint/status"),
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "id": id,
          "status": status,
          "resi": resiPengiriman,
        }),
      );
      log("Next status:\n${response.body}");
      if (response.statusCode == 200) return true;
    } catch (e) {
      log(e.toString());
    }
    return false;
  }

  Future<List<RiwayatPengirimanModel>?> getRiwayatPengiriman(String id) async {
    final token = AppHelpers.token;

    try {
      final response = await http.get(
        Uri.parse("$_endpoint/riwayat_pengiriman/$id"),
        headers: {"Authorization": "Bearer $token"},
      );
      log("Get riwayat pengiriman:\n${response.body}");
      if (response.statusCode == 200) {
        final riwayat = jsonDecode(response.body)["data"]["riwayat"] as List;
        final listRiwayatPengiriman =
            riwayat.map((e) => RiwayatPengirimanModel.fromJson(e)).toList();
        return listRiwayatPengiriman;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }
}
