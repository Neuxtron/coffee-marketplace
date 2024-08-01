class OngkirModel {
  final String nama;
  final String deskripsi;
  final String estimasi;
  final int ongkir;

  OngkirModel({
    required this.nama,
    required this.deskripsi,
    required this.estimasi,
    required this.ongkir,
  });

  factory OngkirModel.fromJson(Map<String, dynamic> json) {
    String estimasi = json["cost"][0]["etd"];
    estimasi = estimasi.replaceAll(" HARI", "");
    estimasi = estimasi.replaceAll(" hari", "");

    return OngkirModel(
      nama: json["service"],
      deskripsi: json["description"],
      estimasi: "$estimasi hari",
      ongkir: json["cost"][0]["value"],
    );
  }
}
