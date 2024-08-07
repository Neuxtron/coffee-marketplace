import 'dart:convert';
import 'dart:developer';

import 'package:coffee_marketplace/models/pesan_model.dart';
import 'package:coffee_marketplace/utils/app_constants.dart';
import 'package:coffee_marketplace/utils/app_helpers.dart';
import 'package:coffee_marketplace/utils/server_status.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:coffee_marketplace/models/chat_room_model.dart';

class PesanViewModel extends ChangeNotifier {
  final _endpoint = "${AppConstants.baseUrl}/api/pesan";

  List<PesanModel> _listPesan = [];
  List<String> _listKirim = [];
  List<ChatRoomModel> _listChatRoom = [];
  ServerStatus _status = ServerStatus.normal;
  bool _watchMessages = false;

  List<PesanModel> get listPesan => _listPesan;
  List<ChatRoomModel> get listChatRoom => _listChatRoom;
  ServerStatus get status => _status;

  void onLogout() {
    _listPesan = [];
    _listChatRoom = [];
    _watchMessages = false;
  }

  void onInit() async {
    await getAllMessages();
  }

  int indexById(String id) {
    return _listPesan.indexWhere((pesan) {
      return pesan.id == id;
    });
  }

  List<PesanModel> messagesFromId(String id) {
    return _listPesan.where((pesan) {
      if (pesan.penerima == id) return true;
      if (pesan.pengirim == id) return true;
      return false;
    }).toList();
  }

  PesanModel? lastMessage(String id) {
    final messages = messagesFromId(id);
    if (messages.isEmpty) return null;
    return messages[0];
  }

  int unreadCount(String id) {
    return _listPesan.where((pesan) {
      if (pesan.status != PesanStatus.delivered) return false;
      if (pesan.pengirim == id) return true;
      return false;
    }).length;
  }

  Future readPesan(String idUser) async {
    final token = AppHelpers.token;

    try {
      final response = await http.put(
        Uri.parse("$_endpoint/read"),
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
        body: jsonEncode(
          {"id": idUser},
        ),
      );
      log("Read pesan:\n${response.body}");
      for (var pesan in _listPesan) {
        if (pesan.pengirim == idUser) {
          pesan.status = PesanStatus.read;
        }
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future getChatRooms() async {
    final token = AppHelpers.token;
    _status = ServerStatus.loading;
    notifyListeners();

    try {
      final response = await http.get(
        Uri.parse("$_endpoint/chatrooms"),
        headers: {"Authorization": "Bearer $token"},
      );
      log("Get chatrooms:\n${response.body}");
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body)["data"] as List;
        _listChatRoom = data.map((e) => ChatRoomModel.fromJson(e)).toList();
        _status = ServerStatus.normal;
        notifyListeners();
        return;
      }
      _status = ServerStatus.error;
      notifyListeners();
    } catch (e) {
      log(e.toString());
      _status = ServerStatus.error;
      notifyListeners();
    }
  }

  Future getAllMessages() async {
    final token = AppHelpers.token;
    _status = ServerStatus.loading;
    notifyListeners();

    try {
      final response = await http.get(
        Uri.parse(_endpoint),
        headers: {"Authorization": "Bearer $token"},
      );
      log("Get all messages:\n${response.body}");
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body)["data"] as List;
        _listPesan = data.map((e) => PesanModel.fromJson(e)).toList();

        _watchMessages = true;
        getNewMessages();
      }
    } catch (e) {
      log(e.toString());
    }

    _status = ServerStatus.normal;
    notifyListeners();
  }

  Future getNewMessages() async {
    if (!_watchMessages) return;
    final token = AppHelpers.token;

    try {
      log("Checking messages...");
      final response = await http.put(
        Uri.parse("$_endpoint/new_messages"),
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
        body: jsonEncode({"listKirim": _listKirim}),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body)["data"] as List;
        List<PesanModel> listPesanBaru = [];

        bool update = false;
        for (var json in data) {
          final pesanBaru = PesanModel.fromJson(json);
          if (_listPesan.any((pesan) => pesan.id == pesanBaru.id)) {
            final index = indexById(pesanBaru.id);
            if (_listPesan[index].status != pesanBaru.status) update = true;
            if (pesanBaru.status == PesanStatus.delivered ||
                pesanBaru.status == PesanStatus.read) {
              _listKirim.remove(pesanBaru.id);
            }
            _listPesan[index] = pesanBaru;
          } else {
            listPesanBaru.add(pesanBaru);
          }
        }

        if (listPesanBaru.isNotEmpty || update) notifyListeners();
        if (listPesanBaru.isNotEmpty) {
          _listPesan.insertAll(0, listPesanBaru);
          getChatRooms();
          log("Found ${listPesanBaru.length} messages");
        }
      } else {
        log(response.body);
      }
    } catch (e) {
      log(e.toString());
    }
    await Future.delayed(const Duration(seconds: 1));
    getNewMessages();
  }

  Future kirimPesan(PesanModel pesan) async {
    final token = AppHelpers.token;

    _listPesan.insert(0, pesan);
    _status = ServerStatus.loading;
    notifyListeners();

    try {
      final response = await http.post(
        Uri.parse("$_endpoint/send"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode({
          "penerima": pesan.penerima,
          "isi": pesan.isi,
        }),
      );
      log("Kirim pesan:\n${response.body}");

      final index = indexById(pesan.id);
      if (response.statusCode == 201) {
        final data = jsonDecode(response.body)["data"];
        final pesan = PesanModel.fromJson(data);
        _listPesan[index] = pesan;
        _listKirim.add(pesan.id);
      } else {
        _listPesan[index].status = PesanStatus.failed;
      }
    } catch (e) {
      log(e.toString());
      final index = indexById(pesan.id);
      _listPesan[index].status = PesanStatus.failed;
    }
    _status = ServerStatus.normal;
    notifyListeners();
  }
}
