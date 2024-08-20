import 'package:coffee_marketplace/models/order_model.dart';
import 'package:coffee_marketplace/utils/app_constants.dart';
import 'package:coffee_marketplace/viewmodels/order_view_model.dart';
import 'package:coffee_marketplace/views/_penjual/helpers/status_message.dart';
import 'package:coffee_marketplace/views/widgets/rounded_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PesananItem extends StatelessWidget {
  final OrderModel order;
  const PesananItem({super.key, required this.order});

  Color get _statusColor {
    final status = order.status;
    if (status == "settlement") return Colors.red;

    final greenList = ["dikirim", "diterima"];
    if (greenList.contains(status)) return Colors.green;

    return Colors.grey;
  }

  @override
  Widget build(BuildContext context) {
    final thumbnail = order.keranjang[0].produk.thumbnail;

    return Container(
      clipBehavior: Clip.hardEdge,
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Material(
        color: Color.alphaBlend(Colors.white24, AppConstants.background),
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(
              context,
              "/detail_pesanan",
              arguments: order,
            ).then((_) => context.read<OrderViewModel>().getPesananPenjual());
          },
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 15, 10),
                child: RoundedImage(
                  imageUrl: thumbnail,
                  height: 75,
                  width: 75,
                  radius: 10,
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      order.pembeli!.nama,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      statusMessage[order.status]!,
                      style: TextStyle(
                        color: _statusColor,
                        fontSize: 12,
                      ),
                    )
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(right: 10, left: 5),
                child: Icon(
                  Icons.keyboard_arrow_right,
                  color: Colors.black26,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
