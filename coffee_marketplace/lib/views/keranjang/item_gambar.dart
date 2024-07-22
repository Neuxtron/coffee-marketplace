import 'package:coffee_marketplace/views/widgets/error_image.dart';
import 'package:coffee_marketplace/views/widgets/loading_image.dart';
import 'package:flutter/material.dart';

class ItemGambar extends StatelessWidget {
  final String thumbnail;
  const ItemGambar({super.key, required this.thumbnail});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      clipBehavior: Clip.hardEdge,
      child: Image.network(
        thumbnail,
        height: 75,
        width: 75,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return const LoadingImage(
            height: 120,
            width: 120,
          );
        },
        errorBuilder: (context, error, stackTrace) {
          return const ErrorImage(
            height: 120,
            width: 120,
          );
        },
      ),
    );
  }
}
