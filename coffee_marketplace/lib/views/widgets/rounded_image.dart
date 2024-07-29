import 'package:flutter/material.dart';
import 'error_image.dart';
import 'loading_image.dart';

class RoundedImage extends StatelessWidget {
  final String imageUrl;
  final double height;
  final double width;
  final double radius;

  const RoundedImage({
    super.key,
    required this.imageUrl,
    required this.height,
    required this.width,
    required this.radius,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      clipBehavior: Clip.hardEdge,
      child: Image.network(
        imageUrl,
        height: height,
        width: width,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return LoadingImage(
            height: height,
            width: width,
          );
        },
        errorBuilder: (context, error, stackTrace) {
          return ErrorImage(
            height: height,
            width: width,
          );
        },
      ),
    );
  }
}
