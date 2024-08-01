import 'package:coffee_marketplace/models/ongkir_model.dart';

class KurirModel {
  final String id;
  final String nama;
  final String imgUrl;
  List<OngkirModel>? listOngkir;

  KurirModel({
    required this.id,
    required this.nama,
    required this.imgUrl,
  });
}

final dummyKurir = [
  KurirModel(
    id: "jne",
    nama: "JNE",
    imgUrl:
        "https://i.pinimg.com/originals/cf/9c/18/cf9c18d97b5b7bb116cc99e1c93afcff.png",
  ),
  KurirModel(
    id: "pos",
    nama: "POS",
    imgUrl: "https://logowik.com/content/uploads/images/pos-indonesia2325.jpg",
  ),
  KurirModel(
    id: "tiki",
    nama: "TIKI",
    imgUrl:
        "https://i.pinimg.com/originals/67/a6/8b/67a68bfa8a2b26d34191b8c7e01af02f.png",
  ),
];
