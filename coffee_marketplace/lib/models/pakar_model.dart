class PakarModel {
  final String id;
  final String nama;

  PakarModel({
    required this.id,
    required this.nama,
  });

  factory PakarModel.fromJson(Map<String, dynamic> json) {
    return PakarModel(
      id: json["id"],
      nama: json["nama"],
    );
  }
}
