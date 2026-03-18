import 'package:belyfted/belyfted.dart';

class ImageWidget extends StatelessWidget {
  const ImageWidget({
    super.key,
    required this.url,
    this.fit = BoxFit.contain,
    this.h,
    this.w,
    this.color,
    this.scale,
    this.placeholder,
  });

  final String? url;
  final BoxFit fit;
  final double? scale;
  final double? h;
  final double? w;
  final Color? color;
  final Widget? placeholder;

  @override
  Widget build(BuildContext context) {
    if (url == null || url!.isEmpty) {
      return placeholder ?? const Icon(Icons.image_not_supported);
    }

    final type = url!._type;

    return switch (type) {
      _ImgType.aPng => ExtendedImage.asset(
        url!,
        height: h,
        width: w,
        fit: fit,
        color: color,
        scale: scale,
      ),
      _ImgType.aSvg => SvgPicture.asset(
        url!,
        height: h,
        width: w,
        fit: fit,
        colorFilter: _colorFilter,
        placeholderBuilder: (_) => placeholder ?? const Icon(Icons.image),
      ),
      _ImgType.nSvg => SvgPicture.network(
        url!,
        height: h,
        width: w,
        fit: fit,
        colorFilter: _colorFilter,
        placeholderBuilder: (_) => placeholder ?? const Icon(Icons.image),
      ),
      _ImgType.nPng => ExtendedImage.network(
        url!,
        height: h,
        width: w,
        fit: fit,
        color: color,
        scale: scale ?? 1,
        cache: true,
        loadStateChanged: (s) => s.extendedImageLoadState == LoadState.failed
            ? placeholder ?? const Icon(Icons.broken_image)
            : null,
      ),
      _ => placeholder ?? const Icon(Icons.image_not_supported),
    };
  }

  ColorFilter? get _colorFilter =>
      color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null;
}

enum _ImgType { nSvg, nPng, aSvg, aPng, base64, none }

extension _ImgTypeExt on String {
  _ImgType get _type {
    if (startsWith('data:image')) return _ImgType.base64;

    final net = startsWith('http') || contains('cloudinary.com');
    final svg = toLowerCase().endsWith('.svg');
    final png = toLowerCase().contains(RegExp(r'\.(png|jpg|jpeg)$'));
    final asset = startsWith('assets/images/');

    if (net) {
      return svg
          ? _ImgType.nSvg
          : png
          ? _ImgType.nPng
          : _ImgType.none;
    }
    if (asset) {
      return svg
          ? _ImgType.aSvg
          : png
          ? _ImgType.aPng
          : _ImgType.none;
    }
    return _ImgType.none;
  }
}
