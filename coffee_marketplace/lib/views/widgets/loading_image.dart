import 'package:flutter/material.dart';

class LoadingImage extends StatelessWidget {
  final double? height;
  final double? width;

  const LoadingImage({
    super.key,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: const EdgeInsets.all(10),
      color: Colors.white,
      child: const Center(
        child: Text(
          "Loading...",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 10),
        ),
      ),
    );
  }
}
