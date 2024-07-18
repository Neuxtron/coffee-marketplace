import 'package:coffee_marketplace/utils/app_constants.dart';

class KategoriModel {
  final String id;
  final String icon;
  final String nama;

  KategoriModel({
    required this.id,
    required this.icon,
    required this.nama,
  });

  factory KategoriModel.fromJson(Map<String, dynamic> json) {
    final icon = json["icon"];

    return KategoriModel(
      id: json["id"],
      icon: "${AppConstants.baseUrl}/icons/$icon",
      nama: json["nama"],
    );
  }
}

final List<KategoriModel> dummyListKategori = [
  KategoriModel(id: "1", icon: "assets/icons/ic_coffee.svg", nama: "Coffee"),
  KategoriModel(id: "2", icon: "assets/icons/ic_coffee.svg", nama: "Coffee"),
  KategoriModel(id: "3", icon: "assets/icons/ic_coffee.svg", nama: "Coffee"),
];
