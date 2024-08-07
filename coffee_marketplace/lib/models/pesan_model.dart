class PesanModel {
  final String id;
  final String penerima;
  final String pengirim;
  final String isi;
  PesanStatus status;
  final String role;
  final DateTime? tglBuat;

  PesanModel({
    required this.id,
    required this.penerima,
    required this.pengirim,
    required this.isi,
    required this.status,
    this.role = "",
    this.tglBuat,
  });

  factory PesanModel.fromJson(Map<String, dynamic> json) {
    return PesanModel(
      id: json["id"],
      penerima: json["penerima"],
      pengirim: json["pengirim"],
      isi: json["isi"],
      status: statusFromJson(json),
      role: json["role"],
      tglBuat: DateTime.parse(json["createdAt"]),
    );
  }

  static PesanStatus statusFromJson(Map<String, dynamic> json) {
    if (json["tglHapus"] != null) return PesanStatus.deleted;
    if (json["tglBaca"] != null) return PesanStatus.read;
    if (json["tglTerkirim"] != null) return PesanStatus.delivered;
    return PesanStatus.sent;
  }
}

enum PesanStatus { pending, failed, sent, read, deleted, delivered }
