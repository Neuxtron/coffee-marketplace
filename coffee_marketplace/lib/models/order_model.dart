import 'package:coffee_marketplace/models/metode_bayar_model.dart';

class OrderModel {
  final String id;
  final String status;
  final int subtotal;
  final int ongkir;
  final MetodeBayarModel metodeBayar;
  final Map<String, dynamic> bayarDetails;
  final DateTime expiredAt;

  OrderModel({
    required this.id,
    required this.status,
    required this.subtotal,
    required this.ongkir,
    required this.metodeBayar,
    required this.bayarDetails,
    required this.expiredAt,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    final metodeBayar = json["metodePembayaran"];

    return OrderModel(
      id: json["id"],
      status: json["status"],
      subtotal: json["subtotal"],
      ongkir: json["ongkir"],
      metodeBayar: MetodeBayarModel.fromJson(metodeBayar),
      bayarDetails: json["bayarDetails"],
      expiredAt: DateTime.parse(json["expiredAt"]),
    );
  }
}

final dummyOrder = OrderModel(
  id: "1",
  status: "Pending",
  subtotal: 100000,
  ongkir: 20000,
  metodeBayar: dummyMetodeBayar[3],
  bayarDetails: {
    "Bill Key": "778347787706",
    "Biller Code": "70012",
  },
  expiredAt: DateTime.parse("2024-07-29 04:23:06"),
);
