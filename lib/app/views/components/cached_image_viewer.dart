import 'package:flutter/material.dart';

// This class is to be replaced with a network image viewer if the image source is a url

class CachedImageWidget extends StatelessWidget {
  const CachedImageWidget({
    super.key,
    required this.path,
    this.width,
    this.height,
    this.borderRadius,
    this.fit,
  });

  final String path;
  final double? width;
  final double? height;
  final BorderRadiusGeometry? borderRadius;
  final BoxFit? fit;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.zero,
      child: Image.asset(
        path,
        height: height,
        width: width,
        fit: fit ?? BoxFit.cover,
        frameBuilder: (context, child, _, __) {
          return child;
        },
        errorBuilder: (context, url, _) => SizedBox(
          height: height ?? 400,
          width: double.infinity,
          child: const Icon(Icons.error_outline_rounded),
        ),
      ),
    );
  }
}
