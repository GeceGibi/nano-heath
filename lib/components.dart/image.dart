part of 'components.dart';

class AdaptiveImage extends StatelessWidget {
  const AdaptiveImage(
    this.url, {
    this.fit = BoxFit.contain,
    this.backgroundColor,
    this.borderRadius = Constants.borderRadius,
    super.key,
  });

  final String url;
  final BoxFit fit;
  final Color? backgroundColor;
  final BorderRadiusGeometry borderRadius;

  @override
  Widget build(BuildContext context) {
    Widget image = CachedNetworkImage(
      imageUrl: url,
      placeholder: (_, __) => const CircularProgressIndicator.adaptive(),
      errorWidget: (_, __, ___) => const Icon(Icons.error),
      fit: fit,
    );

    if (backgroundColor != null) {
      image = ColoredBox(
        color: backgroundColor!,
        child: image,
      );
    }

    return ClipRRect(
      borderRadius: borderRadius,
      child: image,
    );
  }
}
