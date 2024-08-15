import 'package:coffee_marketplace/models/keranjang_model.dart';
import 'package:coffee_marketplace/models/metode_bayar_model.dart';

class OrderModel {
  final String id;
  final String status;
  final String statusMessage;
  final int subtotal;
  final int ongkir;
  final MetodeBayarModel metodeBayar;
  final Map<String, dynamic> bayarDetails;
  final DateTime expiredAt;
  final List<KeranjangModel> keranjang;

  OrderModel({
    required this.id,
    required this.status,
    required this.statusMessage,
    required this.subtotal,
    required this.ongkir,
    required this.metodeBayar,
    required this.bayarDetails,
    required this.expiredAt,
    required this.keranjang,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    final metodeBayar = json["metodePembayaran"];

    return OrderModel(
      id: json["id"],
      status: json["status"],
      statusMessage: json["statusMessage"],
      subtotal: json["subtotal"],
      ongkir: json["ongkir"],
      metodeBayar: MetodeBayarModel.fromJson(metodeBayar),
      bayarDetails: json["bayarDetails"],
      expiredAt: DateTime.parse(json["expiredAt"]),
      keranjang: json["keranjang"],
    );
  }
}
