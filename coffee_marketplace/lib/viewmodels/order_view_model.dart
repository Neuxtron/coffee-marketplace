import 'dart:convert';
import 'dart:developer';

import 'package:coffee_marketplace/models/order_model.dart';
import 'package:coffee_marketplace/models/pembayaran_model.dart';
import 'package:coffee_marketplace/utils/app_constants.dart';
import 'package:coffee_marketplace/utils/app_helpers.dart';
import 'package:coffee_marketplace/utils/server_status.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class OrderViewModel extends ChangeNotifier {
  final _endpoint = "${AppConstants.baseUrl}/api/order";

  ServerStatus _status = ServerStatus.normal;
  ServerStatus get status => _status;

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
}
