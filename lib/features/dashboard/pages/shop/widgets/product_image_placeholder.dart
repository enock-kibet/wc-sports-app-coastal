import 'package:flutter/material.dart';

class ShopProductImage extends StatelessWidget {
  const ShopProductImage({
    super.key,
    required this.imageUrl,
    required this.width,
    required this.height,
    this.fit = BoxFit.cover,
    this.borderRadius,
    this.placeholderLabel = 'No Image',
  });

  final String imageUrl;
  final double width;
  final double height;
  final BoxFit fit;
  final BorderRadius? borderRadius;
  final String placeholderLabel;

  bool get _hasImage => imageUrl.trim().isNotEmpty;

  @override
  Widget build(BuildContext context) {
    final child = _hasImage
        ? Image.network(
            imageUrl,
            width: width,
            height: height,
            fit: fit,
            errorBuilder: (context, error, stackTrace) =>
                _placeholder(context),
          )
        : _placeholder(context);

    if (borderRadius == null) {
      return child;
    }

    return ClipRRect(
      borderRadius: borderRadius!,
      child: child,
    );
  }

  Widget _placeholder(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: width,
      height: height,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.7),
        borderRadius: borderRadius,
      ),
      child: Text(
        placeholderLabel,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
