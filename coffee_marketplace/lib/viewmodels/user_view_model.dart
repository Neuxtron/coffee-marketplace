import 'dart:convert';
import 'dart:developer';

import 'package:coffee_marketplace/models/ubah_password_model.dart';
import 'package:coffee_marketplace/models/user_model.dart';
import 'package:coffee_marketplace/utils/app_constants.dart';
import 'package:coffee_marketplace/utils/app_helpers.dart';
import 'package:coffee_marketplace/utils/server_status.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserViewModel extends ChangeNotifier {
  final _endpoint = "${AppConstants.baseUrl}/api";
  UserModel? _currentUser;
  String? _token;
  ServerStatus _status = ServerStatus.normal;
  String _error = "";
  UbahPasswordModel? ubahPasswordModel;

  UserModel? get currentUser => _currentUser;
  String? get token => _token;
  ServerStatus get status => _status;
  String get error => _error;

  set token(String? newToken) => _setToken(newToken);

  Future register(UserModel user) async {
    if (_status == ServerStatus.loading) return;
    _status = ServerStatus.loading;
    _error = "";
    notifyListeners();

    try {
      final response = await http.post(
        Uri.parse("$_endpoint/register"),
        headers: {
          "Content-Type": "application/json",
        },
        body: user.toJson(),
      );
      log("Register user:\n${response.body}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body)["data"];
        _currentUser = UserModel.fromJson(data);
        token = data["token"];
        _status = ServerStatus.normal;
        notifyListeners();
      } else {
        _status = ServerStatus.error;
        _error = jsonDecode(response.body)["message"];
        notifyListeners();
      }
    } catch (e) {
      log(e.toString());
      _status = ServerStatus.error;
      _error = "Terjadi kesalahan, silahkan coba lagi";
      notifyListeners();
    }
  }

  Future login(String email, String password) async {
    if (_status == ServerStatus.loading) return;
    _status = ServerStatus.loading;
    _error = "";
    notifyListeners();

    try {
      final response = await http.post(
        Uri.parse("$_endpoint/login"),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "email": email,
          "password": password,
        }),
      );
      log("Login user:\n${response.body}");
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body)["data"];
        _currentUser = UserModel.fromJson(data);
        token = data["token"];
        _status = ServerStatus.normal;
        notifyListeners();
      } else {
        _status = ServerStatus.error;
        _error = jsonDecode(response.body)["message"];
        notifyListeners();
      }
    } catch (e) {
      log(e.toString());
      _status = ServerStatus.error;
      _error = "Terjadi kesalahan, silahkan coba lagi";
      notifyListeners();
    }
  }

  Future<bool?> getProfile() async {
    if (_status == ServerStatus.loading) return null;
    _status = ServerStatus.loading;
    _error = "";
    notifyListeners();

    try {
      final response = await http.get(
        Uri.parse("$_endpoint/profile"),
        headers: {
          "Authorization": "Bearer $_token",
        },
      );
      log("Get profil:\n${response.body}");
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body)["data"];
        _currentUser = UserModel.fromJson(data);
      } else {
        logout();
      }
      _status = ServerStatus.normal;
      notifyListeners();
      return true;
    } catch (e) {
      log(e.toString());
      _status = ServerStatus.error;
      _error = "Terjadi kesalahan, silahkan coba lagi";
      notifyListeners();
    }

    return false;
  }

  Future updateProfil(UserModel user) async {
    if (_status == ServerStatus.loading) return;
    _status = ServerStatus.loading;
    _error = "";
    notifyListeners();

    try {
      final response = await http.put(
        Uri.parse("$_endpoint/"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $_token",
        },
        body: user.toJson(),
      );
      log("Update user:\n${response.body}");

      if (response.statusCode == 200) {
        _currentUser = user;
        _status = ServerStatus.normal;
        notifyListeners();
      } else {
        _status = ServerStatus.error;
        _error = jsonDecode(response.body)["message"];
        notifyListeners();
      }
    } catch (e) {
      log(e.toString());
      _status = ServerStatus.error;
      _error = "Terjadi kesalahan, silahkan coba lagi";
      notifyListeners();
    }
  }

  Future<bool> logout() async {
    try {
      final response = await http.get(
        Uri.parse("$_endpoint/logout"),
        headers: {
          "Authorization": "Bearer $_token",
        },
      );
      log("Logout user:\n${response.body}");
      token = null;
      _currentUser = null;
      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      log(e.toString());
    }
    token = null;
    _currentUser = null;
    return false;
  }

  Future<String> requestUbahPassword(String email) async {
    _status = ServerStatus.loading;
    notifyListeners();
    String error = "";

    try {
      final response = await http.post(
        Uri.parse("$_endpoint/request_ubah_password"),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({"email": email}),
      );
      log("Request ubah password:\n${response.body}");
      if (response.statusCode == 200) {
        ubahPasswordModel = UbahPasswordModel(email: email);
      } else {
        error = jsonDecode(response.body)["message"];
      }
    } catch (e) {
      log(e.toString());
      error = "Terjadi kesalahan, silahkan coba lagi";
    }
    _status = ServerStatus.normal;
    notifyListeners();
    return error;
  }

  Future<String> checkOTP(int kodeOTP) async {
    _status = ServerStatus.loading;
    notifyListeners();
    String error = "";

    try {
      ubahPasswordModel!.kodeOTP = kodeOTP;
      final response = await http.post(
        Uri.parse("$_endpoint/check_otp"),
        headers: {
          "Content-Type": "application/json",
        },
        body: ubahPasswordModel!.toJson(),
      );
      log("Check otp:\n${response.body}");
      if (response.statusCode != 200) {
        error = jsonDecode(response.body)["message"];
      }
    } catch (e) {
      log(e.toString());
      error = "Terjadi kesalahan, silahkan coba lagi";
    }
    _status = ServerStatus.normal;
    notifyListeners();
    return error;
  }

  Future<String> ubahPasswordOTP(String password) async {
    _status = ServerStatus.loading;
    notifyListeners();
    String error = "";

    try {
      ubahPasswordModel!.password = password;
      final response = await http.post(
        Uri.parse("$_endpoint/ubah_password_otp"),
        headers: {
          "Content-Type": "application/json",
        },
        body: ubahPasswordModel!.toJson(),
      );
      log("Ubah password otp:\n${response.body}");
      if (response.statusCode != 200) {
        error = jsonDecode(response.body)["message"];
      }
    } catch (e) {
      log(e.toString());
      error = "Terjadi kesalahan, silahkan coba lagi";
    }

    _status = ServerStatus.normal;
    notifyListeners();
    return error;
  }

  Future<String?> ubahPassword(String passwordLama, String passwordBaru) async {
    _status = ServerStatus.loading;
    notifyListeners();
    String? error;

    try {
      final response = await http.put(
        Uri.parse("$_endpoint/ubah_password"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $_token",
        },
        body: jsonEncode({
          "passwordLama": passwordLama,
          "password": passwordBaru,
        }),
      );
      log("Ubah password:\n${response.body}");
      if (response.statusCode != 200) {
        error = jsonDecode(response.body)["message"];
      }
    } catch (e) {
      log(e.toString());
      error = "Terjadi kesalahan, silahkan coba lagi";
    }

    _status = ServerStatus.normal;
    notifyListeners();
    return error;
  }

  Future<bool> requestKonfirmasiEmail() async {
    _status = ServerStatus.loading;
    notifyListeners();
    bool success = true;

    try {
      final response = await http.put(
        Uri.parse("$_endpoint/request_konfirmasi_email"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $_token",
        },
      );
      log("Request konfirmasi email:\n${response.body}");
      if (response.statusCode != 200) success = false;
    } catch (e) {
      log(e.toString());
      success = false;
    }
    _status = ServerStatus.normal;
    notifyListeners();
    return success;
  }

  Future<String?> konfirmasiEmail(String kode) async {
    _status = ServerStatus.loading;
    notifyListeners();
    String? error;

    try {
      final response = await http.put(
        Uri.parse("$_endpoint/konfirmasi_email"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $_token",
        },
        body: jsonEncode({"kodeKonfirmasi": kode}),
      );
      log("Konfirmasi email:\n${response.body}");
      if (response.statusCode == 200) {
        getProfile();
      } else {
        error = jsonDecode(response.body)["message"];
      }
    } catch (e) {
      log(e.toString());
      error = "Terjadi kesalahan, silahkan coba lagi";
    }

    _status = ServerStatus.normal;
    notifyListeners();
    return error;
  }

  Future authCheck() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("TOKEN");
    if (token == null) {
      log("Token: NO TOKEN");
      return;
    }
    log("Token: $token");
    AppHelpers.token = token;
    _token = token;
    getProfile();
  }

  void _setToken(String? token) async {
    AppHelpers.token = token;
    _token = token;
    final prefs = await SharedPreferences.getInstance();
    if (token == null) {
      prefs.remove("TOKEN");
    } else {
      prefs.setString("TOKEN", token);
    }

    notifyListeners();
  }
}
