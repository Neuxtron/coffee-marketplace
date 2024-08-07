class ChatRoomModel {
  final String idUser;
  final String namaUser;
  final String role;

  ChatRoomModel({
    required this.idUser,
    required this.namaUser,
    required this.role,
  });

  factory ChatRoomModel.fromJson(Map<String, dynamic> json) {
    return ChatRoomModel(
      idUser: json["idUser"],
      namaUser: json["namaUser"],
      role: json["role"],
    );
  }
}
