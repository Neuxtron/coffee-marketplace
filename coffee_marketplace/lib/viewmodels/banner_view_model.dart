import 'dart:convert';
import 'dart:developer';

import 'package:coffee_marketplace/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class BannerViewModel extends ChangeNotifier {
  final _endpoint = "${AppConstants.baseUrl}/api/banners";

  List<String> _listBanners = [];
  List<String> get listBanners => _listBanners;

  Future getBanners() async {
    try {
      final response = await http.get(Uri.parse(_endpoint));
      log("Get banners (${response.statusCode}):\n${response.body}");
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body)["data"] as List;
        _listBanners = data.map((e) => e.toString()).toList();
        notifyListeners();
        return;
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
